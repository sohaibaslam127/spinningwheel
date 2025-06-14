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
            backgroundColor: Colors.green.shade800,
            body: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/background.jpg',
                    fit: BoxFit.cover,
                    color: Colors.black.withOpacity(0.5),
                    colorBlendMode: BlendMode.darken,
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Fortune\nWheel',
                          style: TextStyle(
                            color: Color(0xffffbc1d),
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 2,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
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
                                          painter: CustomWheel(
                                            con.wheelNumbers,
                                          ),
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
                      SizedBox(
                        height: 55,
                        child:
                            con.isSpinning
                                ? Text(
                                  'Choose A Number',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                )
                                : ElevatedButton(
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
                      ),
                      SizedBox(height: 40),
                      Text(
                        con.selectedNumber == null
                            ? ""
                            : 'Selected Number: ${con.selectedNumber}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      if (con.recentNumbers.isNotEmpty) ...[
                        Text(
                          'Recent Numbers',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
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
                                      color:
                                          number == 1 ||
                                                  number == 11 ||
                                                  number == 2 ||
                                                  number == 5 ||
                                                  number == 3 ||
                                                  number == 10
                                              ? Colors.blue.shade700
                                              : Colors.red.shade700,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      '$number',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            color: Colors.white.withOpacity(
                                              0.3,
                                            ),
                                            blurRadius: 2,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
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
                            child: Text(
                              'Clear',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
