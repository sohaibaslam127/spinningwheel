import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spinningwheel/pages/game_screen.dart';
import 'package:spinningwheel/services/storage_service.dart';

class SplashContoller extends GetxController {
  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    Get.put(StorageService()).init();
    Future.delayed(const Duration(seconds: 1)).then((val) {
      Get.offAll(
        GameScreen(),
        transition: Transition.fadeIn,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }
}
