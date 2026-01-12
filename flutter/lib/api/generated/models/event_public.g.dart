// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_public.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventPublic _$EventPublicFromJson(Map<String, dynamic> json) => _EventPublic(
  title: json['title'] as String,
  id: json['id'] as String,
  calendarId: json['calendar_id'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
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

Map<String, dynamic> _$EventPublicToJson(_EventPublic instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'calendar_id': instance.calendarId,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'is_cancelled': instance.isCancelled,
      'description': instance.description,
      'start_at': instance.startAt?.toIso8601String(),
      'end_at': instance.endAt?.toIso8601String(),
      'actual_start_at': instance.actualStartAt?.toIso8601String(),
      'actual_end_at': instance.actualEndAt?.toIso8601String(),
    };
