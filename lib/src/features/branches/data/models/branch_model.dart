import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: invalid_annotation_target

part 'branch_model.freezed.dart';
part 'branch_model.g.dart';

@freezed
class BranchModel with _$BranchModel {
  const factory BranchModel({
    @JsonKey(readValue: _readId) required String id,
    @JsonKey(readValue: _readName) required String name,
    @JsonKey(readValue: _readAddress) required String address,
    @JsonKey(readValue: _readPhone) required String phone,
  }) = _BranchModel;

  factory BranchModel.fromJson(Map<String, dynamic> json) =>
      _$BranchModelFromJson(json);
}

Object? _readId(Map json, String key) => json['Id'] ?? json['id'] ?? '';
Object? _readName(Map json, String key) => json['Name'] ?? json['name'] ?? '';
Object? _readAddress(Map json, String key) =>
    json['Address'] ?? json['address'] ?? '';
Object? _readPhone(Map json, String key) => json['Phone'] ?? json['phone'] ?? '';
