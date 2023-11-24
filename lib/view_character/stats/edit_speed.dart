import 'package:firstapp/common/utils.dart';
import 'package:flutter/material.dart';

class EditSpeed extends StatefulWidget {
  final Map<String, dynamic> stats;
  final Function(Map<String, dynamic> newValue) onChange;

  const EditSpeed({super.key, required this.stats, required this.onChange});

  @override
  State<EditSpeed> createState() => _EditSpeed();
}

class _EditSpeed extends State<EditSpeed> {
  @override
  Widget build(BuildContext context) {
    final speed = widget.stats['speed'];

    return SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Check if currentHp is less than 0
                final newValue = clamp(speed - 5, 0, 200);
                setState(() {
                  widget.stats['speed'] = newValue;
                });
                widget.onChange(widget.stats);
              },
              child: const Text('- 5'),
            ),
            ElevatedButton(
              onPressed: () {
                // Check if currentHp is less than 0
                final newValue = clamp(speed - 10, 0, 200);
                setState(() {
                  widget.stats['speed'] = newValue;
                });
                widget.onChange(widget.stats);
              },
              child: const Text('- 10'),
            ),
          ],
        ),
        Text('${speed}ft', style: const TextStyle(fontSize: 24)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Check if currentHp is less than 0
                final newValue = clamp(speed + 5, 0, 200);
                setState(() {
                  widget.stats['speed'] = newValue;
                });
                widget.onChange(widget.stats);
              },
              child: const Text('+ 5'),
            ),
            ElevatedButton(
              onPressed: () {
                // Check if currentHp is less than 0
                final newValue = clamp(speed + 10, 0, 200);
                setState(() {
                  widget.stats['speed'] = newValue;
                });
                widget.onChange(widget.stats);
              },
              child: const Text('+ 10'),
            ),
          ],
        ),
      ]),
    );
  }
}
