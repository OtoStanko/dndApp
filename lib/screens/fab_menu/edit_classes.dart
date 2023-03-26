import 'package:firstapp/db/models/class_model.dart';
import 'package:firstapp/widgets/add_class_modal.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../db/database.dart';

class EditClasses extends StatefulWidget {
  const EditClasses({super.key});

  @override
  State<EditClasses> createState() => _EditClassesState();
}

class _EditClassesState extends State<EditClasses> {
  // Database
  late Future<Database> futureDB;
  bool _loading = false;

  @override
  initState() {
    super.initState();
    futureDB = _initDB();
  }

  Future<Database> _initDB() async {
    var db = Database();
    await db.initDB();
    return db;
  }

  @override
  Widget build(BuildContext context) {
    // List all features
    return FutureBuilder(
        future: futureDB,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator.adaptive();
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          Database db = snapshot.data as Database;

          return Scaffold(
              body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.arrow_back)),
                              const Text("Edit Classes",
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w100)),
                            ])),
                    if (_loading)
                      const Center(child: CircularProgressIndicator.adaptive())
                    else
                      _buildFeatureList(db),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _removeAllClasses(db),
                          _addClass(db),
                          _loadFromAPI(db)
                        ])
                  ],
                )),
          ));
        });
  }

  Widget _addClass(Database db) {
    return AddClassModal(onSuccessfulSubmit: (Class newClass) async {
      setState(() {
        _loading = true;
      });
      Navigator.pop(context);
      await db.insertClass(newClass);
      setState(() {
        _loading = false;
      });
    });
  }

  Widget _removeAllClasses(Database db) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        onPressed: () async {
          //Show confirmation dialog
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    title: const Text("Remove all classes"),
                    content: const Text(
                        "Are you sure you want to remove all classes? This will remove all classes that are not assigned to any characters."),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                      TextButton(
                          onPressed: () async {
                            setState(() {
                              _loading = true;
                            });
                            Navigator.pop(context);
                            await db.deleteAllClasses();
                            setState(() {
                              _loading = false;
                            });
                          },
                          child: const Text("Remove all classes"))
                    ]);
              });
        },
        child: const Text("Remove all classes"));
  }

  Widget _loadFromAPI(Database db) {
    return ElevatedButton(
        onPressed: () async {
          // Show confirmation dialog
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    title: const Text("Load from API"),
                    content: const Text(
                        "Are you sure you want to load classes from API? This will remove all existing classes."),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                      TextButton(
                          onPressed: () async {
                            setState(() {
                              _loading = true;
                            });
                            Navigator.pop(context);
                            await db.updateClassTable();
                            setState(() {
                              _loading = false;
                            });
                          },
                          child: const Text("Load from API"))
                    ]);
              });
        },
        child: const Text("Load from API"));
  }

  Widget _buildFeatureList(Database db) {
    return FutureBuilder(
        future: db.getAllClasses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator.adaptive();
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          List<Class> classes = snapshot.data as List<Class>;

          if (classes.isEmpty) {
            return const Center(child: Text("No classes found :("));
          }

          return SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: classes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(
                            "${classes[index].className} D${classes[index].classHitDie}"),
                        trailing: IconButton(
                            onPressed: () {
                              //db.deleteFeature(features[index].id);
                              // Show confirmation dialog
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                        title: const Text("Delete class"),
                                        content: Text(
                                            "Are you sure you want to delete ${classes[index].className} class?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Cancel")),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                db
                                                    .deleteClass(classes[index])
                                                    .then((value) => {
                                                          if (value)
                                                            {
                                                              // Show notification that class was deleted
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                          content:
                                                                              Text("${classes[index].className} class was deleted.")))
                                                            }
                                                          else
                                                            {
                                                              // Show notification that class was not deleted
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                          content:
                                                                              Text("${classes[index].className} class was not deleted. This class is assigned to at least one character.")))
                                                            }
                                                        })
                                                    .then((value) => {
                                                          setState(() {
                                                            futureDB =
                                                                _initDB();
                                                          })
                                                        });
                                              },
                                              child: const Text("Delete"))
                                        ]);
                                  });
                            },
                            icon: const Icon(Icons.delete)));
                  }));
        });
  }
}