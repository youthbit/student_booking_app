import 'package:flutter/material.dart';
import 'line_painter.dart';

class AdvancedLine extends StatelessWidget {
  final Axis direction;
  final Line line;
  final Paint paintDef;

  const AdvancedLine({
    required this.direction,
    required this.line,
    required this.paintDef,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // line painter, always rendering horizontal line
    // if requested axis is vertical
    // send horizontal line with 90 degree rotated

    final paint = paintDef;
    var spaceDepth = paint.strokeWidth;

    if (line is ZigzagLine) spaceDepth = (line as ZigzagLine).depth;

    final lineWrapper = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SizedBox(
            height: spaceDepth,
            child: CustomPaint(
              painter: LinePainter(line: line, paintDef: paint),
            ),
          ),
        ),
      ],
    );

    if (direction == Axis.horizontal) {
      return lineWrapper;
    } else {
      return RotatedBox(
        quarterTurns: 1,
        child: lineWrapper,
      );
    }
  }
}
