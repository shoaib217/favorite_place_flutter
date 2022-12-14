import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_app/widgets/location_input.dart';
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
  LatLng? _selectedLatLng;


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

  void _selectedLocation(LatLng selectedLatLng){
    print("addPlaceSelectedLocation -$selectedLatLng ");
    _selectedLatLng = selectedLatLng;
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
    if(_selectedLatLng == null){
      showDialog(
          context: context,
          builder: (ctx) => _showErrorDialog('Please Choose Location'));
          return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    Provider.of<PlaceProvider>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!,_selectedLatLng!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Place'),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Column(
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
                      const SizedBox(height: 20,),
                      LocationInput(_selectedLocation),
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
              label: const Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0,15),
                child: Text(
                  'ADD',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              style: const ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: MaterialStatePropertyAll(Colors.amber),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
