import 'package:firstapp/db/database.dart';
import 'package:firstapp/screens/welcome_screen.dart';
import 'package:firstapp/widgets/changing_text.dart';
import 'package:firstapp/widgets/floating_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
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
    await _prefs.setBool('firstRun', true);
    await _prefs.setString('version', '0.0.1');

    if (!kDebugMode) {
      await Future.delayed(const Duration(seconds: 3));
    } 

    // Init permissions
    await Permission.storage.request();
  }

  @override
  void initState() {
    super.initState();
    futureInit = _init();
    futureInit.then((value) => {
          // Check if first_run is false, if not show intro screen
          if (_prefs.getBool('firstRun') ?? false)
            {
              // Start intro screen as soon as possible
              Navigator.pushNamed(context, '/intro-screen').then((value) => 
                // Set first_run to false
                _prefs.setBool('firstRun', false))
                // Refresh screen
                .then((value) => setState(() {
                      // Reload app
                      futureInit = _init();
                      // Set first_run to false
                      _prefs.setBool('firstRun', false);
                }))
            }
        });
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
              floatingActionButton: FloatingMenu(
                  preferences: _prefs,
                  onPreferencesUpdate: () {
                    setState(() {
                      // Reload app
                      futureInit = _init();
                    });
                  }),
              body: SafeArea(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: const WelcomeScreen())));
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
