import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';
const googleApiKey = 'AIzaSyBc1jzXUZNLPYA61OF_jFtg0NF32YJun9U';

class LocationHelper{
  static String generateLocationPreviewImage({double? latitude,double? longitude}){
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=400x200&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$googleApiKey";
  }

  static Future<String> getPlaceAddress(double latitude, double longitude) async{
    final url = Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$googleApiKey");
    final response = await http.get(url);
    log("address ${json.decode(response.body)}");
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}