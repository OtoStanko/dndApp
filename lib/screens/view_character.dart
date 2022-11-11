import 'package:firstapp/classes/character.dart';
import 'package:firstapp/db/database.dart';
import 'package:firstapp/screens/view_character_screens/character_edit.dart';
import 'package:firstapp/screens/view_character_screens/character_features.dart';
import 'package:firstapp/screens/view_character_screens/character_sheet.dart';
import 'package:firstapp/widgets/overlapping_panels.dart';
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
        body: Stack(
          children: [
            OverlappingPanels(
              // Using the Builder widget is not required. You can pass your widget directly. But to use `OverlappingPanelsState.of(context)` you need to wrap your widget in a Builder
              left: Builder(builder: (context) {
                return CharacterSheet(character: _character);
              }),
              right: Builder(builder: (context) {
                return CharacterEdit(character: _character);
              }),
              main: Builder(
                builder: (context) {
                  return CharacterFeatures(character: _character);
                },
              ),
              onSideChange: (side) {
                setState(() {
                  if (side == RevealSide.main) {
                    // hide something
                  } else if (side == RevealSide.left) {
                    // show something
                  }
                });
              },
            ),
            
          ],
        ));
  }
}


/*
SizedBox.expand(
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


        Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedSlide(
                duration: const Duration(milliseconds: 10),
                offset: const Offset(0, 1),
                child: SizedBox(
                  height: 90,
                  child: Material(
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.public,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.person_pin,
                                color: Colors.white54,
                                size: 32,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.search,
                                color: Colors.white54,
                                size: 32,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.alternate_email,
                                color: Colors.white54,
                                size: 32,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: CircleAvatar(
                                radius: 16,
                                foregroundImage: NetworkImage(
                                    "https://avatars.githubusercontent.com/u/5024388?v=4"),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            )
*/
