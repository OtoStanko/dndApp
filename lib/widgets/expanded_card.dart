import 'package:firstapp/db/models/feature_model.dart';
import 'package:firstapp/widgets/icon_check.dart';
import 'package:flutter/material.dart';

class ExpandedTile extends StatelessWidget {
  final Feature feature;

  const ExpandedTile({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      elevation: 2,
      margin: const EdgeInsets.only(left: 12.0, right: 12.0, top: 5, bottom: 5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpansionTile(
          backgroundColor: Colors.white,
          title: _buildTitle(),
          children: <Widget>[
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
              child: Wrap(
                  children: List.from(List.generate(feature.featureUsed,
                      (index) => IconChecked(checked: true)))
                    ..addAll(List.generate(
                        feature.featureMaxLevel - feature.featureUsed,
                        (index) => IconChecked(checked: false)))),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(feature.featureName, style: const TextStyle(fontSize: 30)),
            const Spacer(),
            Text("${feature.featureUsed}/${feature.featureMaxLevel}"),
          ],
        ),
      ],
    );
  }
}
