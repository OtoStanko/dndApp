class Character {
  int id;
  final String iconPath;
  final String characterName;
  final String characterClass;

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
      'characterClass': characterClass,
      'iconPath': iconPath
    };
  }

  @override
  String toString() {
    return 'Character{id: $id, name: $characterName, class: $characterClass, icon: $iconPath}';
  }
}
