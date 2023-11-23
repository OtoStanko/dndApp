import 'package:firstapp/add_character/dropdown.dart';
import 'package:firstapp/add_character/input_name.dart';
import 'package:firstapp/common/services/character_service.dart';
import 'package:firstapp/common/services/flutter_service.dart';
import 'package:firstapp/common/widgets/navbar.dart';
import 'package:firstapp/dashboard/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AddCharacterPage extends StatelessWidget {
  const AddCharacterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = GetIt.instance<CharacterService>();
    final firebaseService = GetIt.instance<FirebaseService>();
    final userId = firebaseService.userId;
    service.setCharacterUserId(userId);

    return Column(
      children: [
        const Navbar(title: "Create character"),
        Expanded(
            child: SingleChildScrollView(
                child: Column(
          children: [
            const SizedBox(height: 16),
            const Text("Name"),
            InputWrapper(
              hint: "Enter a name",
              onChanged: (value) {
                service.setCharacterName(value);
              },
            ),
            const SizedBox(height: 16),
            const Text("Class"),
            const Dropdown(),
            const SizedBox(height: 16),
            const ImagePicker(),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, service.createCharacter());
                  service.clear();
                },
                child: const Text("Create character"))
          ],
        )))
      ],
    );
  }
}
