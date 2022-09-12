import 'package:firstapp/db/database.dart';
import 'package:firstapp/screens/character_list.dart';
import 'package:flutter/material.dart';

class Init extends StatefulWidget {
  const Init({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Init();
}

class _Init extends State<Init> {
  bool _loading = true;

  _Init() {
    Future(() async {
      // Init all async stuff then remove loading screen
      await Database().initDB();
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_loading) {
      return const CharacterList();
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircularProgressIndicator(),
        Padding(padding: EdgeInsets.all(10)),
        Text(
          "Loading",
          style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w100,
              fontSize: 16),
        )
      ],
    );
  }
}
