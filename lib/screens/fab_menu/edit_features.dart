import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:firstapp/db/database.dart';
import 'package:firstapp/db/models/feature_model.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../db/models/class_model.dart';

class EditFeatures extends StatefulWidget {
  const EditFeatures({super.key});

  @override
  State<EditFeatures> createState() => _EditFeaturesState();
}

class _EditFeaturesState extends State<EditFeatures> {
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
            body: Padding(
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
                              const Text("Edit Features",
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
                          //_loadFromAPI(db),
                          _loadFeaturesFromJSON(db)
                        ])
                  ],
                )),
          );
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
                    title: const Text("Remove all features"),
                    content: const Text(
                        "Are you sure you want to remove all features? This will remove all features that are not assigned to any characters."),
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
                            await db.deleteAllFeatures();
                            setState(() {
                              _loading = false;
                            });
                          },
                          child: const Text("Remove all features"))
                    ]);
              });
        },
        child: const Text("Remove all features"));
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
                        "Are you sure you want to load features from API? This will remove all existing features."),
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
                            await db.updateFeatureTable();
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

  Widget _loadFeaturesFromJSON(Database db) {
    return ElevatedButton(
        onPressed: () async {
          // Show confirmation dialog
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    title: const Text("Load from JSON"),
                    content: const Text(
                        "Are you sure you want to load features from JSON? This will append features from JSON to the existing features."),
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

                            // Check permissions for reading from Downloads folder
                            if (await Permission.storage.request().isDenied ||
                                await Permission.storage
                                    .request()
                                    .isPermanentlyDenied) {
                              setState(() {
                                _loading = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Permission to read from Downloads folder denied")));
                              return;
                            }

                            // Load features.json from Downloads folder
                            Directory downloadsDirectory =
                                Directory("/storage/emulated/0/Download");
                            List<FileSystemEntity> files =
                                downloadsDirectory.listSync();
                            File? file;
                            for (FileSystemEntity f in files) {
                                    if (f.path.endsWith("features.json")) {
                                      file = f as File;
                                      break;
                                    }
                            }

                            if (file == null || !file.existsSync()) {
                              setState(() {
                                _loading = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "features.json not found in Downloads folder")));
                              return;
                            }

                            String featureFileText = file.readAsStringSync();
                            await db.featureAppend(featureFileText);
                            setState(() {
                              _loading = false;
                            });
                          },
                          child: const Text("Load from JSON"))
                    ]);
              });
        },
        child: const Text("Load from JSON"));
  }

  Widget _buildFeatureList(Database db) {
    return FutureBuilder(
        future: db.getAllFeatures(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator.adaptive();
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          List<Feature> features = snapshot.data as List<Feature>;
          return SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: features.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onLongPress: () async {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    title: const Text("Delete feature"),
                                    content: Text(
                                        "Are you sure you want to delete '${features[index].featureName}'?"),
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
                                            await db
                                                .deleteFeature(features[index])
                                                .then((value) => {
                                                      // Show confirmation notifications
                                                      if (value)
                                                        {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(SnackBar(
                                                                  content: Text(
                                                                      "Feature '${features[index].featureName}' deleted successfully")))
                                                        }
                                                      else
                                                        {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(SnackBar(
                                                                  content: Text(
                                                                      "Feature '${features[index].featureName}' could not be deleted. This feature is assigned to one or more characters.")))
                                                        }
                                                    });
                                            setState(() {
                                              _loading = false;
                                            });
                                          },
                                          child: const Text("Delete"))
                                    ]);
                              });
                        },
                        child: ExpandablePanel(
                          header: Text(features[index].featureName,
                              style: const TextStyle(
                                fontSize: 20,
                              )),
                          collapsed: Container(),
                          expanded: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Center(
                                  child: Column(children: [
                                Text(features[index].featureDescription),
                                Text(
                                    "Level acquired: ${features[index].featureLevelAcquire}"),
                              ]))),
                        ));
                  }));
        });
  }

  // Get class name from class id
  Future<String> _getClassName(int classId, Database db) async {
    Class classObj = await db.getClassById(classId);
    return classObj.className;
  }
}
