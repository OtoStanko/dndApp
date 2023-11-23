import 'dart:core';

import 'package:firstapp/common/models/ability.dart';
import 'package:firstapp/common/models/dice.dart';
import 'package:firstapp/common/models/dice_throw.dart';

class CharacterStats {
  // Fixed stats
  late int _level = 1;
  late int _experiencePoints = 0;
  late int _healthPoints = 0;
  late int _temporaryHealthPoints = 0;
  late int _maxHealthPoints = 0;
  late DiceThrow _hitDice = DiceThrow(0, Dice.d0);
  late int _speed = 0;
  late int _inspiration = 0;
  late int _proficiencyBonus = 0;
  late int _deathSavesSuccesses = 0;
  late int _deathSavesFailures = 0;

  // Ability scores
  late Ability _strength = Ability(name: 'Strength', shortname: 'STR');
  late Ability _dexterity = Ability(name: 'Dexterity', shortname: 'DEX');
  late Ability _constitution = Ability(name: 'Constitution', shortname: 'CON');
  late Ability _intelligence = Ability(name: 'Intelligence', shortname: 'INT');
  late Ability _wisdom = Ability(name: 'Wisdom', shortname: 'WIS');
  late Ability _charisma = Ability(name: 'Charisma', shortname: 'CHA');

  // Saving throws
  late Ability _strengthSavingThrow = Ability(
      name: 'Strength Saving Throw', shortname: 'STR', isSavingThrow: true);
  late Ability _dexteritySavingThrow = Ability(
      name: 'Dexterity Saving Throw', shortname: 'DEX', isSavingThrow: true);
  late Ability _constitutionSavingThrow = Ability(
      name: 'Constitution Saving Throw', shortname: 'CON', isSavingThrow: true);
  late Ability _intelligenceSavingThrow = Ability(
      name: 'Intelligence Saving Throw', shortname: 'INT', isSavingThrow: true);
  late Ability _wisdomSavingThrow = Ability(
      name: 'Wisdom Saving Throw', shortname: 'WIS', isSavingThrow: true);
  late Ability _charismaSavingThrow = Ability(
      name: 'Charisma Saving Throw', shortname: 'CHA', isSavingThrow: true);

  // Skills
  late Ability _acrobatics =
      Ability(name: 'Acrobatics', shortname: 'DEX', isSkill: true);
  late Ability _animalHandling =
      Ability(name: 'Animal Handling', shortname: 'WIS', isSkill: true);
  late Ability _arcana =
      Ability(name: 'Arcana', shortname: 'INT', isSkill: true);
  late Ability _athletics =
      Ability(name: 'Athletics', shortname: 'STR', isSkill: true);
  late Ability _deception =
      Ability(name: 'Deception', shortname: 'CHA', isSkill: true);
  late Ability _history =
      Ability(name: 'History', shortname: 'INT', isSkill: true);
  late Ability _insight =
      Ability(name: 'Insight', shortname: 'WIS', isSkill: true);
  late Ability _intimidation =
      Ability(name: 'Intimidation', shortname: 'CHA', isSkill: true);
  late Ability _investigation =
      Ability(name: 'Investigation', shortname: 'INT', isSkill: true);
  late Ability _medicine =
      Ability(name: 'Medicine', shortname: 'WIS', isSkill: true);
  late Ability _nature =
      Ability(name: 'Nature', shortname: 'INT', isSkill: true);
  late Ability _perception =
      Ability(name: 'Perception', shortname: 'WIS', isSkill: true);
  late Ability _performance =
      Ability(name: 'Performance', shortname: 'CHA', isSkill: true);
  late Ability _persuasion =
      Ability(name: 'Persuasion', shortname: 'CHA', isSkill: true);
  late Ability _religion =
      Ability(name: 'Religion', shortname: 'INT', isSkill: true);
  late Ability _sleightOfHand =
      Ability(name: 'Sleight of Hand', shortname: 'DEX', isSkill: true);
  late Ability _stealth =
      Ability(name: 'Stealth', shortname: 'DEX', isSkill: true);
  late Ability _survival =
      Ability(name: 'Survival', shortname: 'WIS', isSkill: true);

  // Combat
  late int _initiative = _dexterity.value;
  late int _armorClass = 10 + _dexterity.value;

