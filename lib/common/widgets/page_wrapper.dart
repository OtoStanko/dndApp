import 'package:flutter/material.dart';

class PageWrapper extends StatelessWidget {
  final Widget? child;

  const PageWrapper({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: child ?? const Placeholder(),
    ));
  }
}
