import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SplashScreen(),
      defaultTransition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 0),
      debugShowCheckedModeBanner: false,
    );
  }
}
