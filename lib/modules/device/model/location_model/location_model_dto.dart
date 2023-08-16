import 'package:json_annotation/json_annotation.dart';

import '../create_at_model/create_at_model_dto.dart';
part 'location_model_dto.g.dart';

@JsonSerializable()
class LocationModel {
  final double? longitude;
  final double? latitude;
  final CreateAtModel? createAtModel;
  LocationModel({this.latitude, this.longitude, this.createAtModel});

  /// factory.
  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
