import 'package:firstapp/db/database.dart';
import 'package:firstapp/db/models/class_model.dart';
import 'package:firstapp/static/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddClassModal extends StatefulWidget {
  final Function onSuccessfulSubmit;

  const AddClassModal({super.key, required this.onSuccessfulSubmit});

  @override
  State<AddClassModal> createState() => _AddClassModalState();
}

class _AddClassModalState extends State<AddClassModal> {
  String name = "";
  String description = "";
  int hitDie = 1;

  @override
  Widget build(BuildContext context) {
    // Show dialog with text fields to add a custom class
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green)),
        onPressed: () async {
          // Show dialog
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    title: const Text("Add custom class"),
                    content: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            const Text("Name"),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Form(
                                  child: TextFormField(
                                validator: (value) => value!.isEmpty
                                    ? 'Please enter a name'
                                    : null,
                                onChanged: (value) {
                                  setState(() {
                                    name = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Name',
                                ),
                              )),
                            ),
                            const Text("Description"),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Form(
                                  child: TextFormField(
                                validator: (value) => value!.isEmpty
                                    ? 'Please enter a description'
                                    : null,
                                onChanged: (value) {
                                  setState(() {
                                    description = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Description',
                                ),
                              )),
                            ),
                            Text("Hit die (D$hitDie)"),
                            Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Form(
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
                                    if (parse == null ||
                                        parse < 1 ||
                                        parse > 20) {
                                      return levelInputError;
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      hitDie = int.parse(value);
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Hit die',
                                  ),
                                ))),
                          ],
                        )),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                      TextButton(
                          onPressed: () async {
                            if (name.isEmpty || hitDie < 1) {
                              return;
                            }

                            widget.onSuccessfulSubmit(Class(
                                id: -1,
                                className: name,
                                classDescription: description,
                                classHitDie: hitDie));
                          },
                          child: const Text("Add class"))
                    ]);
              });
        },
        child: const Text("Add custom class"));
  }
}
