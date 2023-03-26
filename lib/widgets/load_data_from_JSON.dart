import 'dart:io';

import 'package:flutter/material.dart';

import '../db/database.dart';

class LoadDataFromJSON extends StatefulWidget {
  const LoadDataFromJSON({super.key});

  @override
  State<LoadDataFromJSON> createState() => _LoadDataFromJSONState();
}

class _LoadDataFromJSONState extends State<LoadDataFromJSON> {
  late Future<Database> futureDb;

  Future<Database> _init() async {
    Database dbInit = Database();
    await dbInit.initDB();
    return dbInit;
  }

  @override
  void initState() {
    super.initState();
    futureDb = _init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureDb,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          Database db = snapshot.data as Database;
          return Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text("Load DB from JSON",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w100))
                    ],
                  )),
              const Text(
                  "Warning this is very early WIP! Loading data from JSON will overwrite the current database. The JSON is converted to a database and then the database is loaded into the app. This is a one-way process."),
              ElevatedButton(
                  onPressed: () async {
                    // Show notification that the database is being loaded
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Looking for database file in Downloads..."),
                        duration: Duration(seconds: 1)));
                    // Pick the JSON file
                    Directory downloadsDirectory = Directory("/storage/emulated/0/Download");
                    List<FileSystemEntity> files = downloadsDirectory.listSync();
                    File? jsonFile;
                    for (FileSystemEntity file in files) {
                      if (file.path.endsWith("database.json")) {
                        jsonFile = file as File;
                        break;
                      }
                    }
                    if (jsonFile == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("No database file found in Downloads."),
                          duration: Duration(seconds: 1)));
                      return;
                    }
                    // Load the JSON file
                    String json = await jsonFile.readAsString();
                    // Load the database
                    await db.loadDatabaseFromJSON(json);
                    // Show notification that the database has been loaded
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Database loaded from JSON."),
                        duration: Duration(seconds: 1)));
                  },
                  child: const Text("Load DB from JSON"))
            ],
          );
        });
  }
}
