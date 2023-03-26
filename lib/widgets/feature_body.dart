import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import '../db/models/feature_model.dart';

class FeatureBody extends StatefulWidget {
  final Feature feature;
  final Function(int, int) onTap;

  const FeatureBody({super.key, required this.feature, required this.onTap});

  @override
  State<FeatureBody> createState() => _FeatureBodyState();
}

class _FeatureBodyState extends State<FeatureBody> {
  int currentlyUsed = 0;
  int maxUses = 1;
  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
        header: Text(widget.feature.featureName,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        collapsed: Container(),
        expanded: Container(
            child: Column(children: [
          Text(widget.feature.featureDescription),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(children: [
                NumberPicker(
                  value: currentlyUsed,
                  minValue: 0,
                  maxValue: maxUses,
                  onChanged: (value) {
                    setState(() {
                      currentlyUsed = value;
                    });
                  },
                ),
                Text("Currently : $currentlyUsed/$maxUses"),
              ]),
              Column(children: [
                NumberPicker(
                  value: maxUses,
                  minValue: 1,
                  maxValue: 20,
                  onChanged: (value) => setState(() {
                    maxUses = value;
                    if (currentlyUsed > maxUses) currentlyUsed = maxUses;
                  }),
                ),
                Text("Max Uses: $maxUses"),
              ]),
            ],
          ),
          // Button to save changes
          ElevatedButton(
              onPressed: () {
                widget.onTap(currentlyUsed, maxUses);
              },
              child: const Text("Save"))
        ])));
  }
}
