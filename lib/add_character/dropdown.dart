import 'package:firstapp/common/models/character_class.dart';
import 'package:firstapp/common/services/character_service.dart';
import 'package:firstapp/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Dropdown extends StatelessWidget {
  const Dropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final service = GetIt.instance<CharacterService>();
    const classes = CharacterClass.values;
    return DropdownMenu<String>(
      menuHeight: 200,
      initialSelection: CharacterClass.none.name,
      onSelected: (value) {
        final characterClass = CharacterClass.values.firstWhere(
            (element) => element.name == value,
            orElse: () => CharacterClass.none);
        service.setCharacterClass(characterClass);
      },
      dropdownMenuEntries: classes.map((CharacterClass characterClass) {
        final name = capitalise(characterClass.name);
        return DropdownMenuEntry<String>(
            value: characterClass.name, label: name);
      }).toList(),
    );
  }
}
