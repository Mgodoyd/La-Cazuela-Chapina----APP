import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/auth_state.dart';
import '../../data/auth_repository.dart';
import '../../data/auth_providers.dart';

class AuthController extends StateNotifier<AuthState> {
  AuthController(this._repo) : super(AuthState.initial());

  final AuthRepository _repo;

  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(status: AuthStatus.unknown); 
    try {
      final resp = await _repo.login(email: email, password: password);
      state = state.copyWith(
        status: AuthStatus.authenticated,
        userId: resp.user.id,
        userName: resp.user.name,
        userEmail: resp.user.email,
        role: resp.user.role,
      );
    } catch (e) {
      state = const AuthState(status: AuthStatus.unauthenticated);
      rethrow;
    }
  }

  void setAuthenticated({String? id, String? name, String? email, String? role}) {
    state = state.copyWith(
      status: AuthStatus.authenticated,
      userId: id ?? state.userId,
      userName: name ?? state.userName,
      userEmail: email ?? state.userEmail,
      role: role ?? state.role,
    );
  }

  void setUnauthenticated() {
    state = const AuthState(status: AuthStatus.unauthenticated);
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return AuthController(repo);
});

