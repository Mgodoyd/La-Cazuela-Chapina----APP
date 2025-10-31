import 'package:dio/dio.dart';

import 'models/auth_response.dart';
import 'models/auth_tokens.dart';
import 'models/user_model.dart';

class AuthApi {
  AuthApi(this._dio);

  final Dio _dio;

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/user/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    final data = (response.data?['data'] ?? {}) as Map<String, dynamic>;

    T readField<T>(String primary, String fallback) {
      final value = data[primary] ?? data[fallback];
      if (value == null) {
        throw DioException(
          requestOptions: response.requestOptions,
          error: 'Campo $primary/$fallback no presente en la respuesta',
        );
      }
      return value as T;
    }

    final user = UserModel(
      id: readField<String>('id', 'Id'),
      name: readField<String>('name', 'Name'),
      email: readField<String>('email', 'Email'),
      role: readField<String>('role', 'Role'),
    );

    final tokens = AuthTokens(
      token: readField<String>('token', 'Token'),
      refreshToken: readField<String>('refreshToken', 'RefreshToken'),
    );

    return AuthResponse(user: user, tokens: tokens);
  }

  Future<AuthTokens> refreshToken({
    required String token,
    required String refreshToken,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/user/refresh',
      data: {
        'token': token,
        'refreshToken': refreshToken,
      },
    );

    final data = (response.data?['data'] ?? {}) as Map<String, dynamic>;

    return AuthTokens(
      token: data['token'] as String,
      refreshToken: data['refreshToken'] as String,
    );
  }
}


