import 'package:firstapp/common/models/ability.dart';
import 'package:firstapp/common/models/character.dart';
import 'package:firstapp/common/services/flutter_service.dart';
import 'package:firstapp/view_character/edit_ability.dart';
import 'package:firstapp/view_character/edit_skill.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void showEditCharacterAbilityDialog(
    BuildContext context, Ability ability, String characterId) {
  final service = GetIt.instance<FirebaseService>();

  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit ${ability.name}'),
          content: EditAbility(
              onChange: (Ability newValue) {
                service.updateAbilityEdit(newValue);
              },
              ability: ability),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel')),
            TextButton(
                onPressed: () {
                  final a = service.abilityEdit;
                  service.updateAbility(characterId, a);
                  Navigator.of(context).pop();
                },
                child: Text('Save')),
          ],
        );
      });
}

void showEditSkillDialog(
    BuildContext context, Ability ability, String characterId) {
  final service = GetIt.instance<FirebaseService>();

  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit ${ability.name}'),
          content: EditSkill(
              ability: ability,
              onChange: (Ability newValue) {
                service.updateAbilityEdit(newValue);
              }),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel')),
            TextButton(
                onPressed: () {
                  final a = service.abilityEdit;
                  service.updateAbility(characterId, a);
                  Navigator.of(context).pop();
                },
                child: Text('Save')),
          ],
        );
      });
}

void showEditHealthDialog(BuildContext context, Character character) {
  final service = GetIt.instance<FirebaseService>();
  final stats = character.stats.fixedStats;

  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Health'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text('Max HP'),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Temp HP'),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          //stats.temporaryHealthPoints = int.parse(value);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel')),
            TextButton(
                onPressed: () {
                  //service.updateHealth(character.id, stats);
                  Navigator.of(context).pop();
                },
                child: Text('Save')),
          ],
        );
      });
}
