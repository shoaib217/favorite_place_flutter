import 'package:flutter/material.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _sortedImage = null;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          child: _sortedImage != null
              ? Image.file(
                  _sortedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text('No Image Taken',textAlign: TextAlign.center,),
        ),
        const SizedBox(width: 20,),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.camera_alt),
          label: Text(
            'Take Picture',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        )
      ],
    );
  }
}
