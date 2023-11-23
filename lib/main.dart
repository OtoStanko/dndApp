import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/common/services/character_service.dart';
import 'package:firstapp/common/services/flutter_service.dart';
import 'package:firstapp/common/widgets/page_wrapper.dart';
import 'package:firstapp/dashboard/dashboard_page.dart';
import 'package:firstapp/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Services registration
  GetIt.I.registerSingleton<FirebaseService>(FirebaseService());
  GetIt.I.registerSingleton<CharacterService>(CharacterService());

  runApp(const MaterialApp(
      title: 'DnD App',
      home: PageWrapper(
        child: DashboardPage(),
      )));
}
