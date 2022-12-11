import 'package:flutter/material.dart';
import 'package:place_app/screens/add_place_screen.dart';
import 'package:place_app/screens/place_list_screen.dart';
import 'package:provider/provider.dart';
import './providers/place_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const addPlace = '/add-place';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PlaceProvider(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
                .copyWith(secondary: Colors.amber)),
        home: const PlaceListScreen(),
        routes: {
          addPlace: (ctx) => const AddPlaceScreen(),
        },
      ),
    );
  }
}
