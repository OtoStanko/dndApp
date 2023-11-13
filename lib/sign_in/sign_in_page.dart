import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/common/services/flutter_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    final service = GetIt.instance<FirebaseService>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          children: [
            const Spacer(),
            const Text('Sign In', style: TextStyle(fontSize: 24)),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              controller: _emailController,
              onChanged: (value) => setState(() => _email = value),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Password',

              ),
              obscureText: true,
              controller: _passwordController,
              onChanged: (value) => setState(() => _password = value),
            ),
            ElevatedButton(
              onPressed: () {
                if (_email.isEmpty || _password.isEmpty) {
                  return;
                }
                service
                    .promoteToUser(_email, _password)
                    .then((value) => Navigator.pop(context));
              },
              child: const Text('Sign Up'),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
