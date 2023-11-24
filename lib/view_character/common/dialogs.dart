import 'package:firstapp/common/models/ability.dart';
import 'package:firstapp/common/models/character.dart';
import 'package:firstapp/common/services/flutter_service.dart';
import 'package:firstapp/view_character/abilities/edit_ability.dart';
import 'package:firstapp/view_character/skills/edit_skill.dart';
import 'package:firstapp/view_character/stats/edit_ac.dart';
import 'package:firstapp/view_character/stats/edit_health.dart';
import 'package:firstapp/view_character/stats/edit_hit_dice.dart';
import 'package:firstapp/view_character/stats/edit_initiative.dart';
import 'package:firstapp/view_character/stats/edit_proficiency.dart';
import 'package:firstapp/view_character/stats/edit_speed.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final service = GetIt.instance<FirebaseService>();

void showGeneralDialog(String title, Widget content, BuildContext context,
    Function onConfirm, Function onCancel) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            TextButton(
                onPressed: () {
                  onCancel();
                  service.clearEditing();
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  onConfirm();
                  Navigator.of(context).pop();
                },
                child: const Text('Confirm')),
          ],
        );
      });
}

void showEditCharacterAbilityDialog(BuildContext context, Ability ability,
    String characterId) {
  showGeneralDialog(
      'Edit ${ability.name}',
      EditAbility(
          ability: ability,
          onChange: (Ability newValue) {
            service.updateAbilityEdit(newValue);
          }),
      context, () {
    final a = service.abilityEdit;
    service.updateAbility(characterId, a);
  }, () {});
}

void showEditSkillDialog(BuildContext context, Ability ability,
    String characterId) {
  showGeneralDialog(
      'Edit ${ability.name}',
      EditSkill(
          ability: ability,
          onChange: (Ability newValue) {
            service.updateAbilityEdit(newValue);
          }),
      context, () {
    final a = service.abilityEdit;
    service.updateAbility(characterId, a);
  }, () {});
}

void showEditHealthDialog(BuildContext context, Character character) {
  final stats = character.stats.fixedStats;

  showGeneralDialog(
      'Edit Health',
      EditHealth(
          stats: stats,
          onChange: (Map<String, dynamic> newValue) {
            service.statsEdit = newValue;
          }),
      context, () {
    service.updateStatsEdit(character);
  }, () {});
}

void showEditArmorClassDialog(BuildContext context, Character character) {
  final stats = character.stats.fixedStats;

  showGeneralDialog(
      'Edit Armor Class',
      EditAC(
          stats: stats,
          onChange: (Map<String, dynamic> newValue) {
            service.statsEdit = newValue;
          }),
      context, () {
    service.updateStatsEdit(character);
  }, () {});
}

void showEditInitiativeDialog(BuildContext context, Character character) {
  final stats = character.stats.fixedStats;

  showGeneralDialog(
      'Edit Initiative',
      EditInitiative(
          stats: stats,
          onChange: (Map<String, dynamic> newValue) {
            service.statsEdit = newValue;
          }),
      context, () {
    service.updateStatsEdit(character);
  }, () {});
}

void showEditSpeedDialog(BuildContext context, Character character) {
  final stats = character.stats.fixedStats;

  showGeneralDialog(
      'Edit Speed',
      EditSpeed(
          stats: stats,
          onChange: (Map<String, dynamic> newValue) {
            service.statsEdit = newValue;
          }),
      context, () {
    service.updateStatsEdit(character);
  }, () {});
}

void showEditProficiencyDialog(BuildContext context, Character character) {
  final stats = character.stats.fixedStats;

  showGeneralDialog(
      'Edit Proficiency',
      EditProficiency(
          stats: stats,
          onChange: (Map<String, dynamic> newValue) {
            service.statsEdit = newValue;
          }),
      context, () {
    service.updateStatsEdit(character);
  }, () {});
}

void showEditHitDiceDialog(BuildContext context, Character character) {
  final stats = character.stats.fixedStats;

  showGeneralDialog(
      'Edit Hit Dice',
      EditHitDice(
          stats: stats,
          onChange: (Map<String, dynamic> newValue) {
            service.statsEdit = newValue;
          }),
      context, () {
    service.updateStatsEdit(character);
  }, () {});
}
