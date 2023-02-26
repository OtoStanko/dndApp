import 'package:firstapp/screens/character_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name') ?? 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getName(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator.adaptive();
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Column(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Text('Welcome back, ${snapshot.data.toString()}!',
                          style: const TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w100))),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: CharacterList()),
            ],
          );
        });
  }
}
