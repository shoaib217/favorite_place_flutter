import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_app/helpers/location_helper.dart';
import '../models/place.dart';
import 'dart:io';
import '../helpers/db_helper.dart';

class PlaceProvider with ChangeNotifier {
  List<Place> _items = [];
final placeTable = 'user_places';
  List<Place> get items {
    return [..._items];
  }

 Future<void> addPlace(String pickedTitle, File pickedImage,LatLng selectedLatLng) async{
    var address = await LocationHelper.getPlaceAddress(selectedLatLng.latitude, selectedLatLng.longitude);
    final placeLocation = PlaceLocation(address, selectedLatLng.latitude, selectedLatLng.longitude);
    final newPlace =
        Place(DateTime.now().toString(), pickedTitle, placeLocation, pickedImage);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert(placeTable, {
      'id':newPlace.id,
      'title':newPlace.title,
      'image':newPlace.image.path,
      'lat':selectedLatLng.latitude,
      'long':selectedLatLng.longitude,
      'address':address
    });
  }

  Future<void> fetchAndSetPlaces() async{
    final dataList = await DBHelper.getData(placeTable);
    _items =  dataList.map((item) => Place(item['id'], item['title'], PlaceLocation(item['address'], item['lat'], item['long']), File(item['image']))).toList();
    notifyListeners();
  }

  Future<void> deletePlace(String placeId)async{
    await DBHelper.deletePlace(placeTable, placeId);
    _items.removeWhere((element) => element.id == placeId);
    notifyListeners();
  }

  Place findById(String id){
    return _items.firstWhere((place) => place.id == id);
  }
}
