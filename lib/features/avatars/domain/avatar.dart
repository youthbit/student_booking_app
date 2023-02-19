import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../avatars_data.dart';
import '../avatars_repository.dart';
import 'part.dart';
import 'part_type.dart';

part 'avatar.freezed.dart';

part 'avatar.g.dart';

class Avatar {
  Map<PartType, Part> parts;
  Map<PartType, int> colors;

  Avatar({required this.parts, required this.colors});

  static Future<Avatar> fromJson(Map<String, Object?> json) async {
    final preset = _Avatar.fromJson(json);

    final futures = PartType.values.map((partType) async {
      final part = preset.parts[partType];
      if (part == null) {
        throw Error(); // incomplete preset
      }

      return MapEntry(partType, await Part.load(part));
    });
    final parts = Map.fromEntries(await Future.wait(futures));

    return Avatar(parts: parts, colors: {...preset.colors});
  }

  static Future<Avatar> random(AvatarsRepository repository) async {
    final parts = await Future.wait(
      PartType.values.map((partType) async {
        final paths = await repository.listPartsFor(partType);
        final path = (paths.toList()..shuffle()).first;

        return MapEntry(partType, await Part.load(path));
      }),
    );
    final colors = Map.fromEntries(
      PartType.values.map(
        (type) => MapEntry(type, (listColors(type).toList()..shuffle()).first),
      ),
    );

    return Avatar(parts: Map.fromEntries(parts), colors: colors);
  }

  Avatar copyWith({Map<PartType, Part>? parts, Map<PartType, int>? colors}) {
    return Avatar(parts: parts ?? this.parts, colors: colors ?? this.colors);
  }

  Map<String, Object?> toJson() {
    return _Avatar(
      parts: parts.map((key, value) => MapEntry(key, value.path)),
      colors: colors,
    ).toJson();
  }

  Future<RenderedAvatar> render() async {
    final futures = PartType.values.map((partType) async {
      final part = parts[partType];
      if (part == null) {
        throw Error(); // incomplete preset
      }

      final colored = part.applyColors(colors);
      final pictureInfo =
          await svg.svgPictureStringDecoder(colored, true, null, part.path);

      return MapEntry(partType, pictureInfo);
    });

    final renderedParts = Map.fromEntries(await Future.wait(futures));
    return RenderedAvatar._(this, renderedParts);
  }
}

@freezed
class _Avatar with _$_Avatar {
  const factory _Avatar({
    required Map<PartType, String> parts,
    required Map<PartType, int> colors,
  }) = __Avatar;

  factory _Avatar.fromJson(Map<String, Object?> json) =>
      _$_AvatarFromJson(json);
}

class RenderedAvatar {
  final Avatar _preset;

  Map<PartType, PictureInfo> parts;

  Color get backgroundColor => Color(_preset.colors[PartType.background]!);

  PictureInfo get body => parts[PartType.body] as PictureInfo;

  PictureInfo get head => parts[PartType.head] as PictureInfo;

  PictureInfo get face => parts[PartType.face] as PictureInfo;

  PictureInfo get facialHair => parts[PartType.facialHair] as PictureInfo;

  PictureInfo get accessories => parts[PartType.accessories] as PictureInfo;

  PictureInfo get background => parts[PartType.background] as PictureInfo;

  String get key =>
      '${_preset.parts.values.map((e) => e.path).join('-')}-${_preset.colors.values.join('-')}';

  RenderedAvatar._(this._preset, this.parts);
}

class AvatarNotifier extends Avatar with ChangeNotifier {
  bool loaded = false;

  AvatarNotifier() : super(parts: {}, colors: {});

  void updateAvatar(Avatar newAvatar) {
    parts = newAvatar.parts;
    colors = newAvatar.colors;
    loaded = true;
    notifyListeners();
  }

  void updatePart(PartType partType, Part part) {
    parts[partType] = part;
    notifyListeners();
  }

  void updateColor(PartType partType, int color) {
    colors = {
      ...colors,
      partType: color,
    };
    notifyListeners();
  }
}
