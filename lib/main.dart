import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mobile_football/resources/local_assets.dart';
import 'package:mobile_football/screens/grid_screens/countries_grid_screen.dart';

void main() {
  runApp(const MobileFootballApp());
}

class Id {
  Id({required this.value});

  final int value;
}

class MobileFootballApp extends StatelessWidget {
  const MobileFootballApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.black,
        ),
        textTheme: GoogleFonts.bebasNeueTextTheme(),
      ),
      home: AnimatedSplashScreen(
        splash: LocalAssets.splashLottie,
        backgroundColor: Colors.white,
        splashIconSize: 400,
        duration: 1,
        pageTransitionType: PageTransitionType.fade,
        nextScreen: CountriesGridScreen(),
      ),
    );
  }
}