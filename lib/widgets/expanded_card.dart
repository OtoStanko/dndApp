import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:expandable/expandable.dart';
import 'package:firstapp/db/models/feature_model.dart';
import 'package:flutter/material.dart';

class ExpandedTile extends StatefulWidget {
  final Feature feature;
  final Function(Feature) onDelete;
  final Function(List<int>) onFeatureUpdate;

  const ExpandedTile(
      {super.key,
      required this.feature,
      required this.onFeatureUpdate,
      required this.onDelete});

  @override
  State<StatefulWidget> createState() => _ExpandedTile();
}

class _ExpandedTile extends State<ExpandedTile> {
  List<int> selected = [];
  int featureUsed = 0;
  int featureMax = 0;

  @override
  void initState() {
    super.initState();
    selected = List.generate(widget.feature.featureUsed, (index) => index);
    featureUsed = widget.feature.featureUsed;
    featureMax = widget.feature.featureMaxLevel;
  }

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
                      title: Text("Delete ${widget.feature.featureName}?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel")),
                        TextButton(
                            onPressed: () {
                              widget.onDelete(widget.feature);
                              Navigator.pop(context);
                            },
                            child: const Text("Yes"))
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
                        Flexible(child: Text(widget.feature.featureDescription))
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ChipsChoice<int>.multiple(
                        wrapped: true,
                        value: selected,
                        onChanged: (val) => setState(() {
                          selected = val;
                          widget.onFeatureUpdate(val);
                          setState(() {
                            featureUsed = val.length;
                          });
                        }),
                        choiceItems: C2Choice.listFrom<int, int>(
                          source: generateUsedFeatures(),
                          value: (i, v) => i,
                          label: (i, v) => v.toString(),
                        ),
                        choiceActiveStyle: const C2ChoiceStyle(
                          color: Colors.green,
                        ),
                        choiceStyle: const C2ChoiceStyle(
                            color: Colors.red, showCheckmark: false),
                      ))
                ],
              ),
            )));
  }

  List<int> generateUsedFeatures() {
    return List.generate(featureUsed, (index) => index)
      ..addAll(List.generate(
          featureMax - featureUsed,
          (index) => index + featureUsed));
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(widget.feature.featureName,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.w100)),
            const Spacer(),
            Text(
                "$featureUsed/$featureMax"),
          ],
        ),
      ],
    );
  }
}
