import 'package:flutter/material.dart';
import '../widgets/image_input.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../providers/place_provider.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;

  AlertDialog _showErrorDialog(String contentText) {
    return AlertDialog(
      title: const Text('Error'),
      content: Text(contentText),
    );
  }

  void _selectImage(File? pickedImage) {
    print('pickedImage - $pickedImage');
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (ctx) => _showErrorDialog("Title Can't be Empty!"));
      return;
    }
    if (_pickedImage == null) {
      showDialog(
          context: context,
          builder: (ctx) => _showErrorDialog('"Please Capture Image!"'));
      return;
    }
    Provider.of<PlaceProvider>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Place'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _savePlace,
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
            label: const Text(
              'ADD',
              style: TextStyle(color: Colors.black),
            ),
            style: const ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: MaterialStatePropertyAll(Colors.amber),
            ),
          ),
        ],
      ),
    );
  }
}
