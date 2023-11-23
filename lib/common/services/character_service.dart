import 'package:firstapp/common/models/character.dart';
import 'package:firstapp/common/models/character_class.dart';
import 'package:firstapp/common/models/character_stats.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CharacterService {
  String? _uuid;
  String? _name;

  String? _photoUrl;
  String _userId = '';

  CharacterClass _characterClass = CharacterClass.none;

  String get characterName => _name ?? 'No name';

  String get characterClassString => _characterClass.name;

  String get characterPhoto => _photoUrl ?? 'https://via.placeholder.com/150';

  String get characterUserId => _userId;

  String get uuid {
    if (_uuid == null) {
      final key = UniqueKey();
      _uuid = "$characterUserId-$key";
    }
    return _uuid!;
  }

  void setCharacterName(String name) => _name = name;

  void setCharacterClass(CharacterClass characterClass) =>
      _characterClass = characterClass;

  void setCharacterPhoto(String photoUrl) => _photoUrl = photoUrl;

  void setCharacterUserId(String userId) => _userId = userId;

  CharacterService();

  Future<void> pickPhoto() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    _photoUrl = image.path;
  }

  Character createCharacter() {
    if (_name == null) {
      throw Exception('Name is required');
    }
    if (_userId.isEmpty) {
      throw Exception('User ID is required');
    }

    return Character(
      id: uuid,
      name: characterName,
      characterClass: _characterClass,
      photoUrl: _photoUrl ?? '',
      userId: _userId,
      stats: CharacterStats(),
    );
  }

  void clear() {
    _name = null;
    _photoUrl = null;
    _userId = '';
    _characterClass = CharacterClass.none;
  }

  void deletePhoto() {
    _photoUrl = null;
  }
}
