import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spinningwheel/controllers/game_controller.dart';
import 'dart:math';
import 'package:spinningwheel/widgets/wheel.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameController>(
      init: GameController(),
      builder:
          (GameController con) => Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Builder(
                    builder: (wheelContext) {
                      return GestureDetector(
                        onTapDown: (TapDownDetails details) {
                          final RenderBox box =
                              wheelContext.findRenderObject() as RenderBox;
                          final Offset localPos = box.globalToLocal(
                            details.globalPosition,
                          );
                          con.handleTapAt(localPos, const Size(300, 300));
                        },
                        child: SizedBox(
                          width: 300,
                          height: 300,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              AnimatedBuilder(
                                animation: con.controller,
                                builder: (context, child) {
                                  return Transform.rotate(
                                    angle: con.animation.value * 2 * pi,
                                    child: CustomPaint(
                                      size: const Size(300, 300),
                                      painter: CustomWheel(con.wheelNumbers),
                                    ),
                                  );
                                },
                              ),
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFFFD700),
                                  border: Border.all(
                                    color: const Color(0xFFFFD700),
                                    width: 3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 30),
                  if (con.isSpinning)
                    Text('Choose A Number', style: TextStyle(fontSize: 20))
                  else
                    ElevatedButton(
                      onPressed: con.startContinuousSpin,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 12,
                        ),
                        child: Text(
                          'Spin Again',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  SizedBox(height: 40),
                  if (con.selectedNumber != null)
                    Text(
                      'Selected Number: ${con.selectedNumber}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  SizedBox(height: 10),
                  if (con.recentNumbers.isNotEmpty) ...[
                    Text('Recent Numbers', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          con.recentNumbers.take(5).map((number) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Container(
                                width: 40,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '$number',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () => con.clearHistory(context),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        child: Text('Clear', style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ],
              ),
            ),
          ),
    );
  }
}
