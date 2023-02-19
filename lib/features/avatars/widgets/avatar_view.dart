import 'package:flutter/material.dart';
import '../domain/avatar.dart';
import 'avatar_painter.dart';

class AvatarView extends StatelessWidget {
  final RenderedAvatar avatar;

  final double width;
  final double height;

  const AvatarView({
    required this.avatar,
    required this.width,
    required this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: AvatarPainter(avatar),
        child: Container(),
      ),
    );
  }
}

class AvatarLoader extends StatelessWidget {
  final double width;
  final double height;
  final Color backgroundColor;

  const AvatarLoader({
    required this.width,
    required this.height,
    required this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(40.0)),
      ),
      child: const Center(
        child: SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
