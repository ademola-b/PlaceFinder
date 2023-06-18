import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:place_finder/screens/admin/add_location.dart';
import 'package:place_finder/screens/admin/dashboard.dart';
import 'package:place_finder/screens/admin/update_location.dart';
import 'package:place_finder/screens/map.dart';
import 'package:place_finder/screens/homepage.dart';
import 'package:place_finder/screens/login.dart';
import 'package:place_finder/screens/register.dart';
import 'package:place_finder/screens/splash_screen.dart';
import 'package:place_finder/screens/turn_by_turn.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await dotenv.load(fileName: "assets/config/.env");
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
      return _buildRoute(settings, MapPage(settings.arguments));

    case "/turnByturn":
      return _buildRoute(settings, const TurnByTurn());

    
    case "/adHomePage":
      return _buildRoute(settings, const AdHomePage());

    case "/addLocation":
      return _buildRoute(settings, const AddLocation());

    case "/updateLocation":
      return _buildRoute(settings, UpdateLocation(settings.arguments));

    default:
      return _buildRoute(settings, const SplashScreen());
  }
}

MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
  return MaterialPageRoute(settings: settings, builder: ((context) => builder));
}
