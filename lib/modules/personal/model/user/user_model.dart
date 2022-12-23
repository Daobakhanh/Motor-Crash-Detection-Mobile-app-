import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String? name;
  final String? phoneNumber;
  final String? address;
  final String? avatarUrl;
  final String? dateOfBirth;
  final String? citizenNumber;
  final String? token;
  final List<String>? sosNumbers;
  final List<String>? fcmTokens;

  UserModel({
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
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
