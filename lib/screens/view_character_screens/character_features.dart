import 'package:firstapp/classes/character.dart';
import 'package:firstapp/db/database.dart';
import 'package:firstapp/db/models/feature_model.dart';
import 'package:firstapp/widgets/expanded_card.dart';
import 'package:flutter/material.dart';

import '../../widgets/feature_body.dart';

class CharacterFeatures extends StatefulWidget {
  final Character character;
  const CharacterFeatures({Key? key, required this.character})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _CharacterFeaturesState();
}

class _CharacterFeaturesState extends State<CharacterFeatures> {
  late Future<List<Feature>> featuresFuture;
  final db = Database();

  Future<List<Feature>> _init() async {
    return await Database().features(widget.character);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      featuresFuture = _init();
    });
  }

  List<ExpandedTile> getFeatures(List<Feature> features) {
    return features
        .map((feature) => ExpandedTile(
            feature: feature,
            onFeatureUpdate: (value) {
              setState(() {
                // Update feature used
                Feature updated = feature.copyWith(featureUsed: value.length);
                // Update database
                db.updateFeatureForCharacter(updated, widget.character);
              });
            },
            onDelete: (feature) {
              db.unassignFeature(feature, widget.character);
              setState(() {
                featuresFuture = _init();
              });
            }))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: featuresFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          var data = snapshot.data as List<Feature>;
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Features",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              if (data.isEmpty)
                const Text("No features found")
              else
                ...getFeatures(data),
              addButton(data)
            ],
          );
        });
  }

  // Add button-> open dialog and show list of features from database
  Widget addButton(List<Feature> featuresAssigned) {
    return ElevatedButton(
        onPressed: () {
          // open dialog with one button
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    title: const Text("Add Feature"),
                    content: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: FutureBuilder(
                            future: db.getAllFeatures(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              var data = snapshot.data as List<Feature>;
                              // Filter out features that are already assigned based on name and description (id is used from connections table)
                              data = data
                                  .where((element) => !featuresAssigned.any(
                                      (feature) =>
                                          feature.featureName ==
                                              element.featureName &&
                                          feature.featureDescription ==
                                              element.featureDescription))
                                  .toList();
                              if (data.isEmpty) {
                                return const Text("No features found");
                              }
                              return ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        FeatureBody(
                                            feature: data[index],
                                            onTap: (current, max) {
                                              Feature feature = data[index]
                                                  .copyWith(
                                                      featureMaxLevel: max,
                                                      featureUsed: current);
                                              // Add feature to character
                                              db.assignFeature(
                                                  feature, widget.character);
                                              // Update list
                                              setState(() {
                                                featuresFuture = _init();
                                              });
                                              // Close dialog
                                              Navigator.pop(context);
                                            }),
                                        const Divider()
                                      ],
                                    );
                                  });
                            })),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"))
                    ]);
              });
        },
        child: const Text("Add Feature"));
  }
}
