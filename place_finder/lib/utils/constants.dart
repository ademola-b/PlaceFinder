import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:place_finder/main.dart';
import 'package:place_finder/utils/defaultButton.dart';
import 'package:place_finder/utils/defaultText.dart';

class Constants {
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

  static LatLng getSourceDestLatLng(
    String type,
  ) {
    sharedPreferences.reload();
    double sourceLat = sharedPreferences.getDouble('latitude') as double;
    double sourceLng = sharedPreferences.getDouble('longitude') as double;

    double destinationLat = sharedPreferences.getDouble('destinationLat') as double;
    double destinationLng = sharedPreferences.getDouble('destinationLng') as double;

    // const LatLng sourceLocation = LatLng(10.5200603, 7.4166742);
    LatLng sourceLocation = LatLng(sourceLat, sourceLng);
    LatLng destinationLocation = LatLng(destinationLat, destinationLng);

    if (type == 'source') {
      return sourceLocation;
    } else {
      return destinationLocation;
    }
  }

  static Future<dynamic> dialogBox(
      context, String? text, Color? color, Color? textColor, IconData? icon,
      {String? buttonText, void Function()? buttonAction}) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: color,
              content: SizedBox(
                height: 180.0,
                child: Column(
                  children: [
                    Icon(
                      icon,
                      size: 70.0,
                      color: Constants.backgroundColor,
                    ),
                    const SizedBox(height: 20.0),
                    DefaultText(
                      size: 20.0,
                      text: text!,
                      color: textColor,
                      align: TextAlign.center,
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: buttonAction,
                    child: DefaultText(
                      text: "$buttonText",
                      color: Colors.blue,
                      size: 18.0,
                    )),
              ],
            ));
  }
}
