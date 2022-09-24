import 'package:firstapp/classes/character.dart';
import 'package:flutter/material.dart';

class CharacterSheet extends StatefulWidget {
  final Character character;
  const CharacterSheet({Key? key, required this.character}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CharacterSheet();
}

class _CharacterSheet extends State<CharacterSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const Text("Character Id", style: TextStyle(fontSize: 10)),
          Text(widget.character.id.toString(),
              style: const TextStyle(fontSize: 30)),
          const Text("Character name", style: TextStyle(fontSize: 10)),
          Text(widget.character.characterName,
              style: const TextStyle(fontSize: 30)),
          const Text("Character level", style: TextStyle(fontSize: 10)),
          Text(widget.character.characterLevel.toString(),
              style: const TextStyle(fontSize: 30)),
          const Text("Character class", style: TextStyle(fontSize: 10)),
          Text(widget.character.characterClass.className,
              style: const TextStyle(fontSize: 30)),
          const Text("Class description", style: TextStyle(fontSize: 10)),
          Text(widget.character.characterClass.classDescription,
              style: const TextStyle(fontSize: 30)),
          const Text("Icon Path", style: TextStyle(fontSize: 10)),
          widget.character.iconPath.isNotEmpty
              ? Image.asset(widget.character.iconPath.toString())
              : const Text("No path provided")
        ]));
  }
}
