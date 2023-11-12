import 'package:alquran/constant/route_path.dart';
import 'package:alquran/core/authentication/screens/test_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

void checkLogin(context) async {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user != null) {
      Future.delayed(const Duration(seconds: 1), () {
        if (context != null && context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
              context, RoutePath.homeScreen, (route) => false);
        }
      });
    } else {
      Future.delayed(
        const Duration(seconds: 1),
        () {
          if (context != null && context.mounted) {
            Navigator.pushNamedAndRemoveUntil(
                context, RoutePath.registerScreen, (route) => false);
          }
        },
      );
    }
  });
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkLogin(context);
    // Future.delayed(const Duration(seconds: 2), () {
    //   Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(
    //       builder: (_) => TestFormPage(),
    //     ),
    //     (route) => false,
    //   );
    // });
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
