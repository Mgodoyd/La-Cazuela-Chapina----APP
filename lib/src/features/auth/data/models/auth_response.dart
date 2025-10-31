import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: invalid_annotation_target

import 'auth_tokens.dart';
import 'user_model.dart';

part 'auth_response.freezed.dart';
part 'auth_response.g.dart';

@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    @JsonKey(name: 'User') required UserModel user,
    @JsonKey(name: 'Tokens') required AuthTokens tokens,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}




