// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_login.freezed.dart';
part 'user_login.g.dart';

@Freezed()
abstract class UserLogin with _$UserLogin {
  const factory UserLogin({
    required String email,
    required String password,
  }) = _UserLogin;
  
  factory UserLogin.fromJson(Map<String, Object?> json) => _$UserLoginFromJson(json);
}
