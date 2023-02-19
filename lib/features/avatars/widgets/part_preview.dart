import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../domain/part.dart';
import '../domain/part_type.dart';
import 'preview_painter.dart';

class PartPreview extends StatelessWidget {
  final PartType partType;
  final Part part;
  final Color partColor;
  final Color backgroundColor;

  const PartPreview({
    required this.partType,
    required this.part,
    required this.partColor,
    required this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scale = part.path.contains('Moustache 8') ? 0.3 : 0.95;

    switch (partType) {
      case PartType.face:
        return BasePreview(
          part: part,
          backgroundColor: partColor,
          scale: 1.0,
        );
      case PartType.background:
        return BasePreview(
          part: part,
          backgroundColor: partColor,
          padding: 0.0,
          scale: 1.0,
        );
      default:
        return BasePreview(
          part: part,
          backgroundColor: backgroundColor,
          scale: scale,
        );
    }
  }
}

class BasePreview extends StatelessWidget {
  final Part part;
  final Color backgroundColor;
  final double padding;
  final double scale;

  const BasePreview({
    required this.part,
    required this.backgroundColor,
    this.padding = 15.0,
    this.scale = 0.95,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (part.path.contains('None')) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        ),
        child: const Icon(
          Icons.not_interested,
          size: 40.0,
        ),
      );
    }

    return FutureBuilder(
      future: svg.svgPictureStringDecoder(
        part.picture,
        true,
        null,
        part.path,
      ),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return DecoratedBox(
            key: UniqueKey(),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            ),
            child: const Padding(
              padding: EdgeInsets.all(30.0),
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
          );
        }

        return CustomPaint(
          key: ValueKey('part-${part.path}'),
          painter: PreviewPainter(
            snapshot.data!,
            backgroundColor,
            padding,
            scale,
          ),
          child: Container(),
        );
      },
    );
  }
}
