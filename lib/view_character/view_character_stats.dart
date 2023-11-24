import 'package:firstapp/common/models/character.dart';
import 'package:firstapp/view_character/dialogs.dart';
import 'package:flutter/material.dart';

class ViewCharacterStats extends StatelessWidget {
  final Character character;

  const ViewCharacterStats({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final tmpHp = character.stats.temporaryHealthPoints > 0
        ? " (+ ${character.stats.temporaryHealthPoints})"
        : "";

    return Column(children: [
      ListTile(
        title: const Text("HP"),
        trailing: Text(
            "${character.stats.healthPoints}/${character.stats.maxHealthPoints}$tmpHp",
            style: const TextStyle(fontSize: 24)),
        onLongPress: () {
          showEditHealthDialog(context, character);
        },
      ),
      ListTile(
          title: const Text("AC"),
          trailing: Text("${character.stats.armorClass}",
              style: const TextStyle(fontSize: 24)),
          onLongPress: () {
            print("Long press");
          }),
      ListTile(
          title: const Text("Speed"),
          trailing: Text("${character.stats.speed}ft",
              style: const TextStyle(fontSize: 24)),
          onLongPress: () {
            print("Long press");
          }),
      ListTile(
          title: const Text("Initiative"),
          trailing: Text("${character.stats.initiative}",
              style: const TextStyle(fontSize: 24)),
          onLongPress: () {
            print("Long press");
          }),
      ListTile(
          title: const Text("Proficiency"),
          trailing: Text("+${character.stats.proficiencyBonus}",
              style: const TextStyle(fontSize: 24)),
          onLongPress: () {
            print("Long press");
          }),
    ]);
  }
}
