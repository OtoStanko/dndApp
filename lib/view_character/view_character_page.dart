import 'package:firstapp/common/models/character.dart';
import 'package:firstapp/common/services/flutter_service.dart';
import 'package:firstapp/common/utils.dart';
import 'package:firstapp/common/widgets/navbar.dart';
import 'package:firstapp/view_character/image_drawer.dart';
import 'package:firstapp/view_character/view_character_list.dart';
import 'package:firstapp/view_character/view_character_stats.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ViewCharacterPage extends StatelessWidget {
  final String characterId;

  const ViewCharacterPage({super.key, required this.characterId});

  @override
  Widget build(BuildContext context) {
    final service = GetIt.instance<FirebaseService>();
    final characterStats = service.getFullCharacterById(characterId);

    return StreamBuilder(
        stream: characterStats,
        builder: (buildContext, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final character = snapshot.data as Character;
          return Column(
            children: [
              Navbar(title: character.name),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: SingleChildScrollView(
                    child: Column(children: [
                  ImageDrawer(character: character),
                  Text(character.name, style: const TextStyle(fontSize: 24)),
                  Text(capitalise(character.characterClass.name),
                      style: const TextStyle(fontSize: 18, color: Colors.grey)),
                  const SizedBox(height: 16),
                  const Divider(),
                  ViewCharacterStats(character: character),
                  const Divider(),
                  ViewCharacterList(character: character)
                ])),
              )
            ],
          );
        });
  }
}
