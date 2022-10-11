import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firstapp/classes/character.dart';
import 'package:firstapp/db/database.dart';
import 'package:firstapp/screens/view_character_screens/character_edit.dart';
import 'package:firstapp/screens/view_character_screens/character_sheet.dart';
import 'package:flutter/material.dart';

class ViewCharacter extends StatefulWidget {
  final int characterId;
  const ViewCharacter({Key? key, required this.characterId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ViewCharacter();
}

class _ViewCharacter extends State<ViewCharacter> {
  late Character _character;
  bool _loaded = false;

  // Page navigator
  int _currentIndex = 1;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    // Load character info from database
    _init(widget.characterId).then((value) {
      setState(() {
        _character = value;
        _loaded = true;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<Character> _init(int id) async {
    return await Database().getCharacter(id);
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return MaterialApp(
          home: Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 4, 64, 6),
                title: const Text("Loading character"),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              )));
    }

    // Bottom navigation items
    var bottomButtons = <BottomNavyBarItem>[
      BottomNavyBarItem(
          title: const Text('Character'), icon: const Icon(Icons.person)),
      BottomNavyBarItem(
          title: const Text('Features'), icon: const Icon(Icons.apps)),
      BottomNavyBarItem(
          title: const Text('Edit'), icon: const Icon(Icons.edit)),
    ];

    // View screens
    var viewScreens = <Widget>[
      CharacterSheet(character: _character),
      Container(
        color: Colors.red,
      ),
      CharacterEdit(character: _character)
    ];

    return Scaffold(
        appBar: AppBar(
            title: Text(_character.characterName),
            backgroundColor: const Color.fromARGB(255, 12, 127, 100),
            leading: _character.image != null
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: CircleAvatar(
                        backgroundImage: MemoryImage(_character.image!)))
                : const Icon(Icons.person)),
        body: SizedBox.expand(
          child: PageView(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              children: viewScreens),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          animationDuration: const Duration(milliseconds: 200),
          onItemSelected: (index) {
            setState(() => _currentIndex = index);
            _pageController.jumpToPage(index);
          },
          items: bottomButtons,
        ));
  }
}
