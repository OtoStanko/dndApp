import 'package:firstapp/classes/character.dart';
import 'package:firstapp/db/database.dart';
import 'package:firstapp/screens/view_character_screens/character_edit.dart';
import 'package:firstapp/screens/view_character_screens/character_features.dart';
import 'package:firstapp/screens/view_character_screens/character_sheet.dart';
import 'package:firstapp/widgets/overlapping_panels.dart';
import 'package:flutter/material.dart';

class ViewCharacter extends StatefulWidget {
  final int characterId;
  const ViewCharacter({Key? key, required this.characterId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ViewCharacter();
}

class _ViewCharacter extends State<ViewCharacter> {
  late Future<Character> futureCharacter;

  @override
  void initState() {
    super.initState();
    // Load character info from database
    futureCharacter = _init(widget.characterId);
  }

  Future<Character> _init(int id) async {
    return await Database().getCharacter(id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureCharacter,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final character = snapshot.data as Character;
          return Scaffold(
              body: SafeArea(
                  child: ListView(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                      Flexible(
                          child: Text(character.characterName,
                              style: const TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.w100))),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (builder) {
                                  return Dialog(
                                    child: CharacterEdit(character: character),
                                  );
                                }).whenComplete(() {
                                  // Reload character info from database
                                  setState(() {
                                    futureCharacter = _init(widget.characterId);
                                  });
                            });
                          },
                          icon: const Icon(Icons.edit))
                    ],
                  )),
              CharacterSheet(character: character),
              CharacterFeatures(character: character)
            ],
          )));
        }));
  }
}

/*
OverlappingPanels(
                    // Using the Builder widget is not required. You can pass your widget directly. But to use `OverlappingPanelsState.of(context)` you need to wrap your widget in a Builder
                    left: Builder(builder: (context) {
                      return CharacterSheet(character: character);
                    }),
                    right: Builder(builder: (context) {
                      return CharacterEdit(character: character);
                    }),
                    main: Builder(
                      builder: (context) {
                        return CharacterFeatures(character: character);
                      },
                    ),
                    onSideChange: (side) {
                      setState(() {
                        if (side == RevealSide.main) {
                          // hide something
                        } else if (side == RevealSide.left) {
                          // show something
                        }
                      });
                    },
                  ),
                  */
