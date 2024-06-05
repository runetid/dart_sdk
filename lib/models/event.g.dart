// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      (json['id'] as num).toInt(),
      json['title'] as String,
      json['id_name'] as String,
      json['end_time'] as String,
      json['full_info'] as String,
      json['info'] as String,
      json['site_url'] as String,
      json['start_time'] as String,
      (json['default_role_id'] as num).toInt(),
      json['full_info_embedded_url'] as String,
      json['logo_source'] as String?,
      json['visible_on_main'] as bool,
      (json['places'] as List<dynamic>?)
          ?.map((e) => EventPlace.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'id_name': instance.idName,
      'title': instance.title,
      'start_time': instance.startTime,
      'site_url': instance.siteUrl,
      'info': instance.info,
      'full_info': instance.fullInfo,
      'end_time': instance.endTime,
      'logo_source': instance.logoSource,
      'full_info_embedded_url': instance.fullInfoEmbeddedUrl,
      'visible_on_main': instance.visibleOnMain,
      'default_role_id': instance.defaultRoleId,
      'places': instance.places,
    };
