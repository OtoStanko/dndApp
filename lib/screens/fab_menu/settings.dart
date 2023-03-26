import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/dump_data_to_JSON.dart';
import '../../widgets/load_data_from_JSON.dart';

class Preferences {
  String name;
  String version = '1.0.0';

  Preferences({required this.name, required this.version});
}


class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<Preferences> getPreferences(SharedPreferences preferences) async {
    final name = preferences.getString('name') ?? "";
    final version = preferences.getString('version') ?? "-1";
    return Preferences(name: name, version: version);
  }

  Future<void> saveName(SharedPreferences preferences, String name) async {
    await preferences.setString('name', name);
    // close keyboard
    FocusScope.of(context).unfocus();
    // show snackbar
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Name saved ${preferences.get('name')}"),
        duration: const Duration(seconds: 1)));
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final preferences = arguments['preferences'];
    return FutureBuilder(
        future: getPreferences(preferences),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator.adaptive();
          }
          if (snapshot.hasError || snapshot.data == null) {
            return Text(snapshot.error.toString());
          }
          Preferences loadedPreferences = snapshot.data as Preferences;

          return Scaffold(
              body: SafeArea(
                  child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: ListView(shrinkWrap: true, children: [
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
                                const Text("Settings",
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w100)),
                              ],
                            )),

                        // Form with input that sets the name in shared preferences
                        Form(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Introductory name"),
                            TextFormField(
                              initialValue: loadedPreferences.name,
                              onChanged: (value) {
                                loadedPreferences.name = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your name";
                                }
                                if (value.length > 15) {
                                  return "Name must be less than 15 characters";
                                }
                                return null;
                              },
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  saveName(preferences, loadedPreferences.name);
                                },
                                child: const Text("Save"))
                          ],
                        )),
                        // Credits section
                        LoadDataFromJSON(),
                        DumpDataToJSON(),
                        Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text("Credits",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w100))
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(top: 10),
                            // Created by: Matej Hakoš, Oto Stanko
                            child: Column(children: [
                              Text("Version: ${loadedPreferences.version}"),
                              const Text("Created by: Matej Hakoš, Oto Stanko"),
                              const Text("2023"),
                            ])),
                      ]))));
        });
  }
}
