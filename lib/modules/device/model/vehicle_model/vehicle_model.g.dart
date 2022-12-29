// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleDataModel _$VehicleModelFromJson(Map<String, dynamic> json) =>
    VehicleDataModel(
      photoUrl: json['photoUrl'] as String?,
      name: json['name'] as String?,
      color: json['color'] as String?,
      licensePlate: json['licensePlate'] as String?,
      brand: json['brand'] as String?,
      model: json['model'] as String?,
    );

Map<String, dynamic> _$VehicleModelToJson(VehicleDataModel instance) =>
    <String, dynamic>{
      'photoUrl': instance.photoUrl,
      'name': instance.name,
      'color': instance.color,
      'licensePlate': instance.licensePlate,
      'brand': instance.brand,
      'model': instance.model,
    };
