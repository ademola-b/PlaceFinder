import 'package:flutter/material.dart';
import 'package:place_finder/screens/admin/add_location.dart';
import 'package:place_finder/screens/admin/dashboard.dart';
import 'package:place_finder/screens/admin/map.dart';
import 'package:place_finder/screens/homepage.dart';
import 'package:place_finder/screens/login.dart';
import 'package:place_finder/screens/register.dart';
import 'package:place_finder/screens/splash_screen.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    onGenerateRoute: _getRoutes,
  ));
}

Route<dynamic> _getRoutes(RouteSettings settings) {
  switch (settings.name) {
    case "/":
      return _buildRoute(settings, const SplashScreen());

    case "/login":
      return _buildRoute(settings, const LoginPage());

    case "/register":
      return _buildRoute(settings, const Register());

    case "/homePage":
      return _buildRoute(settings, const HomePage());

    case "/map":
      return _buildRoute(settings, const MapPage());

    case "/adHomePage":
      return _buildRoute(settings, const AdHomePage());

    case "/addLocation":
      return _buildRoute(settings, const AddLocation());

    default:
      return _buildRoute(settings, const SplashScreen());
  }
}

MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
  return MaterialPageRoute(settings: settings, builder: ((context) => builder));
}
