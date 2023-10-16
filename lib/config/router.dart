import 'package:alquran/constant/route_builder.dart';
import 'package:alquran/constant/route_path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    if (kDebugMode) {
      print('===> ${settings.name}');
    }

    switch (settings.name) {
      case RoutePath.splashScreen:
        return RouteBuilder.splashScreen();
      case RoutePath.homeScreen:
        return RouteBuilder.homeScreen();
      case RoutePath.quranScreen:
        return RouteBuilder.quranScreen();
      case RoutePath.registerScreen:
        return RouteBuilder.registerScreen();
      default:
        onErrorRoute();
    }
    return null;
  }

  static onErrorRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text('Error, Not found Route'),
        ),
      ),
    );
  }
}
