import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:place_finder/utils/defaultText.dart';
import 'package:place_finder/utils/mapbox_direction.dart';

Future<Map?> getDirectionsAPIResponse(
    LatLng sourceLatLng, LatLng destinationLatLng, context) async {
  try {
    final response = await getRouteUsingMapbox(sourceLatLng, destinationLatLng);
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
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: DefaultText(text: "Network Issue")));
  }

  return null;
}
