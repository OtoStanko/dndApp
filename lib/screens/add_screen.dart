import 'package:firstapp/db/database.dart';
import 'package:firstapp/db/models/character_model.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreen();
}

class _AddScreen extends State<AddScreen> {
  late List<Character> _characters;
  bool _loaded = false;

  Future<List<Character>> _init() async {
    return await Database().characters();
  }

  _AddScreen() {
    _init().then((value) {
      setState(() {
        _characters = value;
        _loaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return MaterialApp(
          home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 4, 64, 6),
          title: const Text("Characters"),
        ),
        body: const Padding(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 10),
            child: Text("Loading")),
      ));
    }

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 64, 6),
        title: const Text("Characters"),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
          child: Text(_characters.length.toString())),
    ));
  }
}
