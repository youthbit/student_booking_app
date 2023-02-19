// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$__Avatar _$$__AvatarFromJson(Map<String, dynamic> json) => _$__Avatar(
      parts: (json['parts'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$PartTypeEnumMap, k), e as String),
      ),
      colors: (json['colors'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$PartTypeEnumMap, k), e as int),
      ),
    );

Map<String, dynamic> _$$__AvatarToJson(_$__Avatar instance) =>
    <String, dynamic>{
      'parts': instance.parts.map((k, e) => MapEntry(_$PartTypeEnumMap[k]!, e)),
      'colors':
          instance.colors.map((k, e) => MapEntry(_$PartTypeEnumMap[k]!, e)),
    };

const _$PartTypeEnumMap = {
  PartType.body: 'body',
  PartType.head: 'head',
  PartType.face: 'face',
  PartType.facialHair: 'facialHair',
  PartType.accessories: 'accessories',
  PartType.background: 'background',
};
