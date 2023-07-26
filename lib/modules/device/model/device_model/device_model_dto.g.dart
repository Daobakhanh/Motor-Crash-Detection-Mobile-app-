// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_model_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceModel _$DeviceModelFromJson(Map<String, dynamic> json) => DeviceModel(
      id: json['id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : CreateAtModel.fromJson(json['createdAt'] as Map<String, dynamic>),
      userId: json['userId'] as String?,
      vehicle: json['vehicle'] == null
          ? null
          : VehicleDataModel.fromJson(json['vehicle'] as Map<String, dynamic>),
      status: json['status'] as int?,
      config: json['config'] == null
          ? null
          : ConfigModel.fromJson(json['config'] as Map<String, dynamic>),
      deviceName: json['name'] as String?,
      battery: (json['battery'] as num?)?.toDouble(),
      isConnected: json['isConnected'] as bool?,
      isCharging: json['isCharging'] as bool?,
    );

Map<String, dynamic> _$DeviceModelToJson(DeviceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'config': instance.config,
      'createdAt': instance.createdAt,
      'userId': instance.userId,
      'vehicle': instance.vehicle,
      'status': instance.status,
      'battery': instance.battery,
      'isConnected': instance.isConnected,
      'isCharging': instance.isCharging,
      'name': instance.deviceName,
    };
