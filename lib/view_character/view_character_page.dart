import 'package:firstapp/common/models/character.dart';
import 'package:firstapp/common/services/flutter_service.dart';
import 'package:firstapp/common/utils.dart';
import 'package:firstapp/common/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ViewCharacterPage extends StatelessWidget {
  final String characterId;

  const ViewCharacterPage({super.key, required this.characterId});

  @override
  Widget build(BuildContext context) {
    final service = GetIt.instance<FirebaseService>();
    final character = service.getCharacterById(characterId);
    return StreamBuilder(
        stream: character,
        builder: (buildContext, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          final character = snapshot.data as Character;
          return Column(
            children: [
              Navbar(title: character.name),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    character.photoUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(character.name, style: const TextStyle(fontSize: 24)),
              Text(capitalise(character.characterClass.name),
                  style: const TextStyle(fontSize: 18, color: Colors.grey)),
              const SizedBox(height: 16),
            ],
          );
        });
  }
}
