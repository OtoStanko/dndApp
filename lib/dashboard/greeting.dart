import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/common/services/flutter_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Greeting extends StatelessWidget {
  const Greeting({super.key});

  @override
  Widget build(BuildContext context) {
    final user = GetIt.I<FirebaseService>().user;
    final theme = Theme.of(context);
    final style = TextStyle(
      color: Colors.black,
      fontSize: theme.textTheme.headlineLarge?.fontSize,
    );

    return StreamBuilder(
        stream: user,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          final user = snapshot.data as User;
          if (user.isAnonymous) {
            return Text('Hello, stranger!', style: style);
          }
          return Text('Hello, ${user.displayName ?? user.email}!', style: style);
        });
  }
}
