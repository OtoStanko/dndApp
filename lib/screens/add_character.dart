import 'package:firstapp/enums/classes.dart';
import 'package:flutter/material.dart';

class AddCharacter extends StatelessWidget {
  const AddCharacter({Key? key}) : super(key: key);

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
                child: Column(children: [
              const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListTile(
                      title: const Text("Class"),
                      trailing:
                          PopupMenuButton<Classes>(itemBuilder: (context) {
                        return Classes.values.map((e) {
                          return PopupMenuItem<Classes>(
                            value: e,
                            child: Text(e.name.toString()),
                          );
                        }).toList();
                      }))),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Level',
                        hintText: "0"),
                  )),
            ]))));
  }
}
