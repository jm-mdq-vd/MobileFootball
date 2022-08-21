import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class _AssetNames {
  static const String countryPlaceholder = 'assets/images/country-placeholder.png';
  static const String soccerPlayer = 'assets/loaders/soccer-player.json';
}

class LocalAssets {
  static Image get countryPlaceholder => Image.asset(_AssetNames.countryPlaceholder);
  static LottieBuilder get splashLottie => Lottie.asset(_AssetNames.soccerPlayer);
}