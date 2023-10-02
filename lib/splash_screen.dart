import 'package:alquran/constant/route_path.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

void ya(context) {
  Future.delayed(const Duration(seconds: 1), () {
    Navigator.pushNamed(context, RoutePath.homeScreen);
  });
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    ya(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LottieBuilder.asset('assets/animations/splash.json'),
      ),
    );
  }
}
