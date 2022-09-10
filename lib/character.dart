enum Classes {
  druid,
  fighter,
  barbarian,
}

const String tableCharacters = "characters";

class CharacterFields {
  static final List<String> values = [
    id, charName, charClass, charLvl
  ];
  static const String id = "_id";
  static const String charName = "Name";
  static const String charClass = "Class";
  static const String charLvl = "Level";
}

class Character {
  final int? id;
  final String charName;
  final int charClass;
  final int charLvl;

  const Character({
    this.id,
    required this.charName,
    required this.charClass,
    required this.charLvl,
  });

  Character copy({
    int? id,
    String? charName,
    int? charClass,
    int? charLvl,
  }) => Character(
    id: id ?? this.id,
    charName: charName ?? this.charName,
    charClass: charClass ?? this.charClass,
    charLvl: charLvl ?? this.charLvl,
    );

  static Character fromJson(Map<String, Object?> json) => Character(
    id: json[CharacterFields.id] as int?,
    charName: json[CharacterFields.charName] as String,
    charClass: json[CharacterFields.charClass] as int,
    charLvl: json[CharacterFields.charLvl] as int,
  );

  Map<String, Object?> toJson() => {
    CharacterFields.id: id,
    CharacterFields.charName: charName,
    CharacterFields.charClass: charClass,
    CharacterFields.charLvl: charLvl,
  };
}