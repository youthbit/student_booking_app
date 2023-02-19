// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Room _$$_RoomFromJson(Map<String, dynamic> json) => _$_Room(
      id: json['id'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      price: json['price'] as int,
      photos:
          (json['photos'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_RoomToJson(_$_Room instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'type': instance.type,
      'price': instance.price,
      'photos': instance.photos,
    };
