import 'dart:io';

import 'package:firstapp/classes/character.dart';
import 'package:firstapp/classes/classes.dart';
import 'package:firstapp/db/database.dart';
import 'package:firstapp/static/constants.dart';
import 'package:firstapp/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/image_picker.dart';

class AddCharacter extends StatefulWidget {
  const AddCharacter({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddCharacter();
}

class _AddCharacter extends State<AddCharacter> {
  final _classes = Classes();
  final _formKey = GlobalKey<FormState>();

  Character newCharacter = emptyCharacter;

  _AddCharacter() {
    _initCharacter();
  }

  _initCharacter() async {
    newCharacter.characterClass = await _classes.getClassById(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add a new character"),
          backgroundColor: const Color.fromARGB(255, 12, 127, 100),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(children: [
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            onChanged: (val) {
                              setState(() {
                                newCharacter.characterName = val;
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
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Dropdown(
                              classes: _classes.getClassesNames(),
                              onChanged: (value) async {
                                newCharacter.characterClass =
                                    await _classes.getClass(value);
                              })),
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(2)
                            ],
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return levelInputError;
                              }
                              final parse = int.tryParse(value);
                              if (parse == null || parse < 1 || parse > 20) {
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
                                newCharacter.characterLevel = num;
                              });
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ImagePicker(
                            onChanged: (File file) async {
                              newCharacter.image = file.readAsBytesSync();
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Database().insertCharacter(newCharacter).then(
                                    (value) => {Navigator.pop(context, "OK")});
                              }
                            },
                            child: const Text("Create a character"),
                          ))
                    ])))));
  }
}
