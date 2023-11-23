import 'package:firstapp/common/models/character.dart';
import 'package:firstapp/common/services/flutter_service.dart';
import 'package:firstapp/common/utils.dart';
import 'package:firstapp/common/widgets/page_wrapper.dart';
import 'package:firstapp/view_character/view_character_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CharacterList extends StatelessWidget {
  const CharacterList({super.key});

  @override
  Widget build(BuildContext context) {
    final service = GetIt.instance<FirebaseService>();

    return StreamBuilder(
        stream: service.userCharacters,
        builder: (buildContext, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          final characters = snapshot.data as List<Character>;
          if (characters.isEmpty) {
            return const Text('No characters found 😭');
          }

          return Expanded(
            child: SingleChildScrollView(
                child: Column(children: [
              for (Character character in characters)
                ListTile(
                  title: Text(character.name),
                  subtitle: Text(capitalise(character.characterClass.name)),
                  trailing: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: character.photoUrl.isNotEmpty
                        ? _buildImage(character)
                        : const Text('No photo'),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PageWrapper(
                                child: ViewCharacterPage(
                                    characterId: character.id))));
                  },
                  onLongPress: () {
                    _deleteCharacter(context, character);
                    // service.updateCharacterPhoto(character.id);
                  },
                ),
            ])),
          );
        });
  }

  Image _buildImage(Character character) {
    return Image.network(character.photoUrl,
        width: 48,
        height: 48,
        errorBuilder: (context, error, stackTrace) {
          GetIt.I.get<FirebaseService>().removeCharacterPhoto(character.id);
          return const Text('No photo');
        });
  }

  void _deleteCharacter(BuildContext context, Character character) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete character'),
            content: const Text('Are you sure you want to delete this character?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    GetIt.I.get<FirebaseService>().deleteCharacter(character.id);
                    Navigator.pop(context);
                  },
                  child: const Text('Delete')),
            ],
          );
        });
  }
}
