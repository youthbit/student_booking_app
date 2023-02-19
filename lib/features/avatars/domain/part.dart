import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:xml/xml.dart';
import 'part_type.dart';

class Part extends Equatable {
  final String picture;
  final String path;

  @override
  List<Object> get props => [picture, path];

  XmlDocument? _parsed;

  Part({
    required this.picture,
    required this.path,
  });

  static Future<Part> load(String path) async => Part(
        path: path,
        picture: await rootBundle.loadString(path),
      );

  String applyColors(Map<PartType, int> colors) {
    _parsed ??= XmlDocument.parse(picture);

    final elements = [
      ..._parsed!.findAllElements('path'),
      ..._parsed!.findAllElements('rect'),
      ..._parsed!.findAllElements('line'),
      ..._parsed!.findAllElements('circle'),
      ..._parsed!.findAllElements('polygon'),
    ];

    for (final element in elements) {
      final id = element.getAttribute('id') ?? '';
      final className = element.getAttribute('class') ?? '';

      if (id.endsWith('Skin')) {
        element.setAttribute(
          'fill',
          '#${colors.face.toRadixString(16)}',
        );
      } else if (path.contains('accessories') && id.endsWith('Background')) {
        element.setAttribute(
          'fill',
          '#${colors.accessories.toRadixString(16)}',
        );
      } else if (path.contains('facial-hair') && id.endsWith('Background')) {
        element.setAttribute(
          'fill',
          '#${colors.facialHair.toRadixString(16)}',
        );
      } else if (className.endsWith('Stroke Dark')) {
        final hsl = HSLColor.fromColor(Color(colors.background));
        final hslDark =
            hsl.withLightness((hsl.lightness - 0.4).clamp(0.0, 1.0));

        element.setAttribute(
          'stroke',
          '#${hslDark.toColor().value.toRadixString(16)}',
        );
      } else if (className.endsWith('Stroke')) {
        final hsl = HSLColor.fromColor(Color(colors.background));
        final hslDark =
            hsl.withLightness((hsl.lightness - 0.2).clamp(0.0, 1.0));

        element.setAttribute(
          'stroke',
          '#${hslDark.toColor().value.toRadixString(16)}',
        );
      } else if (className.endsWith('Fill Dark')) {
        final hsl = HSLColor.fromColor(Color(colors.background));
        final hslDark =
            hsl.withLightness((hsl.lightness - 0.4).clamp(0.0, 1.0));

        element.setAttribute(
          'fill',
          '#${hslDark.toColor().value.toRadixString(16)}',
        );
      } else if (className.endsWith('Fill')) {
        final hsl = HSLColor.fromColor(Color(colors.background));
        final hslDark =
            hsl.withLightness((hsl.lightness - 0.2).clamp(0.0, 1.0));

        element.setAttribute(
          'fill',
          '#${hslDark.toColor().value.toRadixString(16)}',
        );
      } else if (id.endsWith('Background')) {
        element.setAttribute(
          'fill',
          '#${colors.background.toRadixString(16)}',
        );
      } else if (id.endsWith('Hair')) {
        element.setAttribute(
          'fill',
          '#${colors.head.toRadixString(16)}',
        );
      } else if (id.endsWith('Top') || id.endsWith('Jacket')) {
        element.setAttribute(
          'fill',
          '#${colors.body.toRadixString(16)}',
        );
      } else if (id.endsWith('Top_2')) {
        final hsl = HSLColor.fromColor(Color(colors.body));
        final hslDark =
            hsl.withLightness((hsl.lightness - 0.2).clamp(0.0, 1.0));

        element.setAttribute(
          'fill',
          '#${hslDark.toColor().value.toRadixString(16)}',
        );
      }
    }

    return _parsed!.toXmlString();
  }
}
