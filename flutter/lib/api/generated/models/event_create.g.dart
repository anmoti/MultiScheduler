// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventCreate _$EventCreateFromJson(Map<String, dynamic> json) => _EventCreate(
  title: json['title'] as String,
  isCancelled: json['is_cancelled'] as bool? ?? false,
  description: json['description'] as String?,
  startAt: json['start_at'] == null
      ? null
      : DateTime.parse(json['start_at'] as String),
  endAt: json['end_at'] == null
      ? null
      : DateTime.parse(json['end_at'] as String),
  actualStartAt: json['actual_start_at'] == null
      ? null
      : DateTime.parse(json['actual_start_at'] as String),
  actualEndAt: json['actual_end_at'] == null
      ? null
      : DateTime.parse(json['actual_end_at'] as String),
);

Map<String, dynamic> _$EventCreateToJson(_EventCreate instance) =>
    <String, dynamic>{
      'title': instance.title,
      'is_cancelled': instance.isCancelled,
      'description': instance.description,
      'start_at': instance.startAt?.toIso8601String(),
      'end_at': instance.endAt?.toIso8601String(),
      'actual_start_at': instance.actualStartAt?.toIso8601String(),
      'actual_end_at': instance.actualEndAt?.toIso8601String(),
    };
