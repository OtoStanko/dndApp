import 'package:firstapp/classes/character.dart';
import 'package:firstapp/db/database.dart';
import 'package:firstapp/db/models/feature_model.dart';
import 'package:firstapp/widgets/expanded_card.dart';
import 'package:flutter/material.dart';

class CharacterFeatures extends StatefulWidget {
  final Character character;
  const CharacterFeatures({Key? key, required this.character})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _CharacterFeaturesState();
}

class _CharacterFeaturesState extends State<CharacterFeatures> {
  late List<Feature> _features;
  bool _loaded = false;
  final db = Database();

  Future<List<Feature>> _init() async {
    return await Database().features(widget.character);
  }

  @override
  void initState() {
    super.initState();
    _reloadCharacters();
  }

  _reloadCharacters() {
    _init().then((value) {
      setState(() {
        _features = value;
        _loaded = true;
      });
    });
  }

  List<ExpandedTile> getFeatures() {
    return _features.map((feature) => ExpandedTile(feature: feature)).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const Center(child: CircularProgressIndicator());
    }

    final features = getFeatures();

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 5)
                ]),
            child: ListView(children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Features",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              ...features,
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 1)
                      ]),
                  margin: const EdgeInsets.all(15),
                  child: const Text("Add feature",
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center))
            ]
                //(features.isEmpty ? [const Text('No features')] : features)

                )));
  }
}
