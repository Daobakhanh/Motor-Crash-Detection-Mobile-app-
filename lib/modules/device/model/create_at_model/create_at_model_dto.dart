import 'package:json_annotation/json_annotation.dart';
part 'create_at_model_dto.g.dart';

@JsonSerializable()
class CreateAtModel {
  @JsonKey(name: '_seconds')
  final int? seconds;

  @JsonKey(name: '_nanoseconds')
  final int? nanoseconds;

  CreateAtModel({this.nanoseconds, this.seconds});

  factory CreateAtModel.fromJson(Map<String, dynamic> json) =>
      _$CreateAtModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAtModelToJson(this);
}
