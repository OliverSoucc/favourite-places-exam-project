import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/place_locations_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    required this.location,
    this.isSelected = true,
  });

  final PlaceLocation location;
  final bool isSelected;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelected ? 'Pick your location' : 'Your location'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop(_pickedLocation);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: GoogleMap(
        onTap: !widget.isSelected
            ? null
            : (position) {
                setState(() {
                  _pickedLocation = position;
                });
              },
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.location.latitude!.toDouble(),
              widget.location.longtitude!.toDouble()),
          zoom: 16,
        ),
        markers: (_pickedLocation == null && widget.isSelected)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: _pickedLocation ??
                      LatLng(widget.location.latitude!.toDouble(),
                          widget.location.longtitude!.toDouble()),
                ),
              },
      ),
    );
  }
}
