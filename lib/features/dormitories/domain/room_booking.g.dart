// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RoomBookingPreview _$$_RoomBookingPreviewFromJson(
        Map<String, dynamic> json) =>
    _$_RoomBookingPreview(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      dormitory: json['dormitory'] as String,
      roomType: json['room_type'] as String,
      price: json['price'] as int,
      available: json['available'] as int,
    );

Map<String, dynamic> _$$_RoomBookingPreviewToJson(
        _$_RoomBookingPreview instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'dormitory': instance.dormitory,
      'room_type': instance.roomType,
      'price': instance.price,
      'available': instance.available,
    };
