// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'event_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EventDetails _$EventDetailsFromJson(Map<String, dynamic> json) {
  return _EventDetails.fromJson(json);
}

/// @nodoc
mixin _$EventDetails {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  List<String> get photos => throw _privateConstructorUsedError;
  List<String> get videos => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventDetailsCopyWith<EventDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventDetailsCopyWith<$Res> {
  factory $EventDetailsCopyWith(
          EventDetails value, $Res Function(EventDetails) then) =
      _$EventDetailsCopyWithImpl<$Res, EventDetails>;
  @useResult
  $Res call(
      {String id,
      String type,
      String description,
      String name,
      int price,
      List<String> photos,
      List<String> videos});
}

/// @nodoc
class _$EventDetailsCopyWithImpl<$Res, $Val extends EventDetails>
    implements $EventDetailsCopyWith<$Res> {
  _$EventDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? description = null,
    Object? name = null,
    Object? price = null,
    Object? photos = null,
    Object? videos = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      photos: null == photos
          ? _value.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      videos: null == videos
          ? _value.videos
          : videos // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EventDetailsCopyWith<$Res>
    implements $EventDetailsCopyWith<$Res> {
  factory _$$_EventDetailsCopyWith(
          _$_EventDetails value, $Res Function(_$_EventDetails) then) =
      __$$_EventDetailsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String type,
      String description,
      String name,
      int price,
      List<String> photos,
      List<String> videos});
}

/// @nodoc
class __$$_EventDetailsCopyWithImpl<$Res>
    extends _$EventDetailsCopyWithImpl<$Res, _$_EventDetails>
    implements _$$_EventDetailsCopyWith<$Res> {
  __$$_EventDetailsCopyWithImpl(
      _$_EventDetails _value, $Res Function(_$_EventDetails) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? description = null,
    Object? name = null,
    Object? price = null,
    Object? photos = null,
    Object? videos = null,
  }) {
    return _then(_$_EventDetails(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      photos: null == photos
          ? _value._photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      videos: null == videos
          ? _value._videos
          : videos // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_EventDetails extends _EventDetails {
  const _$_EventDetails(
      {required this.id,
      required this.type,
      required this.description,
      required this.name,
      required this.price,
      required final List<String> photos,
      required final List<String> videos})
      : _photos = photos,
        _videos = videos,
        super._();

  factory _$_EventDetails.fromJson(Map<String, dynamic> json) =>
      _$$_EventDetailsFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final String description;
  @override
  final String name;
  @override
  final int price;
  final List<String> _photos;
  @override
  List<String> get photos {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photos);
  }

  final List<String> _videos;
  @override
  List<String> get videos {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_videos);
  }

  @override
  String toString() {
    return 'EventDetails(id: $id, type: $type, description: $description, name: $name, price: $price, photos: $photos, videos: $videos)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventDetails &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            const DeepCollectionEquality().equals(other._photos, _photos) &&
            const DeepCollectionEquality().equals(other._videos, _videos));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      description,
      name,
      price,
      const DeepCollectionEquality().hash(_photos),
      const DeepCollectionEquality().hash(_videos));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventDetailsCopyWith<_$_EventDetails> get copyWith =>
      __$$_EventDetailsCopyWithImpl<_$_EventDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventDetailsToJson(
      this,
    );
  }
}

abstract class _EventDetails extends EventDetails {
  const factory _EventDetails(
      {required final String id,
      required final String type,
      required final String description,
      required final String name,
      required final int price,
      required final List<String> photos,
      required final List<String> videos}) = _$_EventDetails;
  const _EventDetails._() : super._();

  factory _EventDetails.fromJson(Map<String, dynamic> json) =
      _$_EventDetails.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  String get description;
  @override
  String get name;
  @override
  int get price;
  @override
  List<String> get photos;
  @override
  List<String> get videos;
  @override
  @JsonKey(ignore: true)
  _$$_EventDetailsCopyWith<_$_EventDetails> get copyWith =>
      throw _privateConstructorUsedError;
}
