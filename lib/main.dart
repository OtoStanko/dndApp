//import 'dart:html';
import "character.dart";
import "characters_database.dart";



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


  @override
  Widget build(BuildContext context) {
    CharactersDatabase database =  CharactersDatabase();
    List<Character> characters = database.getCharacters() as List<Character>;
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
                    const CircleAvatar(
                      backgroundImage: AssetImage("images/bear.jpg"),
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
                    Text( "${Classes.values[character.charClass]} lvl ${character.charLvl}"),
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

