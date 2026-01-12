// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_public.freezed.dart';
part 'calendar_public.g.dart';

@Freezed()
abstract class CalendarPublic with _$CalendarPublic {
  const factory CalendarPublic({
    required String name,
    required String id,
    @JsonKey(name: 'created_at')
    required DateTime createdAt,
    @JsonKey(name: 'updated_at')
    required DateTime updatedAt,
  }) = _CalendarPublic;
  
  factory CalendarPublic.fromJson(Map<String, Object?> json) => _$CalendarPublicFromJson(json);
}
