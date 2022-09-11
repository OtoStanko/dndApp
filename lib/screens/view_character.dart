import 'package:firstapp/classes/character.dart';
import 'package:flutter/material.dart';

class ViewCharacter extends StatefulWidget {
  final Character character;
  const ViewCharacter({Key? key, required this.character}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ViewCharacterState();
}

class _ViewCharacterState extends State<ViewCharacter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.character.charName),
          backgroundColor: const Color.fromARGB(255, 12, 127, 100),
        ),
        body: SizedBox(
            height: 200,
            child: Row(children: [
              Expanded(
                child: Text(widget.character.charName,
                    style: const TextStyle(height: 5, fontSize: 50)),
              ),
              Text(widget.character.charLvl.toString(),
                  style: const TextStyle(height: 5, fontSize: 50)),
            ])));
  }
}
