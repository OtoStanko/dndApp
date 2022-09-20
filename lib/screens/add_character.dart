import 'package:firstapp/static/constants.dart';
import 'package:firstapp/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddCharacter extends StatefulWidget {
  const AddCharacter({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddCharacter();
}

class _AddCharacter extends State<AddCharacter> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add a new character"),
          backgroundColor: const Color.fromARGB(255, 12, 127, 100),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
                key: _formKey,
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
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
                  const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Dropdown(classes:["class", "sdsasd"])),
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        inputFormatters: [LengthLimitingTextInputFormatter(2)],
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
                      )),
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                        child: const Text("Create a character"),
                      ))
                ]))));
  }
}
