import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  String name = '';
  List<PageViewModel> pages = [];

  @override
  void initState() {
    setState(() {
      name = '';
      pages = [
        PageViewModel(
          title: "Welcome to our D&D app!",
          body: "This app is designed to help you manage your D&D characters. "
              "You can create characters, edit their features, and even create "
              "your own custom features. You can also create custom classes, "
              "and even edit the features of the default classes!",
          image: const Center(
            child: Icon(Icons.waving_hand, size: 50.0),
          ),
        ),
        // Page to get name of user and save it to shared preferences
        PageViewModel(
            title: "First things first...",
            body: "What is your name?",
            image: const Center(
              child: Icon(Icons.person, size: 50.0),
            ),
            footer: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                      child: TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your name' : null,
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  )),
                )
              ],
            ))
      ];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: _buildIntro(),
    ));
  }

  Widget _buildIntro() {
    return IntroductionScreen(
      pages: pages,
      onDone: () async {
        // CLose keyboard
        FocusScope.of(context).unfocus();

        if (name.isEmpty) {
          return;
        }

        // Save name to shared preferences
        final preferences = await SharedPreferences.getInstance();
        await preferences.setString('name', name).then((value) => {
              // Set first_run to false
              preferences.setBool('first_run', false).then((value) =>
                  // Navigate to home screen
                  Navigator.pop(context))
            });
      },
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: Colors.black,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
