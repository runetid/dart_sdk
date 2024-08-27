// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_participant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventParticipant _$EventParticipantFromJson(Map<String, dynamic> json) =>
    EventParticipant(
      (json['id'] as num).toInt(),
      User.fromJson(json['user'] as Map<String, dynamic>),
      EventRole.fromJson(json['role'] as Map<String, dynamic>),
      (json['event_id'] as num).toInt(),
      json['created_at'] as String,
      (json['role_id'] as num).toInt(),
      (json['user_id'] as num).toInt(),
      json['attributes'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$EventParticipantToJson(EventParticipant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'user_id': instance.userId,
      'role_id': instance.roleId,
      'created_at': instance.createdAt,
      'attributes': instance.attributes,
      'user': instance.user,
      'role': instance.role,
    };
