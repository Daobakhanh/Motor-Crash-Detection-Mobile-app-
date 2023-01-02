import 'package:json_annotation/json_annotation.dart';

part 'fcm_noti_model.g.dart';

@JsonSerializable()
class FcmNotiModel {
  FcmNotiModel({
    this.id,
    this.title,
    this.body,
    // this.description,
  });

  int? id;
  String? title;
  String? body;

  /// factory.
  factory FcmNotiModel.fromJson(Map<String, dynamic> json) =>
      _$FcmNotiModelFromJson(json);

  Map<String, dynamic> toJson() => _$FcmNotiModelToJson(this);
}
