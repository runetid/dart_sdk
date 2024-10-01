// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'even_role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventRole _$EventRoleFromJson(Map<String, dynamic> json) => EventRole(
      (json['id'] as num).toInt(),
      json['title'] as String,
      json['code'] as String,
      json['color'] == null ? '#228B22' : json['color'] as String,
    )..validPeriod = (json['valid_period'] as num?)?.toInt();

Map<String, dynamic> _$EventRoleToJson(EventRole instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'code': instance.code,
      'color': instance.color,
      'valid_period': instance.validPeriod,
    };
