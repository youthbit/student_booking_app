// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'login_creds.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Creds _$CredsFromJson(Map<String, dynamic> json) {
  return _Creds.fromJson(json);
}

/// @nodoc
mixin _$Creds {
  String get token => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CredsCopyWith<Creds> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CredsCopyWith<$Res> {
  factory $CredsCopyWith(Creds value, $Res Function(Creds) then) =
      _$CredsCopyWithImpl<$Res, Creds>;
  @useResult
  $Res call({String token});
}

/// @nodoc
class _$CredsCopyWithImpl<$Res, $Val extends Creds>
    implements $CredsCopyWith<$Res> {
  _$CredsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_value.copyWith(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CredsCopyWith<$Res> implements $CredsCopyWith<$Res> {
  factory _$$_CredsCopyWith(_$_Creds value, $Res Function(_$_Creds) then) =
      __$$_CredsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String token});
}

/// @nodoc
class __$$_CredsCopyWithImpl<$Res> extends _$CredsCopyWithImpl<$Res, _$_Creds>
    implements _$$_CredsCopyWith<$Res> {
  __$$_CredsCopyWithImpl(_$_Creds _value, $Res Function(_$_Creds) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_$_Creds(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Creds with DiagnosticableTreeMixin implements _Creds {
  const _$_Creds({required this.token});

  factory _$_Creds.fromJson(Map<String, dynamic> json) =>
      _$$_CredsFromJson(json);

  @override
  final String token;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Creds(token: $token)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Creds'))
      ..add(DiagnosticsProperty('token', token));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Creds &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CredsCopyWith<_$_Creds> get copyWith =>
      __$$_CredsCopyWithImpl<_$_Creds>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CredsToJson(
      this,
    );
  }
}

abstract class _Creds implements Creds {
  const factory _Creds({required final String token}) = _$_Creds;

  factory _Creds.fromJson(Map<String, dynamic> json) = _$_Creds.fromJson;

  @override
  String get token;
  @override
  @JsonKey(ignore: true)
  _$$_CredsCopyWith<_$_Creds> get copyWith =>
      throw _privateConstructorUsedError;
}
