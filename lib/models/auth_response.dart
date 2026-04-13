import 'user.dart';

enum AuthStatus {
  success,
  invalidEmail,
  weakPassword,
  passwordsDoNotMatch,
  userAlreadyExists,
  userNotFound,
  wrongPassword,
  networkError,
  unknownError,
}

class AuthResponse {
  const AuthResponse({
    required this.status,
    required this.message,
    this.user,
  });

  final AuthStatus status;
  final String message;
  final AppUser? user;

  bool get isSuccess => status == AuthStatus.success;

  factory AuthResponse.success({required String message, required AppUser user}) {
    return AuthResponse(status: AuthStatus.success, message: message, user: user);
  }

  factory AuthResponse.failure({required AuthStatus status, required String message}) {
    return AuthResponse(status: status, message: message);
  }
}
