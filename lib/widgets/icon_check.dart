import 'dart:math';

import 'package:flutter/material.dart';

class IconChecked extends StatefulWidget {
  bool checked;
  IconChecked({Key? key, required this.checked}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IconChecked();
}

class _IconChecked extends State<IconChecked>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation color;
  late Animation<dynamic> spin;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 200), //controll animation duration
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    color = widget.checked
        ? ColorTween(
            begin: Colors.green,
            end: Colors.red,
          ).animate(controller)
        : ColorTween(
            begin: Colors.red,
            end: Colors.green,
          ).animate(controller);

    spin = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5),
        child: Transform.rotate(
            angle: spin.value,
            child: IconButton(
                icon: Icon((widget.checked) ? Icons.check : Icons.close),
                onPressed: () {
                  (controller.value == 1)
                      ? controller.reverse()
                      : controller.forward();
                  setState(() {
                    widget.checked = !widget.checked;
                  });
                },
                color: color.value)));
  }
}
