// To parse this JSON data, do
//
//     final place = placeFromJson(jsonString);

import 'dart:convert';

List<Place> placeFromJson(String str) =>
    List<Place>.from(json.decode(str).map((x) => Place.fromJson(x)));

String placeToJson(List<Place> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Place {
  String? id;
  String? userId;
  String? title;
  String? image;
  String? type;
  String? placeLocationId;

  Place({
    this.id,
    this.userId,
    this.title,
    this.image,
    this.type,
    this.placeLocationId,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        image: json["image"],
        type: json["type"],
        placeLocationId: json["place_location_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "image": image,
        "type": type,
        "place_location_id": placeLocationId,
      };
}
