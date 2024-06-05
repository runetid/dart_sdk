// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_palce.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventPlace _$EventPlaceFromJson(Map<String, dynamic> json) => EventPlace(
      (json['id'] as num).toInt(),
      json['place'] as String,
    );

Map<String, dynamic> _$EventPlaceToJson(EventPlace instance) =>
    <String, dynamic>{
      'id': instance.id,
      'place': instance.place,
    };
