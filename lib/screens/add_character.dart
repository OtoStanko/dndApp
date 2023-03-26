import 'dart:io';
import 'package:image/image.dart' as img;

import 'package:firstapp/classes/character.dart';
import 'package:firstapp/classes/classes.dart';
import 'package:firstapp/db/database.dart';
import 'package:firstapp/db/models/class_model.dart';
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

  late Character newCharacter;

  @override
  void initState() {
    super.initState();
    setState(() {
      newCharacter = emptyCharacter;
    });
    _initCharacter();
  }

  _initCharacter() async {
    setState(() {
      newCharacter.characterClass = _classes.getDefaultClass();
      newCharacter.image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Column(children: [
          const FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Text('Create a character',
                      style: TextStyle(
                          fontSize: 40, fontWeight: FontWeight.w100)))),
          Flexible(
              child: Form(
                  key: _formKey,
                  child: Column(children: [
                    Row(children: const [
                      Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text("Character name",
                              style: TextStyle(fontSize: 10))),
                    ]),
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
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.w100)),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 5.0),
                        child: Dropdown(
                            classes: _classes.getClassesNames(),
                            onChanged: (value) async {
                              newCharacter.characterClass =
                                  await _classes.getClass(value);
                            })),
                    Row(children: const [
                      Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text("Character level",
                              style: TextStyle(fontSize: 10))),
                    ]),
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
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.w100),
                              hintText: "0"),
                          onChanged: (val) {
                            setState(() {
                              var num = int.tryParse(val);
                              if (num == null) return;
                              newCharacter.characterLevel = num;
                            });
                          },
                        )),
                    Row(children: const [
                      Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text("Character icon",
                              style: TextStyle(fontSize: 10))),
                    ]),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ImagePicker(
                          onChanged: (File file) async {
                            final image =
                                img.decodeImage(await file.readAsBytes());
                            if (image == null) return;
                            // Resize the image
                            img.Image thumbnail = img.copyResize(image,
                                width: 300, height: 300);
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
                  ])))
        ])));
  }
}
