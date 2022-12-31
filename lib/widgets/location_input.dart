import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:place_app/helpers/location_helper.dart';
import 'package:place_app/models/place.dart';
import 'package:place_app/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentLocation() async {
    final locationData = await Location().getLocation();
    final staticImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: locationData.latitude, longitude: locationData.longitude);
    print('loca - $locationData');
    print('imgUrl - $staticImageUrl');

    setState(() {
      _previewImageUrl = staticImageUrl;
    });
  }

  Future<void> _selectOnMap() async {
    final latLng = await Location().getLocation();
    final selectedLocation = await Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (ctx) => MapScreen(
        initialLocation: LatLng(
          latLng.latitude!.toDouble(),
          latLng.longitude!.toDouble(),
        ),
        isSelecting: true,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          height: 170,
          width: double.infinity,
          child: _previewImageUrl == null
              ? const Text(
                  'No Location Choosen',
                  textAlign: TextAlign.center,
                )
              : Hero(
                  tag: _previewImageUrl.toString(),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/images/staticMap.png'),
                    image: NetworkImage(_previewImageUrl!),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () => _getCurrentLocation(),
              icon: Icon(
                Icons.location_on,
                color: Colors.red.shade500,
              ),
              label: Text(
                'Current Location',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(
                Icons.map,
                color: Colors.deepPurple,
              ),
              label: Text(
                'Select on Map',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            )
          ],
        ),
      ],
    );
  }
}
