// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'dormitory.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Dormitory _$DormitoryFromJson(Map<String, dynamic> json) {
  return _Dormitory.fromJson(json);
}

/// @nodoc
mixin _$Dormitory {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;
  List<Room> get rooms => throw _privateConstructorUsedError;
  List<String> get photos => throw _privateConstructorUsedError;
  int get priceMin => throw _privateConstructorUsedError;
  int get priceMax => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DormitoryCopyWith<Dormitory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DormitoryCopyWith<$Res> {
  factory $DormitoryCopyWith(Dormitory value, $Res Function(Dormitory) then) =
      _$DormitoryCopyWithImpl<$Res, Dormitory>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String address,
      double lat,
      double lng,
      List<Room> rooms,
      List<String> photos,
      int priceMin,
      int priceMax});
}

/// @nodoc
class _$DormitoryCopyWithImpl<$Res, $Val extends Dormitory>
    implements $DormitoryCopyWith<$Res> {
  _$DormitoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? address = null,
    Object? lat = null,
    Object? lng = null,
    Object? rooms = null,
    Object? photos = null,
    Object? priceMin = null,
    Object? priceMax = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      rooms: null == rooms
          ? _value.rooms
          : rooms // ignore: cast_nullable_to_non_nullable
              as List<Room>,
      photos: null == photos
          ? _value.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      priceMin: null == priceMin
          ? _value.priceMin
          : priceMin // ignore: cast_nullable_to_non_nullable
              as int,
      priceMax: null == priceMax
          ? _value.priceMax
          : priceMax // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DormitoryCopyWith<$Res> implements $DormitoryCopyWith<$Res> {
  factory _$$_DormitoryCopyWith(
          _$_Dormitory value, $Res Function(_$_Dormitory) then) =
      __$$_DormitoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String address,
      double lat,
      double lng,
      List<Room> rooms,
      List<String> photos,
      int priceMin,
      int priceMax});
}

/// @nodoc
class __$$_DormitoryCopyWithImpl<$Res>
    extends _$DormitoryCopyWithImpl<$Res, _$_Dormitory>
    implements _$$_DormitoryCopyWith<$Res> {
  __$$_DormitoryCopyWithImpl(
      _$_Dormitory _value, $Res Function(_$_Dormitory) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? address = null,
    Object? lat = null,
    Object? lng = null,
    Object? rooms = null,
    Object? photos = null,
    Object? priceMin = null,
    Object? priceMax = null,
  }) {
    return _then(_$_Dormitory(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      rooms: null == rooms
          ? _value._rooms
          : rooms // ignore: cast_nullable_to_non_nullable
              as List<Room>,
      photos: null == photos
          ? _value._photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      priceMin: null == priceMin
          ? _value.priceMin
          : priceMin // ignore: cast_nullable_to_non_nullable
              as int,
      priceMax: null == priceMax
          ? _value.priceMax
          : priceMax // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_Dormitory extends _Dormitory {
  const _$_Dormitory(
      {required this.id,
      required this.name,
      required this.description,
      required this.address,
      required this.lat,
      required this.lng,
      required final List<Room> rooms,
      required final List<String> photos,
      required this.priceMin,
      required this.priceMax})
      : _rooms = rooms,
        _photos = photos,
        super._();

  factory _$_Dormitory.fromJson(Map<String, dynamic> json) =>
      _$$_DormitoryFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String address;
  @override
  final double lat;
  @override
  final double lng;
  final List<Room> _rooms;
  @override
  List<Room> get rooms {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rooms);
  }

  final List<String> _photos;
  @override
  List<String> get photos {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photos);
  }

  @override
  final int priceMin;
  @override
  final int priceMax;

  @override
  String toString() {
    return 'Dormitory(id: $id, name: $name, description: $description, address: $address, lat: $lat, lng: $lng, rooms: $rooms, photos: $photos, priceMin: $priceMin, priceMax: $priceMax)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Dormitory &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            const DeepCollectionEquality().equals(other._rooms, _rooms) &&
            const DeepCollectionEquality().equals(other._photos, _photos) &&
            (identical(other.priceMin, priceMin) ||
                other.priceMin == priceMin) &&
            (identical(other.priceMax, priceMax) ||
                other.priceMax == priceMax));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      address,
      lat,
      lng,
      const DeepCollectionEquality().hash(_rooms),
      const DeepCollectionEquality().hash(_photos),
      priceMin,
      priceMax);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DormitoryCopyWith<_$_Dormitory> get copyWith =>
      __$$_DormitoryCopyWithImpl<_$_Dormitory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DormitoryToJson(
      this,
    );
  }
}

abstract class _Dormitory extends Dormitory {
  const factory _Dormitory(
      {required final String id,
      required final String name,
      required final String description,
      required final String address,
      required final double lat,
      required final double lng,
      required final List<Room> rooms,
      required final List<String> photos,
      required final int priceMin,
      required final int priceMax}) = _$_Dormitory;
  const _Dormitory._() : super._();

  factory _Dormitory.fromJson(Map<String, dynamic> json) =
      _$_Dormitory.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get address;
  @override
  double get lat;
  @override
  double get lng;
  @override
  List<Room> get rooms;
  @override
  List<String> get photos;
  @override
  int get priceMin;
  @override
  int get priceMax;
  @override
  @JsonKey(ignore: true)
  _$$_DormitoryCopyWith<_$_Dormitory> get copyWith =>
      throw _privateConstructorUsedError;
}
