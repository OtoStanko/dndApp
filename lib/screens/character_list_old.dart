import 'package:firstapp/classes/character.dart';
import 'package:firstapp/enums/classes.dart';
import 'package:firstapp/screens/character_list.dart';
import 'package:firstapp/screens/view_character.dart';
import 'package:flutter/material.dart';

class CharacterListOld extends StatelessWidget {
  final int skreeLvl = 10;
  final int druidLvl = 11;

  List<Character> characters = [
    Character(
        id: 0,
        iconPath: "images/Druid_dragonborn_green.jpg",
        characterName: "Skreee",
        characterClass: Classes.druid.name.toString(),
        characterLevel: 10),
    Character(
        id: 1,
        iconPath: "images/bear.jpg",
        characterName: "Bér",
        characterClass: Classes.barbarian.name.toString(),
        characterLevel: 11),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 4, 64, 6),
            title: const Text("Characters"),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
            child: Column(
              children: characters.map((character) {
                return GestureDetector(
                  child: Column(children: [
                    Row(
                      children: [
                        Expanded(
                          child: CircleAvatar(
                            backgroundImage: AssetImage(character.iconPath),
                            radius: 20,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: 60,
                            child: Text(character.characterName),
                          ),
                        ),
                        Expanded(
                          child: Text(
                              "${character.characterClass.toString()} lvl ${character.characterClass}"),
                        )
                      ],
                    ),
                    const Divider(
                      height: 40,
                    )
                  ]),
                );
              }).toList(),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () => {},
            child: const Icon(Icons.add),
          )),
    );
  }
}
