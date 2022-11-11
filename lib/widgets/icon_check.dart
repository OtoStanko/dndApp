import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconChecked extends StatelessWidget {
  bool ?checked;
  IconChecked({Key? key, this.checked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5),
        child: Icon(
          (checked ?? false) ? Icons.check :  Icons.close,
          size: 40,
          color: (checked ?? false) ? Colors.green : Colors.red
        ));
  }
}
