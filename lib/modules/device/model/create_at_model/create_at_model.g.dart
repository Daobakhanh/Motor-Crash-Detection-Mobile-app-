// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_at_model_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAtModel _$CreateAtModelFromJson(Map<String, dynamic> json) =>
    CreateAtModel(
      nanoseconds: json['_nanoseconds'] as int?,
      seconds: json['_seconds'] as int?,
    );

Map<String, dynamic> _$CreateAtModelToJson(CreateAtModel instance) =>
    <String, dynamic>{
      '_seconds': instance.seconds,
      '_nanoseconds': instance.nanoseconds,
    };
