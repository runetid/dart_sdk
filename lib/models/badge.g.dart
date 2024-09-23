// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Badge _$BadgeFromJson(Map<String, dynamic> json) => Badge(
      (json['id'] as num).toInt(),
      (json['event_id'] as num).toInt(),
      (json['operator_id'] as num).toInt(),
      (json['user_id'] as num).toInt(),
      (json['role_id'] as num).toInt(),
      DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$BadgeToJson(Badge instance) => <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'operator_id': instance.operatorId,
      'user_id': instance.userId,
      'role_id': instance.roleId,
      'created_at': instance.createdAt.toIso8601String(),
    };
