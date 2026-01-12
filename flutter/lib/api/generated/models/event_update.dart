// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_update.freezed.dart';
part 'event_update.g.dart';

@Freezed()
abstract class EventUpdate with _$EventUpdate {
  const factory EventUpdate({
    String? title,
    String? description,
    @JsonKey(name: 'start_at')
    DateTime? startAt,
    @JsonKey(name: 'end_at')
    DateTime? endAt,
    @JsonKey(name: 'actual_start_at')
    DateTime? actualStartAt,
    @JsonKey(name: 'actual_end_at')
    DateTime? actualEndAt,
    @JsonKey(name: 'is_cancelled')
    bool? isCancelled,
  }) = _EventUpdate;
  
  factory EventUpdate.fromJson(Map<String, Object?> json) => _$EventUpdateFromJson(json);
}
