import 'package:json_annotation/json_annotation.dart';

import '../config_device_feature_model/config_model.dart';
import '../create_at_model/create_at_model.dart';
import '../location_model/location_model.dart';
import '../vehicle_model/vehicle_model.dart';
part 'device_model.g.dart';

@JsonSerializable()
class DeviceModel {
  final String? id;
  final List<LocationModel>? locations;
  final ConfigModel? config;
  final CreateAtModel? createdAt;
  final String? userId;
  final VehicleDataModel? vehicle;
  final int? status;

  @JsonKey(name: 'name')
  final String? deviceName;

  DeviceModel({
    this.id,
    this.createdAt,
    this.userId,
    this.locations,
    this.vehicle,
    this.status,
    this.config,
    this.deviceName,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceModelToJson(this);
}
