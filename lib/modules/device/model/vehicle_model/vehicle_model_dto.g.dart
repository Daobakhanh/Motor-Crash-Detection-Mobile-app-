// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_model_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleDataModel _$VehicleDataModelFromJson(Map<String, dynamic> json) =>
    VehicleDataModel(
      photoUrl: json['photoUrl'] as String?,
      name: json['name'] as String?,
      color: json['color'] as String?,
      licensePlate: json['licensePlate'] as String?,
      brand: json['brand'] as String?,
      model: json['model'] as String?,
    );

Map<String, dynamic> _$VehicleDataModelToJson(VehicleDataModel instance) =>
    <String, dynamic>{
      'photoUrl': instance.photoUrl,
      'name': instance.name,
      'color': instance.color,
      'licensePlate': instance.licensePlate,
      'brand': instance.brand,
      'model': instance.model,
    };
