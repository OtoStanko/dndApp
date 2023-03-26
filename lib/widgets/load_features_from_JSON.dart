import 'package:flutter/material.dart';

import '../db/database.dart';

class LoadFeaturesFromJSON extends StatefulWidget {
  const LoadFeaturesFromJSON({super.key});

  @override
  State<LoadFeaturesFromJSON> createState() => _LoadFeaturesFromJSONState();
}

class _LoadFeaturesFromJSONState extends State<LoadFeaturesFromJSON> {
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
}
