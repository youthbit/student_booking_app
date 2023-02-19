import 'dart:math';

import 'package:flutter/material.dart';

abstract class Line {}

class SolidLine extends Line {}

class ZigzagLine extends Line {
  final double depth;
  final double angle;

  ZigzagLine({required this.depth, required this.angle});
}

class LinePainter extends CustomPainter {
  final Line line;
  final Paint paintDef;

  const LinePainter({required this.line, required this.paintDef});

  @override
  void paint(Canvas canvas, Size size) {
    if (paintDef.strokeWidth < 0.0) return;

    final width = size.width; // always axis is horizontal here

    switch (line.runtimeType) {
      case SolidLine:
        {
          _drawSolidLine(canvas, width, paintDef);
          break;
        }
      case ZigzagLine:
        {
          _drawZigZagLine(
            canvas,
            width,
            paintDef,
            (line as ZigzagLine).depth,
            (line as ZigzagLine).angle,
          );
          break;
        }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void _drawSolidLine(Canvas canvas, double width, Paint paintDef) {
    final strokeVerticalOverflow = paintDef.strokeWidth / 2;
    final strokeHorizontalOverflow =
        paintDef.strokeCap == StrokeCap.butt ? 0.0 : strokeVerticalOverflow;

    canvas.drawLine(
      Offset(strokeHorizontalOverflow, strokeVerticalOverflow),
      Offset(width - strokeHorizontalOverflow, strokeVerticalOverflow),
      paintDef,
    );
  }

  void _drawZigZagLine(
    Canvas canvas,
    double width,
    Paint paintDef,
    double depth,
    double angle,
  ) {
    // Lets draw a horizontal zigzag line

    if (angle <= 0 || angle >= 180) {
      return _drawSolidLine(canvas, width, paintDef);
    }

    final zgWidth = angle == 90.0 ? depth : (depth * tan(angle / 360 * pi));
    final zigZagAperture = zgWidth * 2;
    final zigZagCount = (width / zigZagAperture).floor();

    // zigzag floor point = zigzag height
    // zigzag ceiling point = 0.0

    final zigzagPath = Path();
    final points = <Offset>[];

    if (zigZagCount == 0) return _drawSolidLine(canvas, width, paintDef);

    // divide leap length into two equal parts
    // as starting and ending space
    var position = (width % zigZagAperture) / 2;

    points
      ..add(Offset(position, depth / 2))
      ..add(Offset(position += zgWidth / 2, 0.0))
      ..add(Offset(position += zgWidth, depth));

    for (var i = 2; i <= zigZagCount; i++) {
      points
        ..add(Offset(position, depth))
        ..add(Offset(position += zgWidth, 0.0))
        ..add(Offset(position += zgWidth, depth));
    }

    points
      ..add(Offset(position, depth))
      ..add(Offset(position += zgWidth / 2, depth / 2));

    zigzagPath.addPolygon(points, false);
    canvas.drawPath(zigzagPath, paintDef);
  }
}
