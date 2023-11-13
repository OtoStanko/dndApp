import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  const Navbar({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: actions ?? [],
    );
  }
}
