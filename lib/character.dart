enum Classes {
  druid,
  fighter,
  barbarian,
}

class Character {
  final int id;
  final String charName;
  final int charClass;
  final int charLvl;

  const Character( {
    required this.id,
    required this.charName,
    required this.charClass,
    required this.charLvl,
  });

Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': charName,
      'class': charClass,
      'level': charLvl,
    };
  }

@override
  String toString() {
    return 'Dog{id: $id, name: $charName, class: ${Classes.values[charClass]}, lvl: $charLvl}';
  }

}