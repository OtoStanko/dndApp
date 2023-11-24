import 'package:firstapp/common/models/ability.dart';
import 'package:firstapp/common/utils.dart';
import 'package:flutter/material.dart';

class EditAbility extends StatefulWidget {
  final Ability ability;
  final Function onChange;

  const EditAbility({super.key, required this.ability, required this.onChange});

  @override
  State<EditAbility> createState() => _EditAbilityState();
}

class _EditAbilityState extends State<EditAbility> {
  late final TextEditingController valueController;
  bool isProficient = false;

  @override
  void initState() {
    super.initState();
    valueController = TextEditingController(text: '${widget.ability.value}');
    // Clamp the value between 0 and 30
    valueController.addListener(() {
      final newValue = int.parse(valueController.text);
      if (newValue < 0) {
        valueController.text = '0';
      } else if (newValue > 30) {
        valueController.text = '30';
      }
    });
    valueController.addListener(() {
      final newAbility = widget.ability.copyWith(
          isProficient: isProficient, value: int.parse(valueController.text));
      widget.onChange(newAbility);
    });
    setState(() {
      isProficient = widget.ability.isProficient;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
            'Modifier: ${digitPrefix(calculateModifier(int.parse(valueController.text)))}'),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final newValue = int.parse(valueController.text) - 1;
                setState(() {
                  valueController.text = '$newValue';
                });
              },
              child: const Icon(Icons.remove),
            ),
            Text(
              valueController.text,
              style: const TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () {
                final newValue = int.parse(valueController.text) + 1;
                setState(() {
                  valueController.text = '$newValue';
                });
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              value: isProficient,
              onChanged: (newValue) {
                setState(() {
                  final newAbility = widget.ability.copyWith(
                      isProficient: newValue ?? false,
                      value: int.parse(valueController.text));
                  isProficient = newValue ?? false;
                  widget.onChange(newAbility);
                });
              },
            ),
            const Text('Proficient'),
          ],
        ),
      ],
    );
  }
}
