import 'package:firstapp/common/models/dice.dart';
import 'package:firstapp/common/models/dice_throw.dart';
import 'package:firstapp/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditHitDice extends StatefulWidget {
  final Map<String, dynamic> stats;
  final Function(Map<String, dynamic> newValue) onChange;

  const EditHitDice({super.key, required this.stats, required this.onChange});

  @override
  State<EditHitDice> createState() => _EditHitDice();
}

class _EditHitDice extends State<EditHitDice> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    setState(() {
      final dice = widget.stats['hitDice'] as DiceThrow;
      controller = TextEditingController(text: dice.count.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text((widget.stats['hitDice'] as DiceThrow).toString(),
            style: const TextStyle(fontSize: 24)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  if (value.isEmpty) {
                    controller.text = '0';
                    return;
                  }
                  final newValue = clamp(int.parse(value), 0, 100);
                  setState(() {
                    controller.text = newValue.toString();
                  });
                  widget.stats['hitDice'] = DiceThrow(newValue, widget.stats['hitDice'].dice);
                  widget.onChange(widget.stats);
                },
              ),
            ),
            Flexible(
              child: DropdownButtonFormField(
                value: widget.stats['hitDice'].dice,
                onChanged: (value) {
                  setState(() {
                    widget.stats['hitDice'] =
                        DiceThrow(widget.stats['hitDice'].count, value as Dice);
                  });
                  widget.onChange(widget.stats);
                },
                items: Dice.values
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.name),
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
