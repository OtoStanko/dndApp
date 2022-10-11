import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as picker;

class ImagePicker extends StatefulWidget {
  final Function onChanged;
  const ImagePicker({super.key, required this.onChanged});

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  File? file;

  _init() async {
    // Pick an image
    final image = await picker.ImagePicker()
        .pickImage(source: picker.ImageSource.gallery, imageQuality: 50);
    if (image == null) return;

    setState(() {
      file = File(image.path);
      widget.onChanged(file);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: 50,
            child: file != null
                ? Image.file(file!)
                : const Text("No image picked")),
        ElevatedButton(
          onPressed: () {
            _init();
          },
          child: const Text("Pick an icon"),
        )
      ],
    );
  }
}
