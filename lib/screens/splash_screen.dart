import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:place_finder/main.dart';
import 'package:place_finder/screens/homepage.dart';
import 'package:place_finder/screens/login.dart';
import 'package:place_finder/utils/defaultText.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  void initializedLocationandSave() async {
    Location _location = Location();
    bool? _serviceEnabled;
    PermissionStatus? _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
    }

    // Get the current user location
    LocationData _locationData = await _location.getLocation();
    LatLng currentLocation =
        LatLng(_locationData.latitude!, _locationData.longitude!);

    // Store the user locaiton in sharedPreferences
    sharedPreferences.setDouble('latitude', _locationData.latitude!);
    sharedPreferences.setDouble('longitude', _locationData.longitude!);

    print("Location gotten");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializedLocationandSave();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png", width: 250, height: 250),
            // SvgPicture.asset("assets/images/logo.svg", width: 50.0, height: 50.0),
            const SizedBox(height: 10.0),
            const DefaultText(
              text: 'PLACE FINDER',
              size: 40.0,
              color: Colors.white,
              weight: FontWeight.bold,
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 3, 4, 36),
      splashIconSize: 350.0,
      nextScreen: const LoginPage(),
    );
  }
}
