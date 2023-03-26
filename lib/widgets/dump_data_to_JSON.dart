import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../db/database.dart';

class DumpDataToJSON extends StatefulWidget {
  const DumpDataToJSON({super.key});

  @override
  State<DumpDataToJSON> createState() => _DumpDataToJSONState();
}

class _DumpDataToJSONState extends State<DumpDataToJSON> {
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
                      Text("Dump DB to JSON",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w100))
                    ],
                  )),
              const Text(
                  "Warning this is very early WIP! This will dump the current database to a JSON file. The JSON file can be loaded into the app using the 'Load DB from JSON' button. The file name will be 'database.json'."),
              ElevatedButton(
                  onPressed: () async {
                    // Show notification that the database is being dumped
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Dumping database to JSON..."),
                        duration: Duration(seconds: 1)));
                    await saveData(await db.dumpDatabaseToJSON());
                    // Show notification that the database has been dumped
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Database dumped to JSON"),
                        duration: Duration(seconds: 1)));
                  },
                  child: const Text("Dump")),
            ],
          );
        });
  }

  Future<void> saveData(String data) async {
    Directory dir = Directory('/storage/emulated/0/Download');
    
    final filePath = "${dir.path}/database.json";

    await File(filePath).writeAsString(data);
  }
}
