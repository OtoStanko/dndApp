import 'package:firstapp/common/models/ability.dart';
import 'package:flutter/material.dart';

class EditSkill extends StatefulWidget {
  final Ability ability;
  final Function onChange;
  const EditSkill({super.key, required this.ability, required this.onChange});

  @override
  State<EditSkill> createState() => _EditSkillState();
}

class _EditSkillState extends State<EditSkill> {
  late final TextEditingController valueController;
  bool isProficient = false;

  @override
  void initState() {
    super.initState();
    valueController = TextEditingController(text: '${widget.ability.value}');
    setState(() {
      isProficient = widget.ability.isProficient;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
