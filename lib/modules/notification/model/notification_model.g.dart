// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['id'] as String?,
      isRead: json['isRead'] as bool?,
      userId: json['userId'] as String?,
      title: json['title'] as String?,
      deviceId: json['deviceId'] as String?,
      content: json['content'] as String?,
      type: json['type'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : CreateAtModel.fromJson(json['createdAt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isRead': instance.isRead,
      'userId': instance.userId,
      'title': instance.title,
      'deviceId': instance.deviceId,
      'content': instance.content,
      'type': instance.type,
      'createdAt': instance.createdAt,
    };
