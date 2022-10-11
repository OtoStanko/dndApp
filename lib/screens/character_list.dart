import 'package:firstapp/db/database.dart';
import 'package:firstapp/db/models/character_model.dart';
import 'package:firstapp/screens/add_character.dart';
import 'package:firstapp/screens/view_character.dart';
import 'package:flutter/material.dart';

class CharacterList extends StatefulWidget {
  const CharacterList({super.key});

  @override
  State<CharacterList> createState() => _CharacterList();
}

class _CharacterList extends State<CharacterList> {
  late List<Character> _characters;
  bool _loaded = false;

  Future<List<Character>> _init() async {
    return await Database().characters();
  }

  _reloadCharacters() {
    _init().then((value) {
      setState(() {
        _characters = value;
        _loaded = true;
      });
    });
  }

  _CharacterList() {
    _reloadCharacters();
  }

  List<Card> getCharacters() {
    final colors = Colors.primaries.toList();
    return _characters.map((e) {
      colors.shuffle();
      return Card(
        child: ListTile(
            leading: e.image != null
                ? CircleAvatar(
                    radius: 20,
                    backgroundColor: colors.first,
                    backgroundImage: MemoryImage(e.image!))
                : CircleAvatar(
                    radius: 20,
                    backgroundColor: colors.first,
                    child: Text(e.characterName.substring(0, 2).toUpperCase())),
            title: Text(
              e.characterName,
              style: const TextStyle(fontSize: 40),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ViewCharacter(characterId: e.id),
                  ));
              _reloadCharacters();
            },
            trailing: Text(e.characterClass.className,
                style: const TextStyle(color: Colors.black38))),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return MaterialApp(
          home: Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 4, 64, 6),
                title: const Text("Characters"),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              )));
    }

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 4, 64, 6),
              title: const Text("Characters"),
            ),
            body: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ListView(children: getCharacters())),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddCharacter()));
                // Reload character list
                _reloadCharacters();
              },
              child: const Icon(Icons.add),
            )));
  }
}
