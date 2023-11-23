import 'package:firstapp/common/models/ability.dart';
import 'package:firstapp/common/services/flutter_service.dart';
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
          content: EditSkill(
              onChange: (int newValue) {
                service.setLastValue(newValue);
              },
              value: ability.value),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel')),
            TextButton(
                onPressed: () {
                  if (service.lastValue == -1 || service.lastValue == ability.value ) {
                    // We don't want to update the value if it hasn't changed
                    return;
                  }
                  service.updateAbility(
                      characterId, ability.copyWith(value: service.lastValue));
                },
                child: Text('Save')),
          ],
        );
      });
}
