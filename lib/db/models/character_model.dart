import 'package:firstapp/db/models/class_model.dart';

class Character {
  int id;
  String iconPath = "";
  String characterName;
  Class characterClass;

  Character({
    required this.id,
    required this.characterName,
    required this.characterClass,
    required this.iconPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'characterName': characterName,
      'characterClass': characterClass.id,
      'iconPath': iconPath
    };
  }

  @override
  String toString() {
    return 'Character{id: $id, name: $characterName, class: $characterClass, iconPath: $iconPath}';
  }
}
