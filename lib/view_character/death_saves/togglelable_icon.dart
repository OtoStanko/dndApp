import 'package:flutter/material.dart';

class TogglableIcon extends StatefulWidget {
  final IconData iconSuccess;
  final IconData iconFail;
  final Function(bool newValue, bool oldValue) onChange;
  final bool value;

  const TogglableIcon(
      {super.key,
      required this.onChange,
      required this.value,
      required this.iconSuccess,
      required this.iconFail});

  @override
  State<TogglableIcon> createState() => _TogglableIconState();
}

class _TogglableIconState extends State<TogglableIcon> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _value = widget.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          _value = !_value;
          widget.onChange(_value, widget.value);
        });
      },
      icon: Icon(_value ? widget.iconSuccess : widget.iconFail,
          color: _value ? Colors.green : Colors.red),
    );
  }
}
