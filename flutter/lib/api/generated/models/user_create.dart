// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_create.freezed.dart';
part 'user_create.g.dart';

@Freezed()
abstract class UserCreate with _$UserCreate {
  const factory UserCreate({
    required String name,
    required String email,
    required String password,
  }) = _UserCreate;
  
  factory UserCreate.fromJson(Map<String, Object?> json) => _$UserCreateFromJson(json);
}
