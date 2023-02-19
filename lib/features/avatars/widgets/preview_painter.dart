import 'dart:math';

import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PreviewPainter extends CustomPainter {
  final PictureInfo picture;
  final Color backgroundColor;
  final double padding;
  final double scale;

  PreviewPainter(this.picture, this.backgroundColor, this.padding, this.scale);

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()..color = backgroundColor;
    final backgroundRect =
        RRect.fromRectAndRadius(size.toRect(), const Radius.circular(15.0));

    final fitScale = min(
          (size.width - padding * 2) / picture.size.width,
          (size.height - padding * 2) / picture.size.height,
        ) *
        scale;

    canvas
      ..clipRRect(backgroundRect)
      ..drawRRect(
        backgroundRect,
        backgroundPaint,
      )
      ..translate(
        (size.width - picture.size.width * fitScale) / 2.0,
        (size.height - picture.size.height * fitScale) / 2.0,
      )
      ..scale(fitScale)
      ..drawPicture(picture.picture!);
  }

  @override
  bool shouldRepaint(PreviewPainter oldDelegate) =>
      picture != oldDelegate.picture;
}
