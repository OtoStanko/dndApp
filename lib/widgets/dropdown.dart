import 'package:firstapp/db/models/class_model.dart';
import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  final Future<List<String>> classes;
  final Class? initialValue;
  final Function onChanged;
  const Dropdown(
      {super.key,
      required this.classes,
      required this.onChanged,
      this.initialValue});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String dropdownValue = "";
  bool _loading = true;
  late List<String> _classes;

  @override
  void initState() {
    super.initState();
    _initialise();
  }

  _initialise() async {
    await widget.classes.then((value) {
      setState(() {
        dropdownValue = widget.initialValue != null
            ? widget.initialValue!.className
            : value.first;
        _classes = value;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const CircularProgressIndicator();
    }
    return Row(
      children: [
        const Expanded(child: Text("Character class", style: TextStyle(fontWeight: FontWeight.w100))),
        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
              widget.onChanged(value);
            });
          },
          items: _classes.map<DropdownMenuItem<String>>((String value) {
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
