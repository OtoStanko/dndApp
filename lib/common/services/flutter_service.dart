import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstapp/common/models/ability.dart';
import 'package:firstapp/common/models/character.dart';
import 'package:firstapp/common/models/character_stats.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseService {
  final bucket = FirebaseStorage.instance;
  final characterCollection =
      FirebaseFirestore.instance.collection("/characters");
  final statsCollection = FirebaseFirestore.instance.collection("/stats");

  Stream<User?> get userAuth => FirebaseAuth.instance.authStateChanges();

  Stream<User?> get user => FirebaseAuth.instance.userChanges();

  String get userId => FirebaseAuth.instance.currentUser?.uid ?? '-1';

  Stream<List<Character>> get userCharacters {
    if (FirebaseAuth.instance.currentUser == null) {
      return const Stream.empty();
    }
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final doc = characterCollection.doc(userId);
    return doc.snapshots().map((snapshot) {
      final data = snapshot.data();
      if (data == null) {
        return <Character>[];
      }
      return data['characters']
          .map<Character>(
              (character) => Character.fromMap(character, userId: snapshot.id))
          .toList();
    });
  }

  Stream<Character> getCharacterById(String characterId) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const Stream.empty();
    }
    final characters = userCharacters;
    return characters.map((event) {
      return event.firstWhere((element) => element.id == characterId);
    });
  }

  Stream<CharacterStats> getCharacterStats(String characterId) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const Stream.empty();
    }
    final userId = FirebaseAuth.instance.currentUser!.uid;
    if (userId.isEmpty) {
      return const Stream.empty();
    }
    final doc = statsCollection.doc(characterId);
    return doc.snapshots().map((snapshot) {
      final data = snapshot.data();
      if (data == null) {
        return CharacterStats();
      }
      final stats = CharacterStats.fromMap(data);
      return stats;
    });
  }

  Stream<Character> getFullCharacterById(String characterId) {
    final character = getCharacterById(characterId);
    final stats = getCharacterStats(characterId);

    return stats.asyncMap((event) async {
      var characterData = await character.first;
      characterData = characterData.copyWith(stats: event);
      return characterData;
    });
  }

  Future<void> init() async {
    // Check if user is logged in, if not, log in anonymously
    if (FirebaseAuth.instance.currentUser == null) {
      await FirebaseAuth.instance.signInAnonymously();
    }
  }

  FirebaseService() {
    init();
  }

  Future<User?> signIn(AuthCredential credential) async {
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return userCredential.user;
  }

  Future<void> promoteToUser(String email, String password) async {
    try {
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final username = email.split('@').first;
      await FirebaseAuth.instance.currentUser?.updateDisplayName(username);
    }
  }

  Future<void> deleteAnonymousUser() async {
    await FirebaseAuth.instance.currentUser?.delete();
    await FirebaseAuth.instance.signInAnonymously();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // Profile updates
  Future<void> updateDisplayName(String displayName) async {
    await FirebaseAuth.instance.currentUser?.updateDisplayName(displayName);
  }

  Future<void> updateUserPhoto() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    }
    final fileBytes = await pickedFile.readAsBytes();
    final fileType = pickedFile.path.split(".").last;

    final id = FirebaseAuth.instance.currentUser?.uid;
    if (id == null) {
      print("User is not logged in");
      return;
    }
    final bucketReference = bucket.ref();
    final ref = bucketReference.child("profile/$id.$fileType");
    // Remove any existing profile picture
    try {
      await ref.delete();
    } catch (e) {
      print("No existing photo found, skipping");
    }
    // Upload the new one
    await ref.putData(fileBytes);

    // Update the user's profile picture
    final url = await ref.getDownloadURL();
    await FirebaseAuth.instance.currentUser?.updatePhotoURL(url);
  }

  Future<void> updateCharacterPhoto(String characterId) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    }
    final fileBytes = await pickedFile.readAsBytes();
    final fileType = pickedFile.path.split(".").last;

    final id = FirebaseAuth.instance.currentUser?.uid;
    if (id == null) {
      print("User is not logged in");
      return;
    }
    final bucketReference = bucket.ref();
    final ref = bucketReference.child("character/$characterId.$fileType");
    // Remove any existing profile picture
    try {
      await ref.delete();
    } catch (e) {
      print("No existing photo found, skipping");
    }
    // Upload the new one
    await ref.putData(fileBytes);

    // Update the user's profile picture
    final url = await ref.getDownloadURL();
    // Update the character's photo
    final doc = await characterCollection.doc(id).get();
    // Find the character with the matching ID
    final characters = doc.data()?['characters'] as List<dynamic>;
    final character =
        characters.firstWhere((element) => element['id'] == characterId);
    character['photo'] = url;
    await characterCollection.doc(id).update({'characters': characters});
  }

  Future<String> createCharacterPhoto(String characterId) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return '';
    }
    final fileBytes = await pickedFile.readAsBytes();
    final fileType = pickedFile.path.split(".").last;

    final id = FirebaseAuth.instance.currentUser?.uid;
    if (id == null) {
      print("User is not logged in");
      return '';
    }
    final bucketReference = bucket.ref();
    final ref = bucketReference.child("character/$characterId.$fileType");
    // Remove any existing character picture
    try {
      await ref.delete();
    } catch (e) {
      print("No existing photo found, skipping");
    }
    // Upload the new one
    await ref.putData(fileBytes);

    // Return the URL
    final url = await ref.getDownloadURL();
    return url;
  }

  Future<void> removeCharacterPhoto(String characterId) async {
    final id = FirebaseAuth.instance.currentUser?.uid;
    if (id == null) {
      print("User is not logged in");
      return;
    }
    final doc = await characterCollection.doc(id).get();
    // Find the character with the matching ID
    final characters = doc.data()?['characters'] as List<dynamic>;
    final character =
        characters.firstWhere((element) => element['id'] == characterId);
    character['photo'] = '';
    await characterCollection.doc(id).update({'characters': characters});
  }

  Future<void> createCharacter(Character character) async {
    final id = FirebaseAuth.instance.currentUser?.uid;
    if (id == null) {
      print("User is not logged in");
      return;
    }
    final doc = await characterCollection.doc(id).get();
    if (!doc.exists) {
      await characterCollection.doc(id).set({});
    }

    final characters = doc.data()?['characters'] ?? [];
    characters.add(character.toMap());
    await characterCollection.doc(id).update({'characters': characters});

    // Create the stats for the character
    final statsDoc = await statsCollection.doc(character.id).get();
    if (!statsDoc.exists) {
      await statsCollection.doc(character.id).set({});
    }
    final stats = character.stats.toMap();
    await statsCollection.doc(character.id).update(stats);
  }

  Future<void> deleteCharacter(String characterId) async {
    final id = FirebaseAuth.instance.currentUser?.uid;
    if (id == null) {
      print("User is not logged in");
      return;
    }
    final doc = await characterCollection.doc(id).get();
    final characters = doc.data()?['characters'] as List<dynamic>;
    characters.removeWhere((element) => element['id'] == characterId);
    await characterCollection.doc(id).update({'characters': characters});

    // Delete the stats for the character
    await statsCollection.doc(characterId).delete();
  }

  // Stats
  Ability abilityEdit = Ability(name: '', value: 10, shortname: '');

  updateAbilityEdit(Ability ability) {
    abilityEdit = ability;
  }

  Ability getAbilityEdit() {
    return abilityEdit;
  }

  Future<void> updateAbility(String characterId, Ability ability) async {
    final id = FirebaseAuth.instance.currentUser?.uid;
    if (id == null) {
      print("User is not logged in");
      return;
    }
    final statsDoc = await statsCollection.doc(characterId).get();
    if (!statsDoc.exists) {
      await statsCollection.doc(characterId).set({});
    }
    final data = statsDoc.data();
    if (data == null || data.isEmpty) {
      return;
    }
    final stats = CharacterStats.fromMap(data);
    stats.updateAbility(ability);
    await statsCollection.doc(characterId).update(stats.toMap());
  }

  Map<String, dynamic> statsEdit = {};

  Map<String, dynamic> getStatsEdit() {
    return statsEdit;
  }

  Future<void> updateStatsEdit(Character character) async {
    final id = FirebaseAuth.instance.currentUser?.uid;
    if (id == null) {
      print("User is not logged in");
      return;
    }
    final statsDoc = await statsCollection.doc(character.id).get();
    if (!statsDoc.exists) {
      await statsCollection.doc(character.id).set({});
    }
    final data = statsDoc.data();
    if (data == null || data.isEmpty) {
      return;
    }
    final newStats = character.stats.copyWith(
        healthPoints: statsEdit['healthPoints'],
        temporaryHealthPoints: statsEdit['temporaryHealthPoints'],
        maxHealthPoints: statsEdit['maxHealthPoints'],
        armorClass: statsEdit['armorClass'],
        initiative: statsEdit['initiative'],
        hitDice: statsEdit['hitDice'],
        speed: statsEdit['speed'],
        proficiencyBonus: statsEdit['proficiencyBonus']);
    await statsCollection.doc(character.id).update(newStats.toMap());
  }

  void clearEditing() {
    abilityEdit = Ability(name: '', value: 10, shortname: '');
    statsEdit = {};
  }

  Future<void> updateDeathSaves(
      {required Character character,
      bool isSuccess = true,
      int value = 1}) async {
    final id = FirebaseAuth.instance.currentUser?.uid;
    if (id == null) {
      print("User is not logged in");
      return;
    }
    final statsDoc = await statsCollection.doc(character.id).get();
    if (!statsDoc.exists) {
      await statsCollection.doc(character.id).set({});
    }
    final data = statsDoc.data();
    if (data == null || data.isEmpty) {
      return;
    }
    final newStats = character.stats.copyWith(
        deathSavesSuccesses: isSuccess
            ? character.stats.deathSavesSuccesses + value
            : character.stats.deathSavesSuccesses,
        deathSavesFailures: !isSuccess
            ? character.stats.deathSavesFailures + value
            : character.stats.deathSavesFailures);
    await statsCollection.doc(character.id).update(newStats.toMap());
  }
}
