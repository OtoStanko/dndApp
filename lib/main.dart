import 'package:firstapp/screens/fab_menu/edit_classes.dart';
import 'package:firstapp/screens/fab_menu/edit_features.dart';
import 'package:firstapp/screens/init.dart';
import 'package:firstapp/screens/fab_menu/settings.dart';
import 'package:firstapp/screens/intro_screen.dart';
import 'package:firstapp/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      '/': (context) => const Init(),
      '/welcome': (context) => const WelcomeScreen(),
      '/editClasses': (context) => const EditClasses(),
      '/editFeatures': (context) => const EditFeatures(), 
      '/settings': (context) => const Settings(),
      '/intro-screen': (context) => const IntroScreen(),
    });
  }
}
