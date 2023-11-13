import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/common/services/flutter_service.dart';
import 'package:firstapp/common/widgets/navbar.dart';
import 'package:firstapp/profile/anonymous_settings.dart';
import 'package:firstapp/profile/logged_in_settings.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = GetIt.instance<FirebaseService>().user;

    return Column(
      children: [
        const Navbar(title: 'Profile'),
        StreamBuilder(stream: user, builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          final user = snapshot.data as User;
          if (user.isAnonymous) {
            return AnonymousSettings(user: user);
          }
          return LoggedInSettings(user: user);
        }),
      ],
    );
  }
}
