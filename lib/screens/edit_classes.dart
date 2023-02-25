import 'package:firstapp/db/models/class_model.dart';
import 'package:flutter/material.dart';

import '../db/database.dart';
import '../db/models/feature_model.dart';

class EditClasses extends StatefulWidget {
  const EditClasses({super.key});

  @override
  State<EditClasses> createState() => _EditClassesState();
}

class _EditClassesState extends State<EditClasses> {
  // Database
  late Future<Database> futureDB;

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
                padding: const EdgeInsets.all(8),
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
                    _buildFeatureList(db),
                    _loadFromAPI(db)
                  ],
                )),
          ));
        });
  }

  Widget _loadFromAPI(Database db) {
    return ElevatedButton(
        onPressed: () async {
          await db.updateClassTable();
          setState(() {});
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
          return SizedBox(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: classes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(classes[index].className),
                        trailing: IconButton(
                            onPressed: () {
                              //db.deleteFeature(features[index].id);
                              // Show confirmation dialog
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                        title: const Text("Delete feature"),
                                        content: const Text(
                                            "Are you sure you want to delete this feature?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Cancel")),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
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