  CharacterStats({
    int? level,
    int? experiencePoints,
    int? healthPoints,
    int? temporaryHealthPoints,
    int? maxHealthPoints,
    DiceThrow? hitDice,
    int? speed,
    int? inspiration,
    int? proficiencyBonus,
    int? deathSavesSuccesses,
    int? deathSavesFailures,
    int? initiative,
    int? armorClass,
    Ability? strength,
    Ability? dexterity,
    Ability? constitution,
    Ability? intelligence,
    Ability? wisdom,
    Ability? charisma,
    Ability? strengthSavingThrow,
    Ability? dexteritySavingThrow,
    Ability? constitutionSavingThrow,
    Ability? intelligenceSavingThrow,
    Ability? wisdomSavingThrow,
    Ability? charismaSavingThrow,
    Ability? acrobatics,
    Ability? animalHandling,
    Ability? arcana,
    Ability? athletics,
    Ability? deception,
    Ability? history,
    Ability? insight,
    Ability? intimidation,
    Ability? investigation,
    Ability? medicine,
    Ability? nature,
    Ability? perception,
    Ability? performance,
    Ability? persuasion,
    Ability? religion,
    Ability? sleightOfHand,
    Ability? stealth,
    Ability? survival,
  }) {
    _level = level ?? _level;
    _experiencePoints = experiencePoints ?? _experiencePoints;
    _healthPoints = healthPoints ?? _healthPoints;
    _temporaryHealthPoints = temporaryHealthPoints ?? _temporaryHealthPoints;
    _maxHealthPoints = maxHealthPoints ?? _maxHealthPoints;
    _hitDice = hitDice ?? _hitDice;
    _speed = speed ?? _speed;
    _inspiration = inspiration ?? _inspiration;
    _proficiencyBonus = proficiencyBonus ?? _proficiencyBonus;
    _deathSavesSuccesses = deathSavesSuccesses ?? _deathSavesSuccesses;
    _deathSavesFailures = deathSavesFailures ?? _deathSavesFailures;
    _initiative = initiative ?? _initiative;
    _armorClass = armorClass ?? _armorClass;
    _strength = strength ?? _strength;
    _dexterity = dexterity ?? _dexterity;
    _constitution = constitution ?? _constitution;
    _intelligence = intelligence ?? _intelligence;
    _wisdom = wisdom ?? _wisdom;
    _charisma = charisma ?? _charisma;
    _strengthSavingThrow = strengthSavingThrow ?? _strengthSavingThrow;
    _dexteritySavingThrow = dexteritySavingThrow ?? _dexteritySavingThrow;
    _constitutionSavingThrow =
        constitutionSavingThrow ?? _constitutionSavingThrow;
    _intelligenceSavingThrow =
        intelligenceSavingThrow ?? _intelligenceSavingThrow;
    _wisdomSavingThrow = wisdomSavingThrow ?? _wisdomSavingThrow;
    _charismaSavingThrow = charismaSavingThrow ?? _charismaSavingThrow;
    _acrobatics = acrobatics ?? _acrobatics;
    _animalHandling = animalHandling ?? _animalHandling;
    _arcana = arcana ?? _arcana;
    _athletics = athletics ?? _athletics;
    _deception = deception ?? _deception;
    _history = history ?? _history;
    _insight = insight ?? _insight;
    _intimidation = intimidation ?? _intimidation;
    _investigation = investigation ?? _investigation;
    _medicine = medicine ?? _medicine;
    _nature = nature ?? _nature;
    _perception = perception ?? _perception;
    _performance = performance ?? _performance;
    _persuasion = persuasion ?? _persuasion;
    _religion = religion ?? _religion;
    _sleightOfHand = sleightOfHand ?? _sleightOfHand;
    _stealth = stealth ?? _stealth;
    _survival = survival ?? _survival;

    recomputeValues();
  }

