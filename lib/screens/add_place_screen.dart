import 'package:flutter/material.dart';
import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {

  final _titleController = TextEditingController();
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
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    const SizedBox(height: 10,),
                    ImageInput(),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: null,
            icon: const Icon(Icons.add),
            label: const Text('ADD'),
            style: const ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: MaterialStatePropertyAll(Colors.amber),),
          ),
        ],
      ),
    );
  }
}
