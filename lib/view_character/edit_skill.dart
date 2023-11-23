import 'package:firstapp/common/utils.dart';
import 'package:flutter/material.dart';

class EditSkill extends StatefulWidget {
  final int value;
  final Function onChange;

  const EditSkill({super.key, this.value = 0, required this.onChange});

  @override
  State<EditSkill> createState() => _EditSkillState();
}

class _EditSkillState extends State<EditSkill> {
  late final TextEditingController valueController;

  @override
  void initState() {
    super.initState();
    valueController = TextEditingController(text: '${widget.value}');
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
      final newValue = int.parse(valueController.text);
      widget.onChange(newValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Modifier: ${digitPrefix(calculateModifier(int.parse(valueController.text)))}'),
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
      ],
    );
  }
}
