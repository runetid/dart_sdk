// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Access _$AccessFromJson(Map<String, dynamic> json) => Access(
      (json['id'] as num).toInt(),
      (json['event_id'] as num).toInt(),
      (json['user_id'] as num).toInt(),
      DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$AccessToJson(Access instance) => <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'user_id': instance.userId,
      'created_at': instance.createdAt.toIso8601String(),
    };
