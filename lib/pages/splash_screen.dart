import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spinningwheel/controllers/splash_contoller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashContoller>(
      init: SplashContoller(),
      builder:
          (SplashContoller _) => Scaffold(
            body: Image.asset(
              'assets/images/splash.jpeg',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
    );
  }
}