  void recomputeValues() {
    // Recompute all 'late' values, based on the current state if they are proficient or not
    final strengthValue = _strength.value +
        (_strengthSavingThrow.isProficient ? _proficiencyBonus : 0);
    _strengthSavingThrow = _strengthSavingThrow.copyWith(value: strengthValue);
    final dexterityValue = _dexterity.value +
        (_dexteritySavingThrow.isProficient ? _proficiencyBonus : 0);
    _dexteritySavingThrow =
        _dexteritySavingThrow.copyWith(value: dexterityValue);
    final constitutionValue = _constitution.value +
        (_constitutionSavingThrow.isProficient ? _proficiencyBonus : 0);
    _constitutionSavingThrow =
        _constitutionSavingThrow.copyWith(value: constitutionValue);
    final intelligenceValue = _intelligence.value +
        (_intelligenceSavingThrow.isProficient ? _proficiencyBonus : 0);
    _intelligenceSavingThrow =
        _intelligenceSavingThrow.copyWith(value: intelligenceValue);
    final wisdomValue = _wisdom.value +
        (_wisdomSavingThrow.isProficient ? _proficiencyBonus : 0);
    _wisdomSavingThrow = _wisdomSavingThrow.copyWith(value: wisdomValue);
    final charismaValue = _charisma.value +
        (_charismaSavingThrow.isProficient ? _proficiencyBonus : 0);
    _charismaSavingThrow = _charismaSavingThrow.copyWith(value: charismaValue);

    final acrobaticsValue =
        _dexterity.value + (_acrobatics.isProficient ? _proficiencyBonus : 0);
    _acrobatics = _acrobatics.copyWith(value: acrobaticsValue);
    final animalHandlingValue =
        _wisdom.value + (_animalHandling.isProficient ? _proficiencyBonus : 0);
    _animalHandling = _animalHandling.copyWith(value: animalHandlingValue);
    final arcanaValue =
        _intelligence.value + (_arcana.isProficient ? _proficiencyBonus : 0);
    _arcana = _arcana.copyWith(value: arcanaValue);
    final athleticsValue =
        _strength.value + (_athletics.isProficient ? _proficiencyBonus : 0);
    _athletics = _athletics.copyWith(value: athleticsValue);
    final deceptionValue =
        _charisma.value + (_deception.isProficient ? _proficiencyBonus : 0);
    _deception = _deception.copyWith(value: deceptionValue);
    final historyValue =
        _intelligence.value + (_history.isProficient ? _proficiencyBonus : 0);
    _history = _history.copyWith(value: historyValue);
    final insightValue =
        _wisdom.value + (_insight.isProficient ? _proficiencyBonus : 0);
    _insight = _insight.copyWith(value: insightValue);
    final intimidationValue =
        _charisma.value + (_intimidation.isProficient ? _proficiencyBonus : 0);
    _intimidation = _intimidation.copyWith(value: intimidationValue);
    final investigationValue = _intelligence.value +
        (_investigation.isProficient ? _proficiencyBonus : 0);
    _investigation = _investigation.copyWith(value: investigationValue);
    final medicineValue =
        _wisdom.value + (_medicine.isProficient ? _proficiencyBonus : 0);
    _medicine = _medicine.copyWith(value: medicineValue);
    final natureValue =
        _intelligence.value + (_nature.isProficient ? _proficiencyBonus : 0);
    _nature = _nature.copyWith(value: natureValue);
    final perceptionValue =
        _wisdom.value + (_perception.isProficient ? _proficiencyBonus : 0);
    _perception = _perception.copyWith(value: perceptionValue);
    final performanceValue =
        _charisma.value + (_performance.isProficient ? _proficiencyBonus : 0);
    _performance = _performance.copyWith(value: performanceValue);
    final persuasionValue =
        _charisma.value + (_persuasion.isProficient ? _proficiencyBonus : 0);
    _persuasion = _persuasion.copyWith(value: persuasionValue);
    final religionValue =
        _intelligence.value + (_religion.isProficient ? _proficiencyBonus : 0);
    _religion = _religion.copyWith(value: religionValue);
    final sleightOfHandValue = _dexterity.value +
        (_sleightOfHand.isProficient ? _proficiencyBonus : 0);
    _sleightOfHand = _sleightOfHand.copyWith(value: sleightOfHandValue);
    final stealthValue =
        _dexterity.value + (_stealth.isProficient ? _proficiencyBonus : 0);
    _stealth = _stealth.copyWith(value: stealthValue);
    final survivalValue =
        _wisdom.value + (_survival.isProficient ? _proficiencyBonus : 0);
    _survival = _survival.copyWith(value: survivalValue);
  }

