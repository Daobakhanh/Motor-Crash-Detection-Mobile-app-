import 'package:json_annotation/json_annotation.dart';

import '../../../lib.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class AuthModel {
  final String? accessToken;
  final UserModel? user;
  AuthModel({
    this.accessToken,
    this.user,
  });

  /// factory.
  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthModelToJson(this);
}
