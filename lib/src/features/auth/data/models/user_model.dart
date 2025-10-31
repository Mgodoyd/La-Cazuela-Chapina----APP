import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: invalid_annotation_target

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(readValue: _readId) required String id,
    @JsonKey(readValue: _readName) required String name,
    @JsonKey(readValue: _readEmail) required String email,
    @JsonKey(readValue: _readRole) required String role,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

Object? _readId(Map json, String key) => json['Id'] ?? json['id'] ?? '';
Object? _readName(Map json, String key) => json['Name'] ?? json['name'] ?? '';
Object? _readEmail(Map json, String key) => json['Email'] ?? json['email'] ?? '';
Object? _readRole(Map json, String key) => json['Role'] ?? json['role'] ?? '';
