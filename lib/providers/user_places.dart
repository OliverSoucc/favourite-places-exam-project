import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:native_device_features/services/app_services.dart';
import '../model/place_locations_model.dart';
import '../model/place_model.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  void addPlace(String title, File image, PlaceLocation placeLocation) async {
    // final appDir = await syspaths.getApplicationDocumentsDirectory();
    // final fileName = path.basename(image.path);
    // final copiedImage = await image.copy('${appDir.path}/$fileName');

    // final newPlace =
    //     Place(title: title, image: copiedImage, location: placeLocation);
    // state = [newPlace, ...state];
  }

  Future<void> loadPlaces() async {
    final userPlaces = await AppServices.loadPlaces();
    state = userPlaces;
  }

  Future<PlaceLocation> getPlaceLocation(String id) async {
    final placeLocation = await AppServices.loadPlaceLocation(id);
    return placeLocation;
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
        (ref) => UserPlacesNotifier());
