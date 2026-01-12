// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_private.freezed.dart';
part 'user_private.g.dart';

@Freezed()
abstract class UserPrivate with _$UserPrivate {
  const factory UserPrivate({
    required String name,
    required String id,
    required String nickname,
  }) = _UserPrivate;
  
  factory UserPrivate.fromJson(Map<String, Object?> json) => _$UserPrivateFromJson(json);
}
