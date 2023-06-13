import 'dart:convert';

import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:place_finder/utils/mapbox_direction.dart';

Future<Map> getDirectionsAPIResponse(
    LatLng sourceLatLng, LatLng destinationLatLng) async {
  final response = await getRouteUsingMapbox(sourceLatLng, destinationLatLng);
  // print(response[0]);
  Map<String, dynamic> jsonData = jsonDecode(response);
  print(jsonData);
  Map geometry = jsonData['routes'][0]['geometry'];
  num duration = jsonData['routes'][0]['duration'];
  num distance = jsonData['routes'][0]['distance'];

  Map modifiedResponse = {
    "geometry": geometry,
    "duration": duration,
    "distance": distance,
  };
  return modifiedResponse;
}
