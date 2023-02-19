import 'dart:math';
import 'package:flutter/material.dart';
import '../domain/avatar.dart';

class AvatarPainter extends CustomPainter {
  final RenderedAvatar avatar;

  AvatarPainter(this.avatar);

  @override
  void paint(Canvas canvas, Size size) {
    var svgWidth = 368.68;
    var svgHeight = 537.29;
    final ratio = min(size.width / svgWidth, size.height / svgHeight);
    svgWidth *= ratio;
    svgHeight *= ratio;

    final backgroundScale = size.width / avatar.background.size.width;
    final bodyScale = (ratio * 368.68) / avatar.body.size.width;
    final headScale = (ratio * 213.18) / avatar.head.size.width;
    final faceScale = (ratio * 130.25) / avatar.face.size.width;
    final facialHairScale = (ratio * 126.2) / avatar.facialHair.size.width;
    final accessoriesScale = (ratio * 176.68) / avatar.accessories.size.width;

    const zoom = 1.1;

    canvas
      ..clipRRect(
        RRect.fromLTRBR(
          0,
          0,
          size.width,
          size.height,
          const Radius.circular(40.0),
        ),
      )
      ..drawRRect(
        RRect.fromLTRBR(
          0,
          0,
          size.width,
          size.height,
          const Radius.circular(40.0),
        ),
        Paint()
          ..color = avatar.backgroundColor
          ..strokeWidth = 5.0
          ..style = PaintingStyle.fill,
      )
      // center
      ..scale(backgroundScale)
      ..drawPicture(avatar.background.picture!)
      ..scale(1 / backgroundScale)
      ..drawRRect(
        RRect.fromLTRBR(
          0,
          0,
          size.width,
          size.height,
          const Radius.circular(40.0),
        ),
        Paint()
          ..color = Colors.black
          ..strokeWidth = 5.0
          ..style = PaintingStyle.stroke,
      )
      // translate
      ..scale(zoom)
      ..translate(
        (size.width / zoom - svgWidth) / 2.0,
        size.height * 0.2 / zoom,
      )
      // body
      ..translate(0, size.height * 38.51 / 100.0)
      ..scale(bodyScale)
      ..drawPicture(avatar.body.picture!)
      ..scale(1 / bodyScale)
      ..translate(0, -size.height * 38.51 / 100.0)
      // head
      ..translate(svgWidth * 27.51 / 100.0, 0.0)
      ..scale(headScale)
      ..drawPicture(avatar.head.picture!)
      ..scale(1 / headScale)
      ..translate(-svgWidth * 27.51 / 100.0, 0.0)
      // // face
      ..translate(svgWidth * 46.94 / 100.0, svgHeight * 15.6 / 100.0)
      ..scale(faceScale)
      ..drawPicture(avatar.face.picture!)
      ..scale(1 / faceScale)
      ..translate(-svgWidth * 46.94 / 100.0, -svgHeight * 15.6 / 100.0)
      // // facial hair
      ..translate(svgWidth * 42.54 / 100.0, svgHeight * 28.36 / 100.0)
      ..scale(facialHairScale)
      ..drawPicture(avatar.facialHair.picture!)
      ..scale(1 / facialHairScale)
      ..translate(-svgWidth * 42.54 / 100.0, -svgHeight * 28.36 / 100.0)
      // // accessories
      ..translate(svgWidth * 33.25 / 100.0, svgHeight * 20.22 / 100.0)
      ..scale(accessoriesScale)
      ..drawPicture(avatar.accessories.picture!);
  }

  @override
  bool shouldRepaint(AvatarPainter oldDelegate) {
    return true;
  }
}
