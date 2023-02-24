import 'package:awesome_select/awesome_select.dart';
import 'package:expandable/expandable.dart';
import 'package:firstapp/db/models/feature_model.dart';
import 'package:flutter/material.dart';

class ExpandedTile extends StatelessWidget {
  final Feature feature;
  final Function(Feature) onDelete;
  final Function() onTap;

  const ExpandedTile(
      {super.key,
      required this.feature,
      required this.onTap,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GestureDetector(
            onLongPress: () {
              // Delete feature dialog
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Delete ${feature.featureName}?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel")),
                        TextButton(
                            onPressed: () {
                              onDelete(feature);
                              Navigator.pop(context);
                            },
                            child: Text("Delete"))
                      ],
                    );
                  });
            },
            child: ExpandablePanel(
              header: _buildTitle(),
              collapsed: Container(),
              expanded: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text(feature.featureDescription),
                        const Spacer()
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SmartSelect.multiple(
                        title: "Feature Level",
                        choiceItems: generateUsedFeatures(),
                        choiceType: S2ChoiceType.chips,
                        modalType: S2ModalType.popupDialog,
                        onChange: (value) {
                          print(value);
                        },
                      )),
                ],
              ),
            )));
  }

  List<S2Choice> generateUsedFeatures() {
    return List.generate(feature.featureUsed, (index) => S2Choice(value: index, title: 'TRUE'))
      ..addAll(List.generate(
          feature.featureMaxLevel - feature.featureUsed, (index) => S2Choice(value: feature.featureUsed + index, title: 'FALSE')));
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(feature.featureName,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.w100)),
            const Spacer(),
            Text("${feature.featureUsed}/${feature.featureMaxLevel}"),
          ],
        ),
      ],
    );
  }
}
