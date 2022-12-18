import 'package:flutter/material.dart';
import '../models/place.dart';
import 'dart:io';
import '../helpers/db_helper.dart';

class PlaceProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace =
        Place(DateTime.now().toString(), pickedTitle, null, pickedImage);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('places', {
      'id':newPlace.id,
      'title':newPlace.title,
      'image':newPlace.image.path,
    });
  }

  Future<void> fetchAndSetPlaces() async{
    final dataList = await DBHelper.getData('places');
    _items =  dataList.map((item) => Place(item['id'], item['title'], null, File(item['image']))).toList();
    notifyListeners();
  }
}
