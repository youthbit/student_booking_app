// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'room_booking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RoomBookingPreview _$RoomBookingPreviewFromJson(Map<String, dynamic> json) {
  return _RoomBookingPreview.fromJson(json);
}

/// @nodoc
mixin _$RoomBookingPreview {
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get dormitory => throw _privateConstructorUsedError;
  String get roomType => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  int get available => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoomBookingPreviewCopyWith<RoomBookingPreview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomBookingPreviewCopyWith<$Res> {
  factory $RoomBookingPreviewCopyWith(
          RoomBookingPreview value, $Res Function(RoomBookingPreview) then) =
      _$RoomBookingPreviewCopyWithImpl<$Res, RoomBookingPreview>;
  @useResult
  $Res call(
      {String name,
      String email,
      String phone,
      String address,
      String dormitory,
      String roomType,
      int price,
      int available});
}

/// @nodoc
class _$RoomBookingPreviewCopyWithImpl<$Res, $Val extends RoomBookingPreview>
    implements $RoomBookingPreviewCopyWith<$Res> {
  _$RoomBookingPreviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? phone = null,
    Object? address = null,
    Object? dormitory = null,
    Object? roomType = null,
    Object? price = null,
    Object? available = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      dormitory: null == dormitory
          ? _value.dormitory
          : dormitory // ignore: cast_nullable_to_non_nullable
              as String,
      roomType: null == roomType
          ? _value.roomType
          : roomType // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      available: null == available
          ? _value.available
          : available // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RoomBookingPreviewCopyWith<$Res>
    implements $RoomBookingPreviewCopyWith<$Res> {
  factory _$$_RoomBookingPreviewCopyWith(_$_RoomBookingPreview value,
          $Res Function(_$_RoomBookingPreview) then) =
      __$$_RoomBookingPreviewCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String email,
      String phone,
      String address,
      String dormitory,
      String roomType,
      int price,
      int available});
}

/// @nodoc
class __$$_RoomBookingPreviewCopyWithImpl<$Res>
    extends _$RoomBookingPreviewCopyWithImpl<$Res, _$_RoomBookingPreview>
    implements _$$_RoomBookingPreviewCopyWith<$Res> {
  __$$_RoomBookingPreviewCopyWithImpl(
      _$_RoomBookingPreview _value, $Res Function(_$_RoomBookingPreview) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? phone = null,
    Object? address = null,
    Object? dormitory = null,
    Object? roomType = null,
    Object? price = null,
    Object? available = null,
  }) {
    return _then(_$_RoomBookingPreview(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      dormitory: null == dormitory
          ? _value.dormitory
          : dormitory // ignore: cast_nullable_to_non_nullable
              as String,
      roomType: null == roomType
          ? _value.roomType
          : roomType // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      available: null == available
          ? _value.available
          : available // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_RoomBookingPreview extends _RoomBookingPreview {
  const _$_RoomBookingPreview(
      {required this.name,
      required this.email,
      required this.phone,
      required this.address,
      required this.dormitory,
      required this.roomType,
      required this.price,
      required this.available})
      : super._();

  factory _$_RoomBookingPreview.fromJson(Map<String, dynamic> json) =>
      _$$_RoomBookingPreviewFromJson(json);

  @override
  final String name;
  @override
  final String email;
  @override
  final String phone;
  @override
  final String address;
  @override
  final String dormitory;
  @override
  final String roomType;
  @override
  final int price;
  @override
  final int available;

  @override
  String toString() {
    return 'RoomBookingPreview(name: $name, email: $email, phone: $phone, address: $address, dormitory: $dormitory, roomType: $roomType, price: $price, available: $available)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RoomBookingPreview &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.dormitory, dormitory) ||
                other.dormitory == dormitory) &&
            (identical(other.roomType, roomType) ||
                other.roomType == roomType) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.available, available) ||
                other.available == available));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, email, phone, address,
      dormitory, roomType, price, available);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RoomBookingPreviewCopyWith<_$_RoomBookingPreview> get copyWith =>
      __$$_RoomBookingPreviewCopyWithImpl<_$_RoomBookingPreview>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RoomBookingPreviewToJson(
      this,
    );
  }
}

abstract class _RoomBookingPreview extends RoomBookingPreview {
  const factory _RoomBookingPreview(
      {required final String name,
      required final String email,
      required final String phone,
      required final String address,
      required final String dormitory,
      required final String roomType,
      required final int price,
      required final int available}) = _$_RoomBookingPreview;
  const _RoomBookingPreview._() : super._();

  factory _RoomBookingPreview.fromJson(Map<String, dynamic> json) =
      _$_RoomBookingPreview.fromJson;

  @override
  String get name;
  @override
  String get email;
  @override
  String get phone;
  @override
  String get address;
  @override
  String get dormitory;
  @override
  String get roomType;
  @override
  int get price;
  @override
  int get available;
  @override
  @JsonKey(ignore: true)
  _$$_RoomBookingPreviewCopyWith<_$_RoomBookingPreview> get copyWith =>
      throw _privateConstructorUsedError;
}
