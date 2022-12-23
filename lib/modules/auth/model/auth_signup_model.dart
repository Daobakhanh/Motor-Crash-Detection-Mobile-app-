import 'package:json_annotation/json_annotation.dart';

part 'auth_signup_model.g.dart';

@JsonSerializable()
class AuthSignUpModel {
  final String? id;
  final String? name;
  final String? phoneNumber;
  final String? address;
  final String? avatarUrl;
  final String? dateOfBirth;
  final String? citizenNumber;
  final String? token;
  final List<String>? sosNumbers;
  final List<String>? fcmTokens;
  AuthSignUpModel({
    this.id,
    this.name,
    this.phoneNumber,
    this.address,
    this.avatarUrl,
    this.dateOfBirth,
    this.citizenNumber,
    this.token,
    this.sosNumbers,
    this.fcmTokens,
  });

  /// factory.
  factory AuthSignUpModel.fromJson(Map<String, dynamic> json) =>
      _$AuthSignUpModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthSignUpModelToJson(this);
}
