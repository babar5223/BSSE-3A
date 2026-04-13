enum AuthExceptionType {
  invalidEmail,
  weakPassword,
  passwordsDoNotMatch,
  userAlreadyExists,
  userNotFound,
  wrongPassword,
  network,
  unknown,
}

class AuthException implements Exception {
  const AuthException({required this.type, required this.message});

  final AuthExceptionType type;
  final String message;

  @override
  String toString() => 'AuthException(type: $type, message: $message)';
}
