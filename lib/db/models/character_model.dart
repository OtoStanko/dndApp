import 'dart:typed_data';

import 'package:firstapp/db/models/class_model.dart';

class Character {
  int id;
  Uint8List? image;
  String characterName;
  Class characterClass;

  Character({
    required this.id,
    required this.characterName,
    required this.characterClass,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'characterName': characterName,
      'characterClass': characterClass.id,
      'image': image
    };
  }

  @override
  String toString() {
    return 'Character{id: $id, name: $characterName, class: $characterClass, image: $image}';
  }
}
