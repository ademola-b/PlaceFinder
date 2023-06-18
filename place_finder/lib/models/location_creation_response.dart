// To parse this JSON data, do
//
//     final locationCreationResponse = locationCreationResponseFromJson(jsonString);

import 'dart:convert';

LocationCreationResponse locationCreationResponseFromJson(String str) =>
    LocationCreationResponse.fromJson(json.decode(str));

String locationCreationResponseToJson(LocationCreationResponse data) =>
    json.encode(data.toJson());

class LocationCreationResponse {
  String? locationId;
  String name;
  String latitude;
  String longitude;

  LocationCreationResponse({
    this.locationId,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory LocationCreationResponse.fromJson(Map<String, dynamic> json) =>
      LocationCreationResponse(
        locationId: json["location_id"],
        name: json["name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "location_id": locationId,
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
      };
}
