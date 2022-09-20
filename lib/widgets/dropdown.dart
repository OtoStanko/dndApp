import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  final List<String> classes;
  const Dropdown({super.key, required this.classes});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String dropdownValue = "";

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.classes.first;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Text("Class")),
        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
          },
          items: widget.classes.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )
      ],
    );
  }
}
