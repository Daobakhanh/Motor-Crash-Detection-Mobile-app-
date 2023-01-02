// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_at_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAtModel _$CreateAtModelFromJson(Map<String, dynamic> json) =>
    CreateAtModel(
      seconds: json['_seconds'] as int?,
      nanoseconds: json['_nanoseconds'] as int?,
    );

Map<String, dynamic> _$CreateAtModelToJson(CreateAtModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('_seconds', instance.seconds);
  writeNotNull('_nanoseconds', instance.nanoseconds);
  return val;
}
