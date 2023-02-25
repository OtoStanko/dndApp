import 'package:firstapp/db/database.dart';
import 'package:firstapp/screens/welcome_screen.dart';
import 'package:firstapp/widgets/changing_text.dart';
import 'package:firstapp/widgets/floating_menu.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Init extends StatefulWidget {
  const Init({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Init();
}

class _Init extends State<Init> {
  Database db = Database();
  late SharedPreferences _prefs;
  late Future<void> futureInit;

  Future<void> _init() async {
    await db.initDB();
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool('firstRun', false);
    //await _prefs.setString('name', 'Oto');
    await _prefs.setString('version', '0.0.1');

    await Future.delayed(const Duration(seconds: 3));
  }

  @override
  void initState() {
    super.initState();
    futureInit = _init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureInit,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingScreen();
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Scaffold(
              floatingActionButton: FloatingMenu(preferences: _prefs, onPreferencesUpdate: () {
                setState(() {
                  // Reload app
                  futureInit = _init();
                });
              }),
              body: const SafeArea(child: WelcomeScreen()));
        });
  }
}

loadingScreen() {
  return Scaffold(
      body: Center(
          child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Lottie.asset('assets/skydive.json', height: 200),
      const ChangingText()
    ],
  )));
}
