import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    required AuthStatus status,
    String? userId,
    String? userName,
    String? userEmail,
    String? role,
  }) = _AuthState;

  const AuthState._();

  factory AuthState.initial() => const AuthState(status: AuthStatus.unauthenticated);

  bool get isAuthenticated => status == AuthStatus.authenticated;
}



