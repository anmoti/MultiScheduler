// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_update.freezed.dart';
part 'calendar_update.g.dart';

@Freezed()
abstract class CalendarUpdate with _$CalendarUpdate {
  const factory CalendarUpdate({
    String? name,
  }) = _CalendarUpdate;
  
  factory CalendarUpdate.fromJson(Map<String, Object?> json) => _$CalendarUpdateFromJson(json);
}