  @override
  String toString() {
    return 'CharacterStats{level: $_level, experiencePoints: $_experiencePoints, healthPoints: $_healthPoints, temporaryHealthPoints: $_temporaryHealthPoints, maxHealthPoints: $_maxHealthPoints, hitDice: $_hitDice, speed: $_speed, inspiration: $_inspiration, proficiencyBonus: $_proficiencyBonus, deathSavesSuccesses: $_deathSavesSuccesses, deathSavesFailures: $_deathSavesFailures, initiative: $_initiative, armorClass: $_armorClass, strength: $_strength, dexterity: $_dexterity, constitution: $_constitution, intelligence: $_intelligence, wisdom: $_wisdom, charisma: $_charisma, strengthSavingThrow: $_strengthSavingThrow, dexteritySavingThrow: $_dexteritySavingThrow, constitutionSavingThrow: $_constitutionSavingThrow, intelligenceSavingThrow: $_intelligenceSavingThrow, wisdomSavingThrow: $_wisdomSavingThrow, charismaSavingThrow: $_charismaSavingThrow, acrobatics: $_acrobatics, animalHandling: $_animalHandling, arcana: $_arcana, athletics: $_athletics, deception: $_deception, history: $_history, insight: $_insight, intimidation: $_intimidation, investigation: $_investigation, medicine: $_medicine, nature: $_nature, perception: $_perception, performance: $_performance, persuasion: $_persuasion, religion: $_religion, sleightOfHand: $_sleightOfHand, stealth: $_stealth, survival: $_survival}';
  }

  CharacterStats copyWith(
      {int? level,
      int? experiencePoints,
      int? healthPoints,
      int? temporaryHealthPoints,
      int? maxHealthPoints,
      DiceThrow? hitDice,
      int? speed,
      int? inspiration,
      int? proficiencyBonus,
      int? deathSavesSuccesses,
      int? deathSavesFailures,
      int? initiative,
      int? armorClass,
      Ability? strength,
      Ability? dexterity,
      Ability? constitution,
      Ability? intelligence,
      Ability? wisdom,
      Ability? charisma,
      Ability? strengthSavingThrow,
      Ability? dexteritySavingThrow,
      Ability? constitutionSavingThrow,
      Ability? intelligenceSavingThrow,
      Ability? wisdomSavingThrow,
      Ability? charismaSavingThrow,
      Ability? acrobatics,
      Ability? animalHandling,
      Ability? arcana,
      Ability? athletics,
      Ability? deception,
      Ability? history,
      Ability? insight,
      Ability? intimidation,
      Ability? investigation,
      Ability? medicine,
      Ability? nature,
      Ability? perception,
      Ability? performance,
      Ability? persuasion,
      Ability? religion,
      Ability? sleightOfHand,
      Ability? stealth,
      Ability? survival}) {
    return CharacterStats(
      level: level ?? _level,
      experiencePoints: experiencePoints ?? _experiencePoints,
      healthPoints: healthPoints ?? _healthPoints,
      temporaryHealthPoints: temporaryHealthPoints ?? _temporaryHealthPoints,
      maxHealthPoints: maxHealthPoints ?? _maxHealthPoints,
      hitDice: hitDice ?? _hitDice,
      speed: speed ?? _speed,
      inspiration: inspiration ?? _inspiration,
      proficiencyBonus: proficiencyBonus ?? _proficiencyBonus,
      deathSavesSuccesses: deathSavesSuccesses ?? _deathSavesSuccesses,
      deathSavesFailures: deathSavesFailures ?? _deathSavesFailures,
      initiative: initiative ?? _initiative,
      armorClass: armorClass ?? _armorClass,
      strength: strength ?? _strength,
      dexterity: dexterity ?? _dexterity,
      constitution: constitution ?? _constitution,
      intelligence: intelligence ?? _intelligence,
      wisdom: wisdom ?? _wisdom,
      charisma: charisma ?? _charisma,
      strengthSavingThrow: strengthSavingThrow ?? _strengthSavingThrow,
      dexteritySavingThrow: dexteritySavingThrow ?? _dexteritySavingThrow,
      constitutionSavingThrow: constitutionSavingThrow ?? _constitutionSavingThrow,
      intelligenceSavingThrow: intelligenceSavingThrow ?? _intelligenceSavingThrow,
      wisdomSavingThrow: wisdomSavingThrow ?? _wisdomSavingThrow,
      charismaSavingThrow: charismaSavingThrow ?? _charismaSavingThrow,
      acrobatics: acrobatics ?? _acrobatics,
      animalHandling: animalHandling ?? _animalHandling,
      arcana: arcana ?? _arcana,
      athletics: athletics ?? _athletics,
      deception: deception ?? _deception,
      history: history ?? _history,
      insight: insight ?? _insight,
      intimidation: intimidation ?? _intimidation,
      investigation: investigation ?? _investigation,
      medicine: medicine ?? _medicine,
      nature: nature ?? _nature,
      perception: perception ?? _perception,
      performance: performance ?? _performance,
      persuasion: persuasion ?? _persuasion,
      religion: religion ?? _religion,
      sleightOfHand: sleightOfHand ?? _sleightOfHand,
      stealth: stealth ?? _stealth,
      survival: survival ?? _survival
    );
  }

