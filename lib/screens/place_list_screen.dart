import 'package:flutter/material.dart';
import 'package:place_app/main.dart';

class PlaceListScreen extends StatelessWidget {
  const PlaceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Great Places'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(MyApp.addPlace),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}
