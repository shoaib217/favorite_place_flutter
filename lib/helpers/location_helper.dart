const googleApiKey = 'AIzaSyBc1jzXUZNLPYA61OF_jFtg0NF32YJun9U';

class LocationHelper{
  static String generateLocationPreviewImage({double? latitude,double? longitude}){
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=400x200&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$googleApiKey";
  }
}