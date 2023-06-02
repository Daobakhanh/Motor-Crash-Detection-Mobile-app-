import 'package:json_annotation/json_annotation.dart';
part 'config_model.g.dart';

@JsonSerializable()
class ConfigModel {
  final bool? antiTheft;

  ConfigModel({this.antiTheft});

  factory ConfigModel.fromJson(Map<String, dynamic> json) =>
      _$ConfigModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigModelToJson(this);
}
