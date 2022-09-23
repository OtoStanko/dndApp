import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  final Future<List<String>> classes;
  const Dropdown({super.key, required this.classes});

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
        dropdownValue = value.first;
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
