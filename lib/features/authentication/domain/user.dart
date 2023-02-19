import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  @Assert('name != ""')
  @Assert('email != ""')
  @Assert('phone != ""')
  @Assert('token != ""')
  const factory User.loggedUser({
    required String id,
    required String name,
    required String email,
    required String phone,
    required String token,
  }) = _User;
  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
