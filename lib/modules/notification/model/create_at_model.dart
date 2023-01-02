import 'package:json_annotation/json_annotation.dart';

part 'create_at_model.g.dart';

@JsonSerializable()
class CreateAtModel {
  @JsonKey(name: '_seconds', includeIfNull: false)
  final int? seconds;

  @JsonKey(name: '_nanoseconds', includeIfNull: false)
  final int? nanoseconds;

  CreateAtModel({this.seconds, this.nanoseconds});

  /// factory.
  factory CreateAtModel.fromJson(Map<String, dynamic> json) =>
      _$CreateAtModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAtModelToJson(this);
}
