import 'package:firstapp/common/utils.dart';
import 'package:flutter/material.dart';

class EditInitiative extends StatefulWidget {
  final Map<String, dynamic> stats;
  final Function(Map<String, dynamic> newValue) onChange;

  const EditInitiative(
      {super.key, required this.stats, required this.onChange});

  @override
  State<EditInitiative> createState() => _EditInitiative();
}

class _EditInitiative extends State<EditInitiative> {
  @override
  Widget build(BuildContext context) {
    final initiative = widget.stats['initiative'];

    return SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final newValue = clamp(initiative - 1, -10, 30);
                setState(() {
                  widget.stats['initiative'] = newValue;
                });
                widget.onChange(widget.stats);
              },
              child: const Text('- 1'),
            ),
            ElevatedButton(
              onPressed: () {
                // Check if currentHp is less than 0
                final newValue = clamp(initiative - 5, -10, 30);
                setState(() {
                  widget.stats['initiative'] = newValue;
                });
                widget.onChange(widget.stats);
              },
              child: const Text('- 5'),
            ),
          ],
        ),
        Text('$initiative', style: const TextStyle(fontSize: 24)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final newValue = clamp(initiative + 1, -10, 30);
                setState(() {
                  widget.stats['initiative'] = newValue;
                });
                widget.onChange(widget.stats);
              },
              child: const Text('+ 1'),
            ),
            ElevatedButton(
              onPressed: () {
                final newValue = clamp(initiative + 5, -10, 30);
                setState(() {
                  widget.stats['initiative'] = newValue;
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
