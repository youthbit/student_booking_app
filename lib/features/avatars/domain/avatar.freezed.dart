// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'avatar.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

_Avatar _$_AvatarFromJson(Map<String, dynamic> json) {
  return __Avatar.fromJson(json);
}

/// @nodoc
mixin _$_Avatar {
  Map<PartType, String> get parts => throw _privateConstructorUsedError;
  Map<PartType, int> get colors => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$AvatarCopyWith<_Avatar> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$AvatarCopyWith<$Res> {
  factory _$AvatarCopyWith(_Avatar value, $Res Function(_Avatar) then) =
      __$AvatarCopyWithImpl<$Res, _Avatar>;
  @useResult
  $Res call({Map<PartType, String> parts, Map<PartType, int> colors});
}

/// @nodoc
class __$AvatarCopyWithImpl<$Res, $Val extends _Avatar>
    implements _$AvatarCopyWith<$Res> {
  __$AvatarCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parts = null,
    Object? colors = null,
  }) {
    return _then(_value.copyWith(
      parts: null == parts
          ? _value.parts
          : parts // ignore: cast_nullable_to_non_nullable
              as Map<PartType, String>,
      colors: null == colors
          ? _value.colors
          : colors // ignore: cast_nullable_to_non_nullable
              as Map<PartType, int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$__AvatarCopyWith<$Res> implements _$AvatarCopyWith<$Res> {
  factory _$$__AvatarCopyWith(
          _$__Avatar value, $Res Function(_$__Avatar) then) =
      __$$__AvatarCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<PartType, String> parts, Map<PartType, int> colors});
}

/// @nodoc
class __$$__AvatarCopyWithImpl<$Res>
    extends __$AvatarCopyWithImpl<$Res, _$__Avatar>
    implements _$$__AvatarCopyWith<$Res> {
  __$$__AvatarCopyWithImpl(_$__Avatar _value, $Res Function(_$__Avatar) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parts = null,
    Object? colors = null,
  }) {
    return _then(_$__Avatar(
      parts: null == parts
          ? _value._parts
          : parts // ignore: cast_nullable_to_non_nullable
              as Map<PartType, String>,
      colors: null == colors
          ? _value._colors
          : colors // ignore: cast_nullable_to_non_nullable
              as Map<PartType, int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$__Avatar with DiagnosticableTreeMixin implements __Avatar {
  const _$__Avatar(
      {required final Map<PartType, String> parts,
      required final Map<PartType, int> colors})
      : _parts = parts,
        _colors = colors;

  factory _$__Avatar.fromJson(Map<String, dynamic> json) =>
      _$$__AvatarFromJson(json);

  final Map<PartType, String> _parts;
  @override
  Map<PartType, String> get parts {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_parts);
  }

  final Map<PartType, int> _colors;
  @override
  Map<PartType, int> get colors {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_colors);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_Avatar(parts: $parts, colors: $colors)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_Avatar'))
      ..add(DiagnosticsProperty('parts', parts))
      ..add(DiagnosticsProperty('colors', colors));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$__Avatar &&
            const DeepCollectionEquality().equals(other._parts, _parts) &&
            const DeepCollectionEquality().equals(other._colors, _colors));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_parts),
      const DeepCollectionEquality().hash(_colors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$__AvatarCopyWith<_$__Avatar> get copyWith =>
      __$$__AvatarCopyWithImpl<_$__Avatar>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$__AvatarToJson(
      this,
    );
  }
}

abstract class __Avatar implements _Avatar {
  const factory __Avatar(
      {required final Map<PartType, String> parts,
      required final Map<PartType, int> colors}) = _$__Avatar;

  factory __Avatar.fromJson(Map<String, dynamic> json) = _$__Avatar.fromJson;

  @override
  Map<PartType, String> get parts;
  @override
  Map<PartType, int> get colors;
  @override
  @JsonKey(ignore: true)
  _$$__AvatarCopyWith<_$__Avatar> get copyWith =>
      throw _privateConstructorUsedError;
}
