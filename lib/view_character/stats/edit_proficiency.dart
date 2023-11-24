import 'package:firstapp/common/utils.dart';
import 'package:flutter/material.dart';

class EditProficiency extends StatefulWidget {
  final Map<String, dynamic> stats;
  final Function(Map<String, dynamic> newValue) onChange;

  const EditProficiency(
      {super.key, required this.stats, required this.onChange});

  @override
  State<EditProficiency> createState() => _EditProficiency();
}

class _EditProficiency extends State<EditProficiency> {
  @override
  Widget build(BuildContext context) {
    final proficiency = widget.stats['proficiencyBonus'];

    return SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              final newValue = clamp(proficiency - 1, 0, 10);
              setState(() {
                widget.stats['proficiencyBonus'] = newValue;
              });
              widget.onChange(widget.stats);
            },
            child: const Text('- 1'),
          ),
          Text(digitPrefix(proficiency), style: const TextStyle(fontSize: 24)),
          ElevatedButton(
            onPressed: () {
              final newValue = clamp(proficiency + 1, 0, 10);
              setState(() {
                widget.stats['proficiencyBonus'] = newValue;
              });
              widget.onChange(widget.stats);
            },
            child: const Text('+ 1'),
          ),
        ],
      ),
    ]));
  }
}