  int get level => _level;

  int get experiencePoints => _experiencePoints;

  int get healthPoints => _healthPoints;

  int get temporaryHealthPoints => _temporaryHealthPoints;

  int get maxHealthPoints => _maxHealthPoints;

  DiceThrow get hitDice => _hitDice;

  int get speed => _speed;

  int get inspiration => _inspiration;

  int get proficiencyBonus => _proficiencyBonus;

  int get deathSavesSuccesses => _deathSavesSuccesses;

  int get deathSavesFailures => _deathSavesFailures;

  int get initiative => _initiative;

  int get armorClass => _armorClass;

  Ability get strength => _strength;

  Ability get dexterity => _dexterity;

  Ability get constitution => _constitution;

  Ability get intelligence => _intelligence;

  Ability get wisdom => _wisdom;

  Ability get charisma => _charisma;

  Ability get strengthSavingThrow => _strengthSavingThrow;

  Ability get dexteritySavingThrow => _dexteritySavingThrow;

  Ability get constitutionSavingThrow => _constitutionSavingThrow;

  Ability get intelligenceSavingThrow => _intelligenceSavingThrow;

  Ability get wisdomSavingThrow => _wisdomSavingThrow;

  Ability get charismaSavingThrow => _charismaSavingThrow;

  Ability get acrobatics => _acrobatics;

  Ability get animalHandling => _animalHandling;

  Ability get arcana => _arcana;

  Ability get athletics => _athletics;

  Ability get deception => _deception;

  Ability get history => _history;

  Ability get insight => _insight;

  Ability get intimidation => _intimidation;

  Ability get investigation => _investigation;

  Ability get medicine => _medicine;

  Ability get nature => _nature;

  Ability get perception => _perception;

  Ability get performance => _performance;

  Ability get persuasion => _persuasion;

  Ability get religion => _religion;

  Ability get sleightOfHand => _sleightOfHand;

  Ability get stealth => _stealth;

  Ability get survival => _survival;

  List<Ability> get abilities => [
        _strength,
        _dexterity,
        _constitution,
        _intelligence,
        _wisdom,
        _charisma,
      ];

  List<Ability> get savingThrows => [
        _strengthSavingThrow,
        _dexteritySavingThrow,
        _constitutionSavingThrow,
        _intelligenceSavingThrow,
        _wisdomSavingThrow,
        _charismaSavingThrow,
      ];

  List<Ability> get skills => [
        _acrobatics,
        _animalHandling,
        _arcana,
        _athletics,
        _deception,
        _history,
        _insight,
        _intimidation,
        _investigation,
        _medicine,
        _nature,
        _perception,
        _performance,
        _persuasion,
        _religion,
        _sleightOfHand,
        _stealth,
        _survival,
      ];

  List<Ability> get allAbilities => [
        ...abilities,
        ...savingThrows,
        ...skills,
      ];

  Map<String, dynamic> toMap() {
    return {
      'level': _level,
      'experiencePoints': _experiencePoints,
      'healthPoints': _healthPoints,
      'temporaryHealthPoints': _temporaryHealthPoints,
      'maxHealthPoints': _maxHealthPoints,
      'hitDice': _hitDice.toString(),
      'speed': _speed,
      'inspiration': _inspiration,
      'proficiencyBonus': _proficiencyBonus,
      'deathSavesSuccesses': _deathSavesSuccesses,
      'deathSavesFailures': _deathSavesFailures,
      'initiative': _initiative,
      'armorClass': _armorClass,
      'strength': _strength.toMap(),
      'dexterity': _dexterity.toMap(),
      'constitution': _constitution.toMap(),
      'intelligence': _intelligence.toMap(),
      'wisdom': _wisdom.toMap(),
      'charisma': _charisma.toMap(),
      'strengthSavingThrow': _strengthSavingThrow.toMap(),
      'dexteritySavingThrow': _dexteritySavingThrow.toMap(),
      'constitutionSavingThrow': _constitutionSavingThrow.toMap(),
      'intelligenceSavingThrow': _intelligenceSavingThrow.toMap(),
      'wisdomSavingThrow': _wisdomSavingThrow.toMap(),
      'charismaSavingThrow': _charismaSavingThrow.toMap(),
      'acrobatics': _acrobatics.toMap(),
      'animalHandling': _animalHandling.toMap(),
      'arcana': _arcana.toMap(),
      'athletics': _athletics.toMap(),
      'deception': _deception.toMap(),
      'history': _history.toMap(),
      'insight': _insight.toMap(),
      'intimidation': _intimidation.toMap(),
      'investigation': _investigation.toMap(),
      'medicine': _medicine.toMap(),
      'nature': _nature.toMap(),
      'perception': _perception.toMap(),
      'performance': _performance.toMap(),
      'persuasion': _persuasion.toMap(),
      'religion': _religion.toMap(),
      'sleightOfHand': _sleightOfHand.toMap(),
      'stealth': _stealth.toMap(),
      'survival': _survival.toMap(),
    };
  }

