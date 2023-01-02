import 'package:json_annotation/json_annotation.dart';
part 'vehicle_model.g.dart';

@JsonSerializable()
class VehicleDataModel {
  final String? photoUrl;
  final String? name;
  final String? color;
  final String? licensePlate;
  final String? brand;
  final String? model;

  VehicleDataModel({
    this.photoUrl,
    this.name,
    this.color,
    this.licensePlate,
    this.brand,
    this.model,
  });

  /// factory.
  factory VehicleDataModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleDataModelToJson(this);
}
