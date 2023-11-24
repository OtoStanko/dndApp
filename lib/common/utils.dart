import 'package:firstapp/common/models/character.dart';
import 'package:firstapp/common/models/character_class.dart';
import 'package:firstapp/common/models/character_stats.dart';

String capitalise(String s) => s[0].toUpperCase() + s.substring(1);

Character emptyCharacter = Character(
  id: '',
  name: '',
  characterClass: CharacterClass.none,
  photoUrl: '',
  userId: '',
  stats: CharacterStats(),
);

String digitPrefix(int num) {
  if (num == 0) {
    return "$num";
  }
  if (num >= 0) {
    return "+$num";
  }
  return "-${num.abs()}";
}

int calculateModifier(int value) {
  return ((value - 10) / 2).floor();
}

int clamp(int value, int min, int max) {
  if (value < min) {
    return min;
  }
  if (value > max) {
    return max;
  }
  return value;
}
