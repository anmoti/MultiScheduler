// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_session.freezed.dart';
part 'user_session.g.dart';

@Freezed()
abstract class UserSession with _$UserSession {
  const factory UserSession({
    @JsonKey(name: 'user_id')
    required String userId,
    @JsonKey(name: 'access_token')
    required String accessToken,
    @JsonKey(name: 'refresh_token')
    required String refreshToken,
  }) = _UserSession;
  
  factory UserSession.fromJson(Map<String, Object?> json) => _$UserSessionFromJson(json);
}
