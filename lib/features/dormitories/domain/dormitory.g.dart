// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dormitory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Dormitory _$$_DormitoryFromJson(Map<String, dynamic> json) => _$_Dormitory(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      address: json['address'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      rooms: (json['rooms'] as List<dynamic>)
          .map((e) => Room.fromJson(e as Map<String, dynamic>))
          .toList(),
      photos:
          (json['photos'] as List<dynamic>).map((e) => e as String).toList(),
      priceMin: json['price_min'] as int,
      priceMax: json['price_max'] as int,
    );

Map<String, dynamic> _$$_DormitoryToJson(_$_Dormitory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
      'rooms': instance.rooms,
      'photos': instance.photos,
      'price_min': instance.priceMin,
      'price_max': instance.priceMax,
    };
