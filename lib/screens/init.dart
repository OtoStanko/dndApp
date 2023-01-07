import 'package:firstapp/db/database.dart';
import 'package:firstapp/screens/character_list.dart';
import 'package:firstapp/screens/welcome_screen.dart';
import 'package:firstapp/widgets/changing_text.dart';
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

  Future<void> _init() async {
    await db.initDB();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('firstRun', false);
    await prefs.setString('name', 'Oto');
    await prefs.setString('version', '0.0.1');

    await Future.delayed(const Duration(seconds: 0));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingScreen();
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const Scaffold(
              body: SafeArea(
                  child: WelcomeScreen()));
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
