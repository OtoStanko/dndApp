import 'package:firstapp/db/models/character_model.dart' as models;

class Character extends models.Character {
  int characterLevel;

  Character(
      {required super.id,
      required super.characterName,
      required super.characterClass,
      required super.iconPath,
      required this.characterLevel});

  @override
  Map<String, dynamic> toMap() {
    return super.toMap().putIfAbsent("characterLevel", () => characterLevel);
  }
}
