import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstapp/common/models/character.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseService {
  final bucket = FirebaseStorage.instance;
  final collection = FirebaseFirestore.instance.collection("/characters");

  Stream<User?> get userAuth => FirebaseAuth.instance.authStateChanges();

  Stream<User?> get user => FirebaseAuth.instance.userChanges();

  Stream<List<Character>> get userCharacters {
    if (FirebaseAuth.instance.currentUser == null) {
      return const Stream.empty();
    }
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final doc = collection.doc(userId);
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

  Stream<Character> getCharacterById(String id) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const Stream.empty();
    }
    final characters = userCharacters;
    return characters.map((event) {
      return event.firstWhere((element) => element.id == id);
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
      final userCredential =
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
    final ref = bucketReference.child("character/$id.$fileType");
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
    final doc = await collection.doc(id).get();
    // Find the character with the matching ID
    final characters = doc.data()?['characters'] as List<dynamic>;
    final character = characters.firstWhere((element) => element['id'] == characterId);
    character['photo'] = url;
    await collection.doc(id).update({'characters': characters});
  }
}
