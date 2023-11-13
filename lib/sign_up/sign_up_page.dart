import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/common/services/flutter_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
            const Text('Sign Up', style: TextStyle(fontSize: 24)),
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
                final credential = EmailAuthProvider.credential(
                  email: _email,
                  password: _password,
                );
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
