import 'package:firstapp/common/utils.dart';
import 'package:flutter/material.dart';

class EditHealth extends StatefulWidget {
  final Map<String, dynamic> stats;
  final Function(Map<String, dynamic> newValue) onChange;

  const EditHealth({super.key, required this.stats, required this.onChange});

  @override
  State<EditHealth> createState() => _EditHealthState();
}

class _EditHealthState extends State<EditHealth> {
  @override
  Widget build(BuildContext context) {
    final maxHp = widget.stats['maxHealthPoints'];
    final currentHp = widget.stats['healthPoints'];
    final tempHp = widget.stats['temporaryHealthPoints'];

    return SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('Current Health Points'),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  final newValue = clamp(currentHp - 1, 0, maxHp);
                  setState(() {
                    widget.stats['healthPoints'] = newValue;
                  });
                  widget.onChange(widget.stats);
                },
                child: const Text('- 1'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Check if currentHp is less than 0
                  final newValue = clamp(currentHp - 5, 0, maxHp);
                  setState(() {
                    widget.stats['healthPoints'] = newValue;
                  });
                  widget.onChange(widget.stats);
                },
                child: const Text('- 5'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Check if currentHp is less than 0
                  final newValue = clamp(currentHp - 10, 0, maxHp);
                  setState(() {
                    widget.stats['healthPoints'] = newValue;
                  });
                  widget.onChange(widget.stats);
                },
                child: const Text('- 10'),
              ),
            ]),
        Text('$currentHp'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final newValue = clamp(currentHp + 1, 0, maxHp);
                setState(() {
                  widget.stats['healthPoints'] = newValue;
                });
                widget.onChange(widget.stats);
              },
              child: const Text('+ 1'),
            ),
            ElevatedButton(
              onPressed: () {
                final newValue = clamp(currentHp + 5, 0, maxHp);
                setState(() {
                  widget.stats['healthPoints'] = newValue;
                });
                widget.onChange(widget.stats);
              },
              child: const Text('+ 5'),
            ),
            ElevatedButton(
              onPressed: () {
                final newValue = clamp(currentHp + 10, 0, maxHp);
                setState(() {
                  widget.stats['healthPoints'] = newValue;
                });
                widget.onChange(widget.stats);
              },
              child: const Text('+ 10'),
            ),
          ],
        ),
        const Divider(),
        const Text('Maximum Health Points'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final newValue = clamp(maxHp - 1, 0, 999);
                setState(() {
                  widget.stats['maxHealthPoints'] = newValue;
                  if (currentHp > newValue) {
                    widget.stats['healthPoints'] = newValue;
                  }
                });
                widget.onChange(widget.stats);
              },
              child: const Text('- 1'),
            ),
            ElevatedButton(
              onPressed: () {
                final newValue = clamp(maxHp - 5, 0, 999);
                setState(() {
                  widget.stats['maxHealthPoints'] = newValue;
                  if (currentHp > newValue) {
                    widget.stats['healthPoints'] = newValue;
                  }
                });
                widget.onChange(widget.stats);
              },
              child: const Text('- 5'),
            ),
            ElevatedButton(
              onPressed: () {
                final newValue = clamp(maxHp - 10, 0, 999);
                setState(() {
                  widget.stats['maxHealthPoints'] = newValue;
                  if (currentHp > newValue) {
                    widget.stats['healthPoints'] = newValue;
                  }
                });
                widget.onChange(widget.stats);
              },
              child: const Text('- 10'),
            ),
          ],
        ),
        Text('$maxHp'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final newValue = clamp(maxHp + 1, 0, 999);
                setState(() {
                  widget.stats['maxHealthPoints'] = newValue;
                });
                widget.onChange(widget.stats);
              },
              child: const Text('+ 1'),
            ),
            ElevatedButton(
              onPressed: () {
                final newValue = clamp(maxHp + 5, 0, 999);
                setState(() {
                  widget.stats['maxHealthPoints'] = newValue;
                });
                widget.onChange(widget.stats);
              },
              child: const Text('+ 5'),
            ),
            ElevatedButton(
              onPressed: () {
                final newValue = clamp(maxHp + 10, 0, 999);
                setState(() {
                  widget.stats['maxHealthPoints'] = newValue;
                });
                widget.onChange(widget.stats);
              },
              child: const Text('+ 10'),
            ),
          ],
        ),
        const Divider(),
        const Text('Temporary Health Points'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final newValue = clamp(tempHp - 1, 0, 999);
                setState(() {
                  widget.stats['temporaryHealthPoints'] = newValue;
                });
                widget.onChange(widget.stats);
              },
              child: const Text('- 1'),
            ),
            ElevatedButton(
              onPressed: () {
                final newValue = clamp(tempHp - 5, 0, 999);
                setState(() {
                  widget.stats['temporaryHealthPoints'] = newValue;
                });
                widget.onChange(widget.stats);
              },
              child: const Text('- 5'),
            ),
            ElevatedButton(
              onPressed: () {
                final newValue = clamp(tempHp - 10, 0, 999);
                setState(() {
                  widget.stats['temporaryHealthPoints'] = newValue;
                });
                widget.onChange(widget.stats);
              },
              child: const Text('- 10'),
            ),
          ],
        ),
        Text('$tempHp'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final newValue = clamp(tempHp + 1, 0, 999);
                setState(() {
                  widget.stats['temporaryHealthPoints'] = newValue;
                });
                widget.onChange(widget.stats);
              },
              child: const Text('+ 1'),
            ),
            ElevatedButton(
              onPressed: () {
                final newValue = clamp(tempHp + 5, 0, 999);
                setState(() {
                  widget.stats['temporaryHealthPoints'] = newValue;
                });
                widget.onChange(widget.stats);
              },
              child: const Text('+ 5'),
            ),
            ElevatedButton(
              onPressed: () {
                final newValue = clamp(tempHp + 10, 0, 999);
                setState(() {
                  widget.stats['temporaryHealthPoints'] = newValue;
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
