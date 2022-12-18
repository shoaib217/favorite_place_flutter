import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

 ImageInput(this.onSelectImage);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _sortedImage;

  Future<void> _takePicture(ImageSource imgsrc) async {
    ImagePicker picker = ImagePicker();
    final imagefile = await picker.pickImage(source: imgsrc, maxWidth: 600);
    setState(() {
      _sortedImage = File(imagefile!.path);
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imagefile!.path);
    await imagefile.saveTo('${appDir.path}/$fileName');
    widget.onSelectImage(File(imagefile.path));
  }

  AlertDialog _dialog() {
    return AlertDialog(
      title: const Text('Image Option'),
      actions: [
        Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              TextButton.icon(
                  onPressed: () {
                    _takePicture(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Camera')),
              TextButton.icon(
                  onPressed: () {
                    _takePicture(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('Gallery')),
            ],
          ),
        ),
      ],
    );
  }
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
              : const Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
        ),
        const SizedBox(
          width: 20,
        ),
        TextButton.icon(
          onPressed: () =>
              showDialog(context: context, builder: (ctx) => _dialog()),
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
