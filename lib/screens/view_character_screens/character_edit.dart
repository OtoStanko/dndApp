import 'dart:io';

import 'package:firstapp/classes/character.dart';
import 'package:firstapp/widgets/dropdown.dart';
import 'package:firstapp/widgets/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../classes/classes.dart';
import '../../db/database.dart';
import '../../static/constants.dart';

class CharacterEdit extends StatefulWidget {
  final Character character;
  const CharacterEdit({Key? key, required this.character}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CharacterEdit();
}

class _CharacterEdit extends State<CharacterEdit> {
  final _classes = Classes();
  final _formKey = GlobalKey<FormState>();
  Character editCharacter = emptyCharacter;

  @override
  void initState() {
    super.initState();
    editCharacter = widget.character;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 50),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text("Character name",
                              style: TextStyle(fontSize: 10)),
                          Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: TextFormField(
                                initialValue: editCharacter.characterName,
                                onChanged: (val) {
                                  setState(() {
                                    editCharacter.characterName = val;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return nameInputError;
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Name',
                                ),
                              )),
                          const Text("Character class",
                              style: TextStyle(fontSize: 10)),
                          Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Dropdown(
                                  classes: _classes.getClassesNames(),
                                  initialValue: editCharacter.characterClass,
                                  onChanged: (value) async {
                                    editCharacter.characterClass =
                                        await _classes.getClass(value);
                                  })),
                          const Text("Character level",
                              style: TextStyle(fontSize: 10)),
                          Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: TextFormField(
                                initialValue:
                                    editCharacter.characterLevel.toString(),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(2)
                                ],
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return levelInputError;
                                  }
                                  final parse = int.tryParse(value);
                                  if (parse == null ||
                                      parse < 1 ||
                                      parse > 20) {
                                    return levelInputError;
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Level',
                                    hintText: "0"),
                                onChanged: (val) {
                                  setState(() {
                                    var num = int.tryParse(val);
                                    if (num == null) return;
                                    editCharacter.characterLevel = num;
                                  });
                                },
                              )),
                          const Text("Character image",
                              style: TextStyle(fontSize: 10)),
                          Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(children: [
                                widget.character.image != null
                                    ? Image.memory(widget.character.image!,
                                        height: 50, width: 50)
                                    : const Text("No image"),
                                ImagePicker(
                                  onChanged: (File file) async {
                                    editCharacter.image =
                                        file.readAsBytesSync();
                                  },
                                ),
                              ])),
                          Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    Database()
                                        .updateCharacter(editCharacter)
                                        .then((value) =>
                                            {Navigator.pop(context, "OK")});
                                  }
                                },
                                child: const Text("Update character"),
                              ))
                        ])))));
  }
}
