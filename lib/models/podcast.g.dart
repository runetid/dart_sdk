// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Podcast _$PodcastFromJson(Map<String, dynamic> json) => Podcast(
      (json['id'] as num).toInt(),
      json['title'] as String,
      (json['sort'] as num).toInt(),
      json['url'] as String,
      DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$PodcastToJson(Podcast instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'sort': instance.sort,
      'url': instance.url,
      'created_at': instance.createdAt.toIso8601String(),
    };
