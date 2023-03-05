import 'package:firstapp/db/models/feature_model.dart';
import 'package:flutter/material.dart';

class AddFeatureModal extends StatefulWidget {
  final Function onSuccessfulSubmit;

  const AddFeatureModal({super.key, required this.onSuccessfulSubmit});

  @override
  State<AddFeatureModal> createState() => _AddFeatureModalState();
}

class _AddFeatureModalState extends State<AddFeatureModal> {
  String name = "";
  String description = "";

  @override
  Widget build(BuildContext context) {
    // Show dialog with text fields to add a custom class
    return TextButton(
        onPressed: () async {
          // Show dialog
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    title: const Text("Add custom feature"),
                    content: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            const Text("Name"),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Form(
                                  child: TextFormField(
                                validator: (value) => value!.isEmpty
                                    ? 'Please enter a name'
                                    : null,
                                onChanged: (value) {
                                  setState(() {
                                    name = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Name',
                                ),
                              )),
                            ),
                            const Text("Description"),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Form(
                                  child: TextFormField(
                                    maxLines: 7,
                                validator: (value) => value!.isEmpty
                                    ? 'Please enter a description'
                                    : null,
                                onChanged: (value) {
                                  setState(() {
                                    description = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Description',
                                ),
                              )),
                            ),
                          ],
                        )),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                      TextButton(
                          onPressed: () async {
                            if (name.isEmpty) {
                              return;
                            }
                            widget.onSuccessfulSubmit(Feature(
                                featureName: name,
                                featureDescription: description,
                                featureLevelAcquire: 1,
                                featureMaxLevel: -1,
                                featureUsed: -1,
                                featurePrimaryClass: -1,
                                id: -1));
                            Navigator.pop(context);
                          },
                          child: const Text("Add feature"))
                    ]);
              });
        },
        child: const Text("Add custom feature"));
  }
}
