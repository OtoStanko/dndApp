import 'package:firstapp/common/models/character.dart';
import 'package:firstapp/common/services/flutter_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ImageDrawer extends StatelessWidget {
  final Character character;

  const ImageDrawer({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final service = GetIt.instance<FirebaseService>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: GestureDetector(
        onLongPress: () {
          service.updateCharacterPhoto(character.id);
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: character.photoUrl.isNotEmpty
                ? Image.network(
                    character.photoUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    "https://via.placeholder.com/100",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )),
      ),
    );
  }
}
