// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_create.freezed.dart';
part 'event_create.g.dart';

@Freezed()
abstract class EventCreate with _$EventCreate {
  const factory EventCreate({
    required String title,
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
  }) = _EventCreate;
  
  factory EventCreate.fromJson(Map<String, Object?> json) => _$EventCreateFromJson(json);
}
