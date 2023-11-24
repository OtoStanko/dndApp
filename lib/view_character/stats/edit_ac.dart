import 'package:firstapp/common/utils.dart';
import 'package:flutter/material.dart';

class EditAC extends StatefulWidget {
  final Map<String, dynamic> stats;
  final Function(Map<String, dynamic> newValue) onChange;

  const EditAC({super.key, required this.stats, required this.onChange});

  @override
  State<EditAC> createState() => _EditAC();
}

class _EditAC extends State<EditAC> {
  @override
  Widget build(BuildContext context) {
    final ac = widget.stats['armorClass'];

    return SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final newValue = clamp(ac - 1, -7, 45);
                setState(() {
                  widget.stats['armorClass'] = newValue;
                });
                widget.onChange(widget.stats);
              },
              child: const Text('- 1'),
            ),
            ElevatedButton(
              onPressed: () {
                // Check if currentHp is less than 0
                final newValue = clamp(ac - 5, -7, 45);
                setState(() {
                  widget.stats['armorClass'] = newValue;
                });
                widget.onChange(widget.stats);
              },
              child: const Text('- 5'),
            ),
          ],
        ),
        Text('$ac', style: const TextStyle(fontSize: 24)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final newValue = clamp(ac + 1, -7, 45);
                setState(() {
                  widget.stats['armorClass'] = newValue;
                });
                widget.onChange(widget.stats);
              },
              child: const Text('+ 1'),
            ),
            ElevatedButton(
              onPressed: () {
                // Check if currentHp is less than 0
                final newValue = clamp(ac + 5, -7, 45);
                setState(() {
                  widget.stats['armorClass'] = newValue;
                });
                widget.onChange(widget.stats);
              },
              child: const Text('+ 5'),
            ),
          ],
        ),
      ]),
    );
  }
}
