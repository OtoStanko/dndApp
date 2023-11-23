import 'package:firstapp/add_character/add_character_page.dart';
import 'package:firstapp/common/models/character.dart';
import 'package:firstapp/common/services/flutter_service.dart';
import 'package:firstapp/common/widgets/navbar.dart';
import 'package:firstapp/dashboard/character_list.dart';
import 'package:firstapp/dashboard/greeting.dart';
import 'package:firstapp/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../common/widgets/page_wrapper.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Navbar(title: 'Dashboard', actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PageWrapper(
                            child: ProfilePage(),
                          )));
            },
          )
        ]),
        const SizedBox(height: 16.0),
        const Greeting(),
        const CharacterList(),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PageWrapper(
                            child: AddCharacterPage(),
                          ))).then((value) {
                final character = value as Character;
                final service = GetIt.instance<FirebaseService>();
                service.createCharacter(character);
                return;
              });
            },
            child: const Text('Add character'))
      ],
    );
  }
}
