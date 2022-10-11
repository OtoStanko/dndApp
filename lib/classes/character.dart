import 'package:firstapp/db/models/character_model.dart' as models;

class Character extends models.Character {
  int characterLevel;

  Character(
      {required super.id,
      required super.characterName,
      required super.characterClass,
      super.image,
      required this.characterLevel});

  @override
  Map<String, dynamic> toMap() {
    var superMap = super.toMap();
    superMap.update("characterLevel", (value) => characterLevel.toString(),
        ifAbsent: () => characterLevel);
    return superMap;
  }

  @override
  String toString() {
    return "${super.toString().substring(0, super.toString().length - 1)}, characterLevel: $characterLevel}";
  }
}
