// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EventDetails _$$_EventDetailsFromJson(Map<String, dynamic> json) =>
    _$_EventDetails(
      id: json['id'] as String,
      type: json['type'] as String,
      description: json['description'] as String,
      name: json['name'] as String,
      price: json['price'] as int,
      photos:
          (json['photos'] as List<dynamic>).map((e) => e as String).toList(),
      videos:
          (json['videos'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_EventDetailsToJson(_$_EventDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'description': instance.description,
      'name': instance.name,
      'price': instance.price,
      'photos': instance.photos,
      'videos': instance.videos,
    };
