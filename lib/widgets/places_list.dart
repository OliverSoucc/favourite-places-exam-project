import 'dart:io';

import 'package:flutter/material.dart';
import 'package:native_device_features/model/place_locations_model.dart';

import 'package:native_device_features/screens/place_detail.dart';

import '../model/place_model.dart';
import '../services/app_services.dart';

class PlacesList extends StatefulWidget {
  const PlacesList({super.key, required this.places, this.newPlace});

  final List<Place> places;
  final Place? newPlace;

  @override
  State<PlacesList> createState() => _PlacesListState();
}

class _PlacesListState extends State<PlacesList> {
  late Future<List<PlaceLocation>> _placeLocationsFuture;

  @override
  void initState() {
    super.initState();
    _placeLocationsFuture = AppServices.loadPlaceLocations();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.places.isEmpty) {
      return Center(
        child: Text(
          'No place added yet',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      );
    }
    return ListView.builder(
      itemCount: widget.places.length,
      itemBuilder: (ctx, index) => ListTile(
        leading: CircleAvatar(
          radius: 26,
          backgroundImage:
              FileImage(File(widget.places[index].image ?? 'none')),
        ),
        title: Text(
          widget.places[index].title ?? 'Without a name',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        subtitle: FutureBuilder(
          future: _placeLocationsFuture,
          builder: ((context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      snapshot.requireData
                              .firstWhere((element) =>
                                  element.id ==
                                  widget.places[index].placeLocationId)
                              .address ??
                          'No address',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    )),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => FutureBuilder(
                future: _placeLocationsFuture,
                builder: ((context, snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : PlaceDetailScreen(
                            placeLocation: snapshot.requireData.firstWhere(
                                (element) =>
                                    element.id ==
                                    widget.places[index].placeLocationId),
                            place: widget.places[index])),
              ),
            ),
          );
        },
      ),
    );
  }
}
