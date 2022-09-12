import 'package:firstapp/classes/character.dart';
import 'package:firstapp/db/database.dart';
import 'package:flutter/material.dart';

class ViewCharacter extends StatefulWidget {
  final int characterId;
  const ViewCharacter({Key? key, required this.characterId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ViewCharacter();
}

class _ViewCharacter extends State<ViewCharacter> {
  late Character _character;
  bool _loaded = false;

  Future<Character> _init(int id) async {
    return await Database().getCharacter(id);
  }

  @override
  void initState() {
    super.initState();

    // Load character info from database
    _init(widget.characterId).then((value) {
      setState(() {
        _character = value;
        _loaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return MaterialApp(
          home: Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 4, 64, 6),
                title: const Text("Loading character"),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              )));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(_character.characterName),
          backgroundColor: const Color.fromARGB(255, 12, 127, 100),
        ),
        body: SizedBox(
            height: 200,
            child: Row(children: [
              Expanded(
                child: Text(_character.characterName,
                    style: const TextStyle(height: 5, fontSize: 50)),
              ),
              Text(_character.characterLevel.toString(),
                  style: const TextStyle(height: 5, fontSize: 50)),
            ])));
  }
}
