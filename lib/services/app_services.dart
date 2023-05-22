import 'dart:convert';

import 'package:http/http.dart';

import '../model/place_locations_model.dart';
import '../model/place_model.dart';

class AppServices {
  static Future<List<Place>> loadPlaces() async {
    String placesEndpoint =
        'https://final-exam-backend-production.up.railway.app/place';
    Response response = await get(Uri.parse(placesEndpoint));

    if (response.statusCode == 200) {
      final List<Place> places = placeFromJson(response.body);
      return places;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  static Future<PlaceLocation> loadPlaceLocation(String id) async {
    String placeLocationEndpoint =
        'https://final-exam-backend-production.up.railway.app/place-location/$id';
    Response response = await get(Uri.parse(placeLocationEndpoint));

    if (response.statusCode == 200) {
      final PlaceLocation placeLocation = placeLocationFromJson(response.body);
      return placeLocation;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  // static Future<Place> createPlace() async {

  // }
}
