import 'package:firstapp/common/services/character_service.dart';
import 'package:firstapp/common/services/flutter_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ImagePicker extends StatefulWidget {
  const ImagePicker({super.key});

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  bool forceRefresh = false;

  @override
  Widget build(BuildContext context) {
    final firebaseService = GetIt.I<FirebaseService>();
    final service = GetIt.I<CharacterService>();

    return Column(
      children: [
        const SizedBox(height: 16),
        const Text("Photo"),
        const SizedBox(height: 16),
        ElevatedButton(
            onPressed: () async {
              final url =
                  await firebaseService.createCharacterPhoto(service.uuid);
              print(url);
              service.setCharacterPhoto(url);
              setState(() {
                forceRefresh = !forceRefresh;
              });
            },
            child: const Text("Pick photo")),
        service.characterPhoto.isNotEmpty
            ? Image.network(service.characterPhoto, width: 200, height: 200)
            : const Text("No photo"),
      ],
    );
  }
}
