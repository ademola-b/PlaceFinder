import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:place_finder/screens/homepage.dart';
import 'package:place_finder/screens/login.dart';
import 'package:place_finder/utils/defaultText.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
