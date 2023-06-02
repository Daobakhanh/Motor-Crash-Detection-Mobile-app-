// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_noti_model_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FcmNotiModel _$FcmNotiModelFromJson(Map<String, dynamic> json) => FcmNotiModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      body: json['body'] as String?,
    );

Map<String, dynamic> _$FcmNotiModelToJson(FcmNotiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
    };
