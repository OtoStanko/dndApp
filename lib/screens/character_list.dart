import 'package:cached_memory_image/provider/cached_memory_image_provider.dart';
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
  late Future<List<Character>> _data;

  @override
  void initState() {
    super.initState();
    setState(() {
      _data = _init();
    });
  }

  Future<List<Character>> _init() async {
    var data = Database().characters();
    return data;
  }

  Widget formatString(String name) {
    if (name.length == 1) {
      return Text(name.toUpperCase());
    } else {
      return Text(name.substring(0, 2).toUpperCase());
    }
  }

  List<Widget> getCharacters(List<Character> characters) {
    final colors = Colors.primaries.toList();
    return characters.map((character) {
      colors.shuffle();
      return Card(
        child: ListTile(
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: ((context) {
                    return AlertDialog(
                      title: const Text("Delete character?"),
                      content: Text(
                          "Are you sure you want to delete ${character.characterName}?"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            await Database().deleteCharacter(character.id);
                            setState(() {
                              _data = _init();
                              Navigator.pop(context);
                            });
                          },
                          child: const Text("Yes"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("No"),
                        )
                      ],
                    );
                  }));
            },
            leading: character.image != null
                ? CircleAvatar(
                    radius: 20,
                    backgroundColor: colors.first,
                    backgroundImage: CachedMemoryImageProvider(
                        scale: 0.1,
                        "app://characters/${character.id}/${character.image.hashCode}",
                        bytes: character.image))
                : CircleAvatar(
                    radius: 20,
                    backgroundColor: colors.first,
                    child: formatString(character.characterName)),
            title: Text(
              character.characterName,
              style: const TextStyle(fontSize: 40),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ViewCharacter(characterId: character.id),
                  )).then((value) => setState(() {
                    _data = _init();
                  }));
              // _reloadCharacters();
            },
            trailing: Text(character.characterClass.className,
                style: const TextStyle(
                    color: Colors.black38, fontWeight: FontWeight.w100))),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _data,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          List<Character> list = snapshot.data as List<Character>;
          return Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.63,
                  child: ListView(
                      shrinkWrap: true, children: getCharacters(list))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: ElevatedButton(
                        onPressed: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddCharacter()));
                          setState(() {
                            setState(() {
                              _data = _init();
                            });
                          });
                        },
                        child: const Text('Add new character')),
                  ),
                ],
              ),
            ],
          );
        }));
  }
}
