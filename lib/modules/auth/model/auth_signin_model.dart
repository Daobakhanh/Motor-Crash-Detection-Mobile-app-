import 'package:json_annotation/json_annotation.dart';

part 'auth_signin_model.g.dart';

@JsonSerializable()
class AuthSignInModel {
  final String? fcmToken;
  AuthSignInModel({this.fcmToken});

  factory AuthSignInModel.fromJson(Map<String, dynamic> json) =>
      _$AuthSignInModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthSignInModelToJson(this);
}
