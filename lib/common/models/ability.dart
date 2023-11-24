class Ability {
  final String name;
  final String shortname;
  final int value;
  final bool isProficient;
  final bool isSavingThrow;
  final bool isSkill;
  late int modifier;

  int Function(int proficiencyBonus) get valueWithProficiency => (int proficiencyBonus) {
    return value + (isProficient ? proficiencyBonus : 0);
  };

  Ability(
      {required this.name,
      required this.shortname,
      this.value = 10,
      this.isProficient = false,
      this.isSavingThrow = false,
      this.isSkill = false}) {
    // Check if the value is valid
    if (value < 1 || value > 30) {
      throw ArgumentError('Ability value must be between 1 and 30');
    }
    // Calculate the modifier
    modifier = ((value - 10) / 2).floor();
  }

  Ability copyWith(
      {String? name,
      String? shortname,
      int? value,
      bool? isProficient,
      bool? isSavingThrow,
      bool? isSkill}) {
    return Ability(
      name: name ?? this.name,
      shortname: shortname ?? this.shortname,
      value: value ?? this.value,
      isProficient: isProficient ?? this.isProficient,
      isSavingThrow: isSavingThrow ?? this.isSavingThrow,
      isSkill: isSkill ?? this.isSkill,
    );
  }

  @override
  String toString() {
    return 'Ability{name: $name, shortname: $shortname, value: $value, isProficient: $isProficient, isSavingThrow: $isSavingThrow, isSkill: $isSkill}';
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'shortname': shortname,
      'value': value,
      'isProficient': isProficient,
      'isSavingThrow': isSavingThrow,
      'isSkill': isSkill,
    };
  }

  factory Ability.fromMap(Map<String, dynamic> map) {
    return Ability(
      name: map['name'] as String,
      shortname: map['shortname'] as String,
      value: map['value'] as int,
      isProficient: map['isProficient'] as bool,
      isSavingThrow: map['isSavingThrow'] as bool,
      isSkill: map['isSkill'] as bool,
    );
  }
}
