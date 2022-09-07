//import 'dart:html';
import "string_extension.dart";
import "character.dart";

import 'package:flutter/material.dart';
const double dividerWidth = 20;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _MyAppState()
    );
  }
}

class _MyAppState extends StatefulWidget {

  @override
  State<_MyAppState> createState() => _MyAppStateState();
}

class _MyAppStateState extends State<_MyAppState> {

int skreeLvl = 10;
int druidLvl = 11;

List<Character> characters = [
  Character("images/Druid_dragonborn_green.jpg", "Skreee", Classes.druid, 10),
  Character("images/bear.jpg", "Druid number 2", Classes.fighter, 11),
  Character("images/bear.jpg", "Darastrix", Classes.barbarian, 10),
];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: const Text("Characters"),
          ),
          
          body: Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
            child: Column(
              children: characters.map((character) {
                return Column( children: [Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(character.charImgPath),
                      radius: 20,
                    ),
                    const VerticalDivider(
                      width: dividerWidth,
                    ),
                    SizedBox(
                      width: 60,
                      child: Text(character.charName),
                    ),
                    const VerticalDivider(
                      width: dividerWidth,
                    ),
                    Text( "${character.charClass.name.capitalize()} lvl ${character.charLvl}"),
                  ],
                ),
                const Divider(height: 40,),]
                );
              
              }).toList(),
              ),
            ), 

            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AboutScreen(),
                    )
              );
              setState(() {
                skreeLvl++;
              });
              },
              child: const Icon(Icons.add),
            )
          ),
      );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),
    );
  }
}