  factory CharacterStats.fromMap(Map<String, dynamic> map) {
    return CharacterStats(
      level: map['level'] as int,
      experiencePoints: map['experiencePoints'] as int,
      healthPoints: map['healthPoints'] as int,
      temporaryHealthPoints: map['temporaryHealthPoints'] as int,
      maxHealthPoints: map['maxHealthPoints'] as int,
      hitDice: DiceThrow.fromMap(map['hitDice']),
      speed: map['speed'] as int,
      inspiration: map['inspiration'] as int,
      proficiencyBonus: map['proficiencyBonus'] as int,
      deathSavesSuccesses: map['deathSavesSuccesses'] as int,
      deathSavesFailures: map['deathSavesFailures'] as int,
      initiative: map['initiative'] as int,
      armorClass: map['armorClass'] as int,
      strength: Ability.fromMap(map['strength'] as Map<String, dynamic>),
      dexterity: Ability.fromMap(map['dexterity'] as Map<String, dynamic>),
      constitution:
          Ability.fromMap(map['constitution'] as Map<String, dynamic>),
      intelligence:
          Ability.fromMap(map['intelligence'] as Map<String, dynamic>),
      wisdom: Ability.fromMap(map['wisdom'] as Map<String, dynamic>),
      charisma: Ability.fromMap(map['charisma'] as Map<String, dynamic>),
      strengthSavingThrow:
          Ability.fromMap(map['strengthSavingThrow'] as Map<String, dynamic>),
      dexteritySavingThrow:
          Ability.fromMap(map['dexteritySavingThrow'] as Map<String, dynamic>),
      constitutionSavingThrow: Ability.fromMap(
          map['constitutionSavingThrow'] as Map<String, dynamic>),
      intelligenceSavingThrow: Ability.fromMap(
          map['intelligenceSavingThrow'] as Map<String, dynamic>),
      wisdomSavingThrow:
          Ability.fromMap(map['wisdomSavingThrow'] as Map<String, dynamic>),
      charismaSavingThrow:
          Ability.fromMap(map['charismaSavingThrow'] as Map<String, dynamic>),
      acrobatics: Ability.fromMap(map['acrobatics'] as Map<String, dynamic>),
      animalHandling:
          Ability.fromMap(map['animalHandling'] as Map<String, dynamic>),
      arcana: Ability.fromMap(map['arcana'] as Map<String, dynamic>),
      athletics: Ability.fromMap(map['athletics'] as Map<String, dynamic>),
      deception: Ability.fromMap(map['deception'] as Map<String, dynamic>),
      history: Ability.fromMap(map['history'] as Map<String, dynamic>),
      insight: Ability.fromMap(map['insight'] as Map<String, dynamic>),
      intimidation:
          Ability.fromMap(map['intimidation'] as Map<String, dynamic>),
      investigation:
          Ability.fromMap(map['investigation'] as Map<String, dynamic>),
      medicine: Ability.fromMap(map['medicine'] as Map<String, dynamic>),
      nature: Ability.fromMap(map['nature'] as Map<String, dynamic>),
      perception: Ability.fromMap(map['perception'] as Map<String, dynamic>),
      performance: Ability.fromMap(map['performance'] as Map<String, dynamic>),
      persuasion: Ability.fromMap(map['persuasion'] as Map<String, dynamic>),
      religion: Ability.fromMap(map['religion'] as Map<String, dynamic>),
      sleightOfHand:
          Ability.fromMap(map['sleightOfHand'] as Map<String, dynamic>),
      stealth: Ability.fromMap(map['stealth'] as Map<String, dynamic>),
      survival: Ability.fromMap(map['survival'] as Map<String, dynamic>),
    );
  }
}
