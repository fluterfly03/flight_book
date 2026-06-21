import 'dart:math';

import 'package:flutter/material.dart';

class HalfDottedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xffD6DEF8)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const dashWidth = 3.0;
    const dashSpace = 3.0;

    final radius = size.width / 2;
    final center = Offset(radius, radius);

    // Draw top half
    for (double angle = pi; angle <= 2 * pi;) {
      final x1 = center.dx + radius * cos(angle);
      final y1 = center.dy + radius * sin(angle);

      final nextAngle =
          angle + dashWidth / radius;

      final x2 =
          center.dx + radius * cos(nextAngle);
      final y2 =
          center.dy + radius * sin(nextAngle);

      canvas.drawLine(
        Offset(x1, y1),
        Offset(x2, y2),
        paint,
      );

      angle +=
          (dashWidth + dashSpace) / radius;
    }
  }

  @override
  bool shouldRepaint(
      CustomPainter oldDelegate) =>
      false;
}