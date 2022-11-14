import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firstapp/db/database.dart';
import 'package:firstapp/screens/character_list.dart';
import 'package:firstapp/widgets/changing_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lottie/lottie.dart';

class Init extends StatefulWidget {
  const Init({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Init();
}

class _Init extends State<Init> {
  bool _loading = true;

  _Init() {
    Future(() async {
      // Init all async stuff then remove loading screen
      await Database().initDB();
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: loadingScreen(),
        splashIconSize: 250,
        //duration: 0,
        nextScreen: const CharacterList(),
        // disableNavigation: _loading, // This does not work!
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.rightToLeft);
  }
}

loadingScreen() {
  return Column(
    children: [
      Lottie.asset('assets/skydive.json', height: 200),
      const ChangingText()
    ],
  );
}
