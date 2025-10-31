import 'dart:convert';

import 'package:cazuela_chapina_app/src/core/storage/hive_service.dart';
import 'package:cazuela_chapina_app/src/core/storage/secure_storage_service.dart';
import 'auth_api.dart';
import 'models/auth_response.dart';
import 'models/user_model.dart';

class AuthRepository {
  AuthRepository(
    this._api,
    this._secureStorage,
    this._hiveService,
  );

  final AuthApi _api;
  final SecureStorageService _secureStorage;
  final HiveService _hiveService;

  static const _sessionBox = 'session_box';
  static const _userKey = 'current_user';

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await _api.login(email: email, password: password);

    await _secureStorage.saveTokens(
      accessToken: response.tokens.token,
      refreshToken: response.tokens.refreshToken,
    );

    final box = await _hiveService.openBox<String>(_sessionBox);
    await box.put(_userKey, jsonEncode(response.user.toJson()));

    return response;
  }

  Future<UserModel?> getCachedUser() async {
    final box = await _hiveService.openBox<String>(_sessionBox);
    final data = box.get(_userKey);

    if (data == null) {
      return null;
    }

    return UserModel.fromJson(
      jsonDecode(data) as Map<String, dynamic>,
    );
  }

  Future<void> clearSession() async {
    await _secureStorage.clearTokens();
    final box = await _hiveService.openBox<String>(_sessionBox);
    await box.delete(_userKey);
  }
}


