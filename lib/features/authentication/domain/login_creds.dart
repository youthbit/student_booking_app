import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_creds.g.dart';
part 'login_creds.freezed.dart';

@freezed
class Creds with _$Creds {
  const factory Creds({
    required String token,
  }) = _Creds;

  factory Creds.fromJson(Map<String, Object?> json) => _$CredsFromJson(json);
}
