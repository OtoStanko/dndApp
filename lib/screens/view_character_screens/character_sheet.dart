import 'package:firstapp/classes/character.dart';
import 'package:firstapp/widgets/avatar_icon.dart';
import 'package:flutter/material.dart';

class CharacterSheet extends StatefulWidget {
  final Character character;
  const CharacterSheet({Key? key, required this.character}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CharacterSheet();
}

class _CharacterSheet extends State<CharacterSheet> {
  late Dialog _dialog;

  void initState() {
    super.initState();
    setState(() {
      if (widget.character.image != null) {
        _dialog = Dialog(child: Image.memory(widget.character.image!));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Column(
            children: [
                  const Text("Level",
                      style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.w100)),
              Text(widget.character.characterLevel.toString(),
                  style: const TextStyle(
                      fontSize: 50, fontWeight: FontWeight.w100)),
              const Text("Character class",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w100)),
              Text(widget.character.characterClass.className,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w100)),
            ],
          ),
          widget.character.image != null
              ? FittedBox(
                  fit: BoxFit.fitWidth,
                  child: IconButton(
                    icon: Image.memory(widget.character.image!, scale: 0.01),
                    onPressed: () {
                      // Open dialog with image in full size
                      showDialog(
                          context: context,
                          builder: (builder) {
                            return _dialog;
                          });
                    },
                    iconSize: 100,
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                  ))
              : Container(),
        ]));
  }
}
