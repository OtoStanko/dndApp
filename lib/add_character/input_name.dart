import 'package:flutter/material.dart';

class InputWrapper extends StatefulWidget {
  final String hint;
  final Function(String value) onChanged;
  const InputWrapper({super.key, required this.hint, required this.onChanged});

  @override
  State<InputWrapper> createState() => _InputWrapperState();
}

class _InputWrapperState extends State<InputWrapper> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
          border: const OutlineInputBorder(), hintText: widget.hint),
      onChanged: (value) {
        widget.onChanged(value);
      }
    );
  }
}
