// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_signup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSignUpModel _$AuthSignUpModelFromJson(Map<String, dynamic> json) =>
    AuthSignUpModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      citizenNumber: json['citizenNumber'] as String?,
      token: json['token'] as String?,
      sosNumbers: (json['sosNumbers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      fcmTokens: (json['fcmTokens'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AuthSignUpModelToJson(AuthSignUpModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'avatarUrl': instance.avatarUrl,
      'dateOfBirth': instance.dateOfBirth,
      'citizenNumber': instance.citizenNumber,
      'token': instance.token,
      'sosNumbers': instance.sosNumbers,
      'fcmTokens': instance.fcmTokens,
    };
