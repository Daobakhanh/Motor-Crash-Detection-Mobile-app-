import 'package:json_annotation/json_annotation.dart';
import 'package:motorbike_crash_detection/modules/device/model/create_at_model/create_at_model.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  final String? id;
  final bool? isRead;
  final String? userId;
  final String? title;
  final String? deviceId;
  final String? content;
  final int? type;
  final CreateAtModel? createdAt;

  NotificationModel({
    this.id,
    this.isRead,
    this.userId,
    this.title,
    this.deviceId,
    this.content,
    this.type,
    this.createdAt,
  });

  /// factory.
  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
