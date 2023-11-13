import 'package:firstapp/common/models/character_class.dart';

class Character {
  final String id;
  final String name;
  final CharacterClass characterClass;
  final String photoUrl;
  final String userId;
  const Character({required this.name, required this.characterClass, required this.userId, required this.id, this.photoUrl = ''});

  String get photo => photoUrl.isNotEmpty ? photoUrl : 'https://via.placeholder.com/150';

  @override
  String toString() {
    return 'Character{id: $id, name: $name, characterClass: $characterClass, user reference: $userId}, photoUrl: $photoUrl';
  }

  factory Character.fromMap(Map<String, dynamic> map, {String? userId}) {
    // Find the character class by name
    final characterClass = CharacterClass.values.firstWhere(
        (element) => element.name == map['class'],
        orElse: () => CharacterClass.none);
    return Character(
      id: map['id'] as String,
      name: map['name'] as String,
      characterClass: characterClass,
      userId: userId ?? "-1",
      photoUrl: map['photo'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'class': characterClass.name,
      'userId': userId,
      'photo': photoUrl,
    };
  }

  Character copyWith({
    String? id,
    String? name,
    CharacterClass? characterClass,
    String? userId,
    String? photoUrl
  }) {
    return Character(
      id: id ?? this.id,
      name: name ?? this.name,
      characterClass: characterClass ?? this.characterClass,
      userId: userId ?? this.userId,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}