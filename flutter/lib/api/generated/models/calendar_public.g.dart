// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_public.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CalendarPublic _$CalendarPublicFromJson(Map<String, dynamic> json) =>
    _CalendarPublic(
      name: json['name'] as String,
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$CalendarPublicToJson(_CalendarPublic instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
