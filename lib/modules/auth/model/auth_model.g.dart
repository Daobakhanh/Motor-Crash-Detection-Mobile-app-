// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthModel _$AuthModelFromJson(Map<String, dynamic> json) => AuthModel(
      accessToken: json['accessToken'] as String?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthModelToJson(AuthModel instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'user': instance.user,
    };
