import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final LatLng initialLocation;
  final bool isSelecting;

  const MapScreen(
      {super.key, required this.initialLocation, this.isSelecting = false});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  void _selectedLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  void _goBack() {
    if (_pickedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text('Please Picked Location'),action: SnackBarAction(label: 'Close',onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),),));
    } else {
      Navigator.of(context).pop(_pickedLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(
        "latLng in map - ${widget.initialLocation.latitude}, ${widget.initialLocation.longitude}");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Map'),
        actions: [
          if (widget.isSelecting)
            IconButton(onPressed: _pickedLocation ==null ? null : () =>  Navigator.of(context).pop(_pickedLocation), icon: const Icon(Icons.check))
        ],
      ),
      body: GoogleMap(
        buildingsEnabled: true,
        initialCameraPosition: CameraPosition(
          zoom: 16,
          target: LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longitude),
        ),
        onTap: widget.isSelecting ? _selectedLocation : null,
        markers: _pickedLocation == null
            ? {}
            : {Marker(markerId: const MarkerId('m1'), position: _pickedLocation!)},
      ),
    );
  }
}
