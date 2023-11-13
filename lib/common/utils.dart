import 'package:firstapp/common/models/character.dart';
import 'package:firstapp/common/models/character_class.dart';

String capitalise(String s) => s[0].toUpperCase() + s.substring(1);

Character emptyCharacter = const Character(
  id: '',
  name: '',
  characterClass: CharacterClass.none,
  photoUrl: '',
  userId: '',
);
