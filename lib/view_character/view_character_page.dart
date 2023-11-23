import 'package:firstapp/common/models/character.dart';
import 'package:firstapp/common/services/flutter_service.dart';
import 'package:firstapp/common/utils.dart';
import 'package:firstapp/common/widgets/navbar.dart';
import 'package:firstapp/view_character/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ViewCharacterPage extends StatelessWidget {
  final String characterId;

  const ViewCharacterPage({super.key, required this.characterId});

  @override
  Widget build(BuildContext context) {
    final service = GetIt.instance<FirebaseService>();
    final character = service.getCharacterById(characterId);
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: character.photoUrl.isNotEmpty
                                ? Image.network(
                                    character.photoUrl,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    "https://via.placeholder.com/100",
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )),
                      ),
                      Text(character.name,
                          style: const TextStyle(fontSize: 24)),
                      Text(capitalise(character.characterClass.name),
                          style: const TextStyle(
                              fontSize: 18, color: Colors.grey)),
                      const SizedBox(height: 16),
                      const Divider(),
                      Column(children: [
                        Text(
                            "HP: ${character.stats.healthPoints} / ${character.stats.maxHealthPoints}",
                            style: const TextStyle(fontSize: 24)),
                        Text("AC: ${digitPrefix(character.stats.armorClass)}",
                            style: const TextStyle(fontSize: 24)),
                        Text("Speed: ${character.stats.speed} ft",
                            style: const TextStyle(fontSize: 24)),
                        Text(
                            "Initiative: ${digitPrefix(character.stats.initiative)}",
                            style: const TextStyle(fontSize: 24)),
                        const Divider(),
                        for (var ability in character.stats.abilities)
                          ListTile(
                            title: Text(capitalise(ability.name),
                                style: const TextStyle(fontSize: 18)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(digitPrefix(ability.modifier),
                                    style: const TextStyle(fontSize: 18)),
                                const SizedBox(width: 8),
                                Text("(${ability.value})",
                                    style: const TextStyle(fontSize: 18)),
                              ],
                            ),
                            onLongPress: () {
                              print(ability.name);
                            },
                          ),
                        const Divider(),
                        for (var skill in character.stats.skills)
                          ListTile(
                              title: Text(capitalise(skill.name),
                                  style: const TextStyle(fontSize: 18)),
                              trailing: Text(digitPrefix(skill.value),
                                  style: const TextStyle(fontSize: 18)),
                              onTap: () {
                                print(skill);
                              },
                              onLongPress: () {
                                showEditCharacterAbilityDialog(
                                    context, skill, characterId);
                              }),
                      ])
                    ],
                  ),
                ),
              )
            ],
          );
        });
  }
}
