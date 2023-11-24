import 'package:firstapp/common/models/ability.dart';
import 'package:firstapp/common/utils.dart';
import 'package:flutter/material.dart';

class ViewProficientValue extends StatelessWidget {
  final Ability ability;
  final int proficiencyBonus;

  const ViewProficientValue(
      {super.key, required this.ability, required this.proficiencyBonus});

  @override
  Widget build(BuildContext context) {
    final value = ability.valueWithProficiency(proficiencyBonus);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(digitPrefix(calculateModifier(value)),
            style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 8),
        Text("($value)", style: const TextStyle(fontSize: 18)),
      ],
    );
  }
}
