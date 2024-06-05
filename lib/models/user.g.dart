// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      (json['id'] as num).toInt(),
      (json['runet_id'] as num).toInt(),
      json['email'] as String,
      json['first_name'] as String,
      json['last_name'] as String,
      json['father_name'] as String,
      DateTime.parse(json['birthday'] as String),
      json['photo'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'runet_id': instance.runetId,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'father_name': instance.fatherName,
      'email': instance.email,
      'photo': instance.photo,
      'birthday': instance.birthday.toIso8601String(),
    };
