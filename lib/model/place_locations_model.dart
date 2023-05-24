// To parse this JSON data, do
//
//     final placeLocation = placeLocationFromJson(jsonString);

import 'dart:convert';

PlaceLocation placeLocationFromJson(String str) =>
    PlaceLocation.fromJson(json.decode(str));

List<PlaceLocation> placeLocationsFromJson(String str) =>
    List<PlaceLocation>.from(
        json.decode(str).map((x) => PlaceLocation.fromJson(x)));

String placeLocationToJson(PlaceLocation data) => json.encode(data.toJson());

class PlaceLocation {
  String? id;
  String? address;
  num? latitude;
  num? longtitude;

  PlaceLocation({
    this.id,
    this.address = '',
    this.latitude = 37.422,
    this.longtitude = -122.084,
  });

  factory PlaceLocation.fromJson(Map<String, dynamic> json) => PlaceLocation(
        id: json["id"],
        address: json["address"],
        latitude: json["latitude"],
        longtitude: json["longtitude"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "latitude": latitude,
        "longtitude": longtitude,
      };
}
