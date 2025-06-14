import 'dart:math';

import 'package:flutter/material.dart';

class CustomWheel extends CustomPainter {
  final List<int> numbers;

  CustomWheel(this.numbers);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final segmentAngle = 2 * pi / numbers.length;

    final paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < numbers.length; i++) {
      paint.color = i % 2 == 0 ? Colors.red.shade800 : Colors.blue.shade700;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        i * segmentAngle,
        segmentAngle,
        true,
        paint,
      );
      final textAngle = i * segmentAngle + segmentAngle / 2;
      final textOffset = Offset(
        center.dx + (radius * 0.7) * cos(textAngle),
        center.dy + (radius * 0.7) * sin(textAngle),
      );
      final textPainter = TextPainter(
        text: TextSpan(
          text: '${numbers[i]}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
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
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        textOffset - Offset(textPainter.width / 2, textPainter.height / 2),
      );
    }

    final borderPaint =
        Paint()
          ..color = const Color(0xFFFFD700)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10;
    canvas.drawCircle(center, radius, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
