import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:native_device_features/model/user_model.dart';

import '../model/place_locations_model.dart';
import '../model/place_model.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class AppServices {
  static Future<List<Place>> loadPlaces() async {
    String placesEndpoint =
        'http://ec2-16-16-160-190.eu-north-1.compute.amazonaws.com/place';
    var response = await http.get(Uri.parse(placesEndpoint));

    if (response.statusCode == 200) {
      final List<Place> places = placesFromJson(response.body);
      return places;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  static Future<List<PlaceLocation>> loadPlaceLocations() async {
    String placesEndpoint =
        'http://ec2-16-16-160-190.eu-north-1.compute.amazonaws.com/place-location';
    var response = await http.get(Uri.parse(placesEndpoint));

    if (response.statusCode == 200) {
      final List<PlaceLocation> placeLocations =
          placeLocationsFromJson(response.body);

      return placeLocations;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  static Future<PlaceLocation> loadPlaceLocation(String id) async {
    String placeLocationEndpoint =
        'http://ec2-16-16-160-190.eu-north-1.compute.amazonaws.com/place/$id';
    var response = await http.get(Uri.parse(placeLocationEndpoint));

    if (response.statusCode == 200) {
      final PlaceLocation placeLocation = placeLocationFromJson(response.body);
      return placeLocation;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  static Future<Place> createPlace(String address, num latitude, num longtitude,
      String userId, String title, File image, String type) async {
    String placeLocationEndpoint =
        'http://ec2-16-16-160-190.eu-north-1.compute.amazonaws.com/place-location';
    String placeEndpoint =
        'http://ec2-16-16-160-190.eu-north-1.compute.amazonaws.com/place';

    var body = json.encode(
        {"address": address, "latitude": latitude, "longtitude": longtitude});

    var placeLocationResponse = await http.post(
        Uri.parse(placeLocationEndpoint),
        headers: {"Content-Type": "application/json"},
        body: body);

    if (placeLocationResponse.statusCode == 201) {
      final PlaceLocation placeLocation =
          placeLocationFromJson(placeLocationResponse.body);

      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(image.path);
      final copiedImage = await image.copy('${appDir.path}/$fileName');

      var placeResponse = await http.post(Uri.parse(placeEndpoint), body: {
        "userId": userId,
        "image": copiedImage.path,
        "title": title,
        "type": "best",
        "place_location_id": placeLocation.id
      });

      if (placeResponse.statusCode == 201) {
        return placeFromJson(placeResponse.body);
      } else {
        throw Exception('${placeResponse.reasonPhrase} from Place');
      }
    } else {
      throw Exception(
          '${placeLocationResponse.reasonPhrase} from PlaceLocation');
    }
  }

  static Future<String> createAccount(
      String userName, String password, String email) async {
    String userEndpoint =
        'http://ec2-16-16-160-190.eu-north-1.compute.amazonaws.com/user';

    var response = await http.post(Uri.parse(userEndpoint),
        body: {"username": userName, "password": password, "email": email});

    if (response.statusCode == 201) {
      final User user = userFromJson(response.body);
      return user.id.toString();
    } else {
      throw Exception('${response.reasonPhrase} from Place');
    }
  }

  static Future<String> logIn(String password, String email) async {
    String userEndpoint =
        'http://ec2-16-16-160-190.eu-north-1.compute.amazonaws.com/auth/login';

    var response = await http.post(Uri.parse(userEndpoint),
        body: {"password": password, "email": email});

    if (response.statusCode == 201) {
      final UserLogin userLogin = userLoginFromJson(response.body);
      return userLogin.userId.toString();
    } else {
      throw Exception('${response.reasonPhrase} from Place');
    }
  }
}
