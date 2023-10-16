import 'package:alquran/constant/route_path.dart';
import 'package:alquran/core/home/home_screen.dart';
import 'package:alquran/features/quran/screens/quran_screen.dart';
import 'package:alquran/splash_screen.dart';
import 'package:flutter/material.dart';

import '../core/authentication/screens/register_screen.dart';

class RouteBuilder {
  static splashScreen() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: RoutePath.splashScreen),
      builder: (context) => const SplashScreen(),
    );
  }

  static homeScreen() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: RoutePath.homeScreen),
      builder: (context) => const HomeScreen(),
    );
  }

  static quranScreen() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: RoutePath.quranScreen),
      builder: (context) => const QuranScreen(),
    );
  }

  static registerScreen() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: RoutePath.registerScreen),
      builder: (context) => const RegisterScreen(),
    );
  }
}
