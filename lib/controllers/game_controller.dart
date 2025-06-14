import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:spinningwheel/models/history_model.dart';
import 'package:spinningwheel/services/storage_service.dart';

class GameController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  int? selectedNumber;
  List<int> recentNumbers = [];
  final List<int> wheelNumbers = [9, 1, 7, 10, 4, 3, 8, 5, 12, 2, 7, 11];
  bool isSpinning = false;

  @override
  void onInit() {
    super.onInit();
    controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    _loadRecentNumbers();
    startContinuousSpin();
  }

  Future<void> _loadRecentNumbers() async {
    final historyModels = Get.find<StorageService>().getModels();
    if (historyModels.isNotEmpty) {
      recentNumbers = historyModels.map((model) => model.number).toList();
      update();
    }
  }

  Future<void> _saveRecentNumbers(int newNumber) async {
    final model = HistoryModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      number: newNumber,
    );
    Get.find<StorageService>().saveModel(model);
  }

  void startContinuousSpin() {
    isSpinning = true;
    selectedNumber = null;
    update();
    controller.repeat();
  }

  Future<void> clearHistory(BuildContext context) async {
    await showCupertinoDialog<bool>(
      context: context,
      builder:
          (context) => CupertinoAlertDialog(
            title: Text('Delete History'),
            content: Text('Are you sure you want to delete History?'),
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                child: Text('Cancel'),
                onPressed: () => Navigator.pop(context, false),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () async {
                  Navigator.pop(context, true);
                  await Get.find<StorageService>().clearHistory();
                  recentNumbers = [];
                  selectedNumber = null;
                  isSpinning = false;
                  controller.stop();
                  update();
                },
                child: Text('Delete'),
              ),
            ],
          ),
    );
  }

  void handleTapAt(Offset tapPosition, Size wheelSize) {
    if (selectedNumber != null || isSpinning == false) {
      return;
    }
    final center = Offset(wheelSize.width / 2, wheelSize.height / 2);
    final dx = tapPosition.dx - center.dx;
    final dy = tapPosition.dy - center.dy;
    final distance = sqrt(dx * dx + dy * dy);

    final radius = wheelSize.width / 2;
    if (distance > radius) {
      return;
    }

    double angle = atan2(dy, dx);
    angle = (angle < 0) ? angle + 2 * pi : angle;

    final rotatedAngle = (angle - (animation.value * 2 * pi)) % (2 * pi);

    final segmentAngle = 2 * pi / wheelNumbers.length;
    final selectedIndex = (rotatedAngle / segmentAngle).floor();

    selectedNumber = wheelNumbers[selectedIndex];
    controller.stop();
    isSpinning = false;
    _updateRecentNumbers(selectedNumber!);
    update();
  }

  void _updateRecentNumbers(int newNumber) {
    recentNumbers.insert(0, newNumber);
    if (recentNumbers.length > 5) {
      recentNumbers = recentNumbers.sublist(0, 5);
    }
    _saveRecentNumbers(newNumber);
    update();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
