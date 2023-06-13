import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:place_finder/main.dart';

class Constants {
  static String googleAPiKey = "AIzaSyCiL1e2XNfMUWRwGYuhu8vkEqFb-9vrzNo";
  static final Color primaryColor = Color(0xFF2296f3);
  static final Color backgroundColor = Color(0xFFc5e5FF);
  static final Color altColor = Color.fromARGB(255, 199, 35, 90);

  static String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return "This Field is required";
    }
    return null;
  }

  static LatLng getCurrentLocationFromSharedPref() {
    return LatLng(sharedPreferences.getDouble('latitude')!,
        sharedPreferences.getDouble('longitude')!);
  }

  static LatLng getSourceDestLatLng(String type) {
    const LatLng sourceLocation = LatLng(10.5200603, 7.4166742);
    const LatLng destinationLocation = LatLng(10.5400603, 7.4166742);

    if (type == 'source') {
      return sourceLocation;
    } else {
      return destinationLocation;
    }
  }
}


