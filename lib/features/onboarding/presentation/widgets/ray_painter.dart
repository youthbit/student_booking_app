import 'dart:math';

import 'package:flutter/material.dart';

class ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..shader = RadialGradient(
        colors: [
          Colors.white.withOpacity(0.5),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(0, size.height / 3),
          radius: size.height / 2,
        ),
      );

    final path = Path();
    for (var i = pi / 2.0; i >= -pi / 2.0; i -= pi / 20.0) {
      path
        ..moveTo(0, size.height / 3)
        ..lineTo(
          size.height / 2 * cos(i),
          size.height / 2 * sin(i) + size.height / 3,
        );
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
