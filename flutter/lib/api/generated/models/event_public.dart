// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_public.freezed.dart';
part 'event_public.g.dart';

@Freezed()
abstract class EventPublic with _$EventPublic {
  const factory EventPublic({
    required String title,
    required String id,
    @JsonKey(name: 'calendar_id')
    required String calendarId,
    @JsonKey(name: 'created_at')
    required DateTime createdAt,
    @JsonKey(name: 'updated_at')
    required DateTime updatedAt,
    @JsonKey(name: 'is_cancelled')
    @Default(false)
    bool isCancelled,
    String? description,
    @JsonKey(name: 'start_at')
    DateTime? startAt,
    @JsonKey(name: 'end_at')
    DateTime? endAt,
    @JsonKey(name: 'actual_start_at')
    DateTime? actualStartAt,
    @JsonKey(name: 'actual_end_at')
    DateTime? actualEndAt,
  }) = _EventPublic;
  
  factory EventPublic.fromJson(Map<String, Object?> json) => _$EventPublicFromJson(json);
}
