import 'package:firstapp/common/models/character.dart';
import 'package:firstapp/common/utils.dart';
import 'package:firstapp/view_character/common/dialogs.dart';
import 'package:firstapp/view_character/view_proficient_value.dart';
import 'package:flutter/material.dart';

class ViewCharacterList extends StatelessWidget {
  final Character character;

  const ViewCharacterList({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(title: const Text("Abilities"), children: [
          for (var ability in character.stats.abilities)
            ListTile(
                leading: ability.isProficient
                    ? const Icon(Icons.check_box)
                    : const Icon(Icons.check_box_outline_blank),
                title: Text(capitalise(ability.name),
                    style: const TextStyle(fontSize: 18)),
                trailing: ViewProficientValue(ability: ability, proficiencyBonus: character.stats.proficiencyBonus),
                onLongPress: () {
                  showEditCharacterAbilityDialog(
                      context, ability, character.id);
                }),
        ]),
        ExpansionTile(title: const Text("Skills"), children: [
          for (var skill in character.stats.skills)
            ListTile(
                leading: skill.isProficient
                    ? const Icon(Icons.check_box)
                    : const Icon(Icons.check_box_outline_blank),
                title: Text(capitalise(skill.name),
                    style: const TextStyle(fontSize: 18)),
                trailing: Text(digitPrefix(skill.modifier),
                    style: const TextStyle(fontSize: 18)),
                onLongPress: () {
                  showEditSkillDialog(context, skill, character.id);
                }),
        ])
      ],
    );
  }
}
