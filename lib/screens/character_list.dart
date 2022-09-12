import 'package:firstapp/classes/character.dart';
import 'package:firstapp/enums/classes.dart';
import 'package:firstapp/extensions/String_extension.dart';
import 'package:firstapp/screens/add_screen.dart';
import 'package:firstapp/screens/view_character.dart';
import 'package:firstapp/static/constants.dart';
import 'package:flutter/material.dart';

class CharacterList extends StatelessWidget {
  final int skreeLvl = 10;
  final int druidLvl = 11;

  List<Character> characters = [
    Character("images/Druid_dragonborn_green.jpg", "Skreee", Classes.druid, 10),
    Character("images/bear.jpg", "Druid number 2", Classes.fighter, 11),
    Character("images/bear.jpg", "Darastrix", Classes.barbarian, 10),
    Character("images/bear.jpg", "Darastrix", Classes.barbarian, 10),
    Character("images/bear.jpg", "Darastrix", Classes.barbarian, 10),
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
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ViewCharacter(character: character),
                        ));
                  },
                  child: Column(children: [
                    Row(
                      children: [
                        Expanded(
                          child: CircleAvatar(
                            backgroundImage: AssetImage(character.charImgPath),
                            radius: 20,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: 60,
                            child: Text(character.charName),
                          ),
                        ),
                        Expanded(
                          child: Text(
                              "${character.charClass.name.capitalize()} lvl ${character.charLvl}"),
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
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddScreen(),
                  ));
            },
            child: const Icon(Icons.add),
          )),
    );
  }
}
