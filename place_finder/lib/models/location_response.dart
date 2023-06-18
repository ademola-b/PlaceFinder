// To parse this JSON data, do
//
//     final locationResponse = locationResponseFromJson(jsonString);

import 'dart:convert';

List<LocationResponse> locationResponseFromJson(String str) => List<LocationResponse>.from(json.decode(str).map((x) => LocationResponse.fromJson(x)));

String locationResponseToJson(List<LocationResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocationResponse {
    String locationId;
    String name;
    String latitude;
    String longitude;

    LocationResponse({
        required this.locationId,
        required this.name,
        required this.latitude,
        required this.longitude,
    });

    factory LocationResponse.fromJson(Map<String, dynamic> json) => LocationResponse(
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
