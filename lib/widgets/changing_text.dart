import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ChangingText extends StatefulWidget {
  const ChangingText({super.key});

  @override
  State<StatefulWidget> createState() => _ChangingTextState();
}

class _ChangingTextState extends State<ChangingText> {
  final helpers = [
    "Getting your critical rolls...",
    "Slaying the dragon...",
    "Updating your character sheet...",
    "Loading features...",
    "Enhancing your character photos...",
    "Adding new spells...",
    "Adding new character classes...",
    "ARRRRGGHHH!!!",
    "Loading (but magical)...",
  ];
  int id = 0;
  // Timer? timer;

  @override
  void initState() {
    setState(() {
      id = Random().nextInt(helpers.length);
      // Don't know why this does not update the text
      // timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      //   id = Random(id).nextInt(helpers.length);
      // });
    });
    super.initState();
  }

  @override
  void dispose() {
    // timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      helpers[id],
      style: const TextStyle(
          color: Colors.black,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.w100,
          fontSize: 16),
    );
  }
}
