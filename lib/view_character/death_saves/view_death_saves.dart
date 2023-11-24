import 'package:firstapp/common/models/character.dart';
import 'package:firstapp/common/services/flutter_service.dart';
import 'package:firstapp/view_character/death_saves/togglelable_icon.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ViewDeathSaves extends StatelessWidget {
  final Character character;

  const ViewDeathSaves({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final service = GetIt.instance<FirebaseService>();

    return ExpansionTile(title: const Text("Death Saves"), children: [
      ListTile(
        title: const Text("Successes"),
        trailing: ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < character.stats.deathSavesSuccesses; i++)
              TogglableIcon(
                onChange: (newValue, oldValue) {
                  if (oldValue == newValue && oldValue) return;
                  if (oldValue && !newValue) {
                    service.updateDeathSaves(
                        character: character, isSuccess: true, value: -1);
                  } else {
                    service.updateDeathSaves(
                        character: character, isSuccess: true, value: 1);
                  }
                },
                value: true,
                iconFail: Icons.close,
                iconSuccess: Icons.check,
              ),
            for (var i = 0; i < 3 - character.stats.deathSavesSuccesses; i++)
              TogglableIcon(
                onChange: (newValue, oldValue) {
                  if (oldValue && !newValue) {
                    service.updateDeathSaves(
                        character: character, isSuccess: true, value: -1);
                  } else {
                    service.updateDeathSaves(
                        character: character, isSuccess: true, value: 1);
                  }
                },
                value: false,
                iconFail: Icons.close,
                iconSuccess: Icons.check,
              ),
          ],
        ),
      ),
      ListTile(
        title: const Text("Failures"),
        trailing: ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < character.stats.deathSavesFailures; i++)
              TogglableIcon(
                onChange: (newValue, oldValue) {
                  if (oldValue && !newValue) {
                    service.updateDeathSaves(
                        character: character, isSuccess: false, value: -1);
                  } else {
                    service.updateDeathSaves(
                        character: character, isSuccess: false, value: 1);
                  }
                },
                value: true,
                iconFail: Icons.close,
                iconSuccess: Icons.check,
              ),
            for (var i = 0; i < 3 - character.stats.deathSavesFailures; i++)
              TogglableIcon(
                onChange: (newValue, oldValue) {
                  if (oldValue && !newValue) {
                    service.updateDeathSaves(
                        character: character, isSuccess: false, value: -1);
                  } else {
                    service.updateDeathSaves(
                        character: character, isSuccess: false, value: 1);
                  }
                },
                value: false,
                iconFail: Icons.close,
                iconSuccess: Icons.check,
              ),
          ],
        ),
      ),
    ]);
  }
}
