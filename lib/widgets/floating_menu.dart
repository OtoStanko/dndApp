import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

class FloatingMenu extends StatefulWidget {
  final SharedPreferences preferences;
  final Function onPreferencesUpdate;
  const FloatingMenu(
      {super.key,
      required this.preferences,
      required this.onPreferencesUpdate});

  @override
  State<FloatingMenu> createState() => _FloatingMenuState();
}

class _FloatingMenuState extends State<FloatingMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 10, 16),
        child: SpeedDial(
          controller: _controller,
          // Add classes, Add features, Settings
          speedDialChildren: <SpeedDialChild>[
            SpeedDialChild(
              child: const Icon(Icons.person),
              backgroundColor: Colors.blue,
              onPressed: () {
                _controller.reverse();
                Navigator.pushNamed(context, '/editClasses')
                    .then((value) => setState(() {}));
              },
              label: 'Edit classes',
            ),
            SpeedDialChild(
              child: const Icon(Icons.list),
              backgroundColor: Colors.red,
              onPressed: () {
                _controller.reverse();
                Navigator.pushNamed(context, '/editFeatures')
                    .then((value) => setState(() {}));
              },
              label: 'Edit features',
            ),
            SpeedDialChild(
              child: const Icon(Icons.settings),
              backgroundColor: Colors.green,
              onPressed: () {
                _controller.reverse();
                Navigator.pushNamed(context, '/settings',
                        arguments: {'preferences': widget.preferences})
                    .then((value) => widget.onPreferencesUpdate());
              },
              label: 'Settings',
            ),
            //  Your other SpeedDialChildren go here.
          ],
          child: const Icon(Icons.settings),
        ));
  }
}
