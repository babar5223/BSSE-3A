import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';

import '../exceptions/auth_exception.dart';
import '../models/auth_response.dart';
import '../models/user.dart';
import '../models/validation_error.dart';
import '../repositories/auth_repository.dart';
import '../utils/constants.dart';
import '../validators/form_validator.dart';

class AuthService extends ChangeNotifier {
  AuthService({required AuthRepository repository}) : _repository = repository {
    _resolvePepper();
  }

  final AuthRepository _repository;
  AppUser? _currentUser;
  bool _isLoading = false;

  AppUser? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final validation = FormValidator.validateSignUp(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
    if (validation.hasError) {
      return _mapAuthException(_mapValidationError(validation));
    }

    _setLoading(true);
    try {
      final existingUser = await _repository.findByEmail(email.trim());
      if (existingUser != null) {
        throw const AuthException(
          type: AuthExceptionType.userAlreadyExists,
          message: AuthConstants.userExistsMessage,
        );
      }

      final salt = _generateSalt();
      final hash = _hashPassword(password, salt);
      final user = AppUser(
        email: email.trim(),
        passwordHash: hash,
        salt: salt,
        createdAt: DateTime.now(),
      );

      await _repository.saveUser(user);
      _currentUser = user;
      notifyListeners();

      return AuthResponse.success(message: 'Sign-up successful.', user: user);
    } on AuthException catch (error) {
      return _mapAuthException(error);
    } on AuthRepositoryNetworkException {
      return AuthResponse.failure(
        status: AuthStatus.networkError,
        message: AuthConstants.networkErrorMessage,
      );
    } on Exception {
      return AuthResponse.failure(
        status: AuthStatus.unknownError,
        message: AuthConstants.unknownErrorMessage,
      );
    } finally {
      _setLoading(false);
    }
  }

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    final validation = FormValidator.validateLogin(email: email, password: password);
    if (validation.hasError) {
      return _mapAuthException(_mapValidationError(validation));
    }

    _setLoading(true);
    try {
      final user = await _repository.findByEmail(email.trim());
      if (user == null) {
        throw const AuthException(
          type: AuthExceptionType.userNotFound,
          message: AuthConstants.userNotFoundMessage,
        );
      }

      final loginHash = _hashPassword(password, user.salt);
      if (loginHash != user.passwordHash) {
        throw const AuthException(
          type: AuthExceptionType.wrongPassword,
          message: AuthConstants.wrongPasswordMessage,
        );
      }

      _currentUser = user;
      notifyListeners();
      return AuthResponse.success(message: 'Login successful.', user: user);
    } on AuthException catch (error) {
      return _mapAuthException(error);
    } on AuthRepositoryNetworkException {
      return AuthResponse.failure(
        status: AuthStatus.networkError,
        message: AuthConstants.networkErrorMessage,
      );
    } on Exception {
      return AuthResponse.failure(
        status: AuthStatus.unknownError,
        message: AuthConstants.unknownErrorMessage,
      );
    } finally {
      _setLoading(false);
    }
  }

  AuthException _mapValidationError(ValidationError validation) {
    switch (validation.type) {
      case ValidationErrorType.invalidEmail:
      case ValidationErrorType.emailEmpty:
        return AuthException(
          type: AuthExceptionType.invalidEmail,
          message: _messageOrDefault(validation.message, AuthConstants.invalidEmailMessage),
        );
      case ValidationErrorType.weakPassword:
      case ValidationErrorType.passwordEmpty:
        return AuthException(
          type: AuthExceptionType.weakPassword,
          message: _messageOrDefault(validation.message, AuthConstants.weakPasswordMessage),
        );
      case ValidationErrorType.passwordsDoNotMatch:
      case ValidationErrorType.confirmPasswordEmpty:
        return AuthException(
          type: AuthExceptionType.passwordsDoNotMatch,
          message: validation.message,
        );
      case ValidationErrorType.none:
        return const AuthException(
          type: AuthExceptionType.unknown,
          message: AuthConstants.unknownErrorMessage,
        );
    }
  }

  AuthResponse _mapAuthException(AuthException error) {
    switch (error.type) {
      case AuthExceptionType.invalidEmail:
        return AuthResponse.failure(status: AuthStatus.invalidEmail, message: error.message);
      case AuthExceptionType.weakPassword:
        return AuthResponse.failure(status: AuthStatus.weakPassword, message: error.message);
      case AuthExceptionType.passwordsDoNotMatch:
        return AuthResponse.failure(
          status: AuthStatus.passwordsDoNotMatch,
          message: error.message,
        );
      case AuthExceptionType.userAlreadyExists:
        return AuthResponse.failure(status: AuthStatus.userAlreadyExists, message: error.message);
      case AuthExceptionType.userNotFound:
        return AuthResponse.failure(status: AuthStatus.userNotFound, message: error.message);
      case AuthExceptionType.wrongPassword:
        return AuthResponse.failure(status: AuthStatus.wrongPassword, message: error.message);
      case AuthExceptionType.network:
        return AuthResponse.failure(status: AuthStatus.networkError, message: error.message);
      case AuthExceptionType.unknown:
        return AuthResponse.failure(status: AuthStatus.unknownError, message: error.message);
    }
  }

  String _generateSalt() {
    final random = Random.secure();
    final values =
        List<int>.generate(AuthConstants.saltLengthBytes, (_) => random.nextInt(256));
    return base64UrlEncode(values);
  }

  String _hashPassword(String password, String salt) {
    final passwordBytes = utf8.encode('$password${_resolvePepper()}');
    final saltBytes = base64Url.decode(_normalizeBase64(salt));
    final derived = _pbkdf2HmacSha256(
      passwordBytes: passwordBytes,
      salt: saltBytes,
      iterations: AuthConstants.pbkdf2Iterations,
      keyLength: AuthConstants.sha256HashLengthBytes,
    );
    return base64UrlEncode(derived);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String _messageOrDefault(String message, String fallback) {
    return message.isEmpty ? fallback : message;
  }

  String _resolvePepper() {
    if (AuthConstants.passwordPepper.isEmpty) {
      throw const AuthException(
        type: AuthExceptionType.unknown,
        message: 'AUTH_PASSWORD_PEPPER environment variable is not configured.',
      );
    }
    return AuthConstants.passwordPepper;
  }

  List<int> _pbkdf2HmacSha256({
    required List<int> passwordBytes,
    required List<int> salt,
    required int iterations,
    required int keyLength,
  }) {
    const hashLength = AuthConstants.sha256HashLengthBytes;
    final blockCount = (keyLength / hashLength).ceil();
    final output = <int>[];

    for (var blockIndex = 1; blockIndex <= blockCount; blockIndex++) {
      var u = _hmacSha256(passwordBytes, [...salt, ..._int32Be(blockIndex)]);
      final t = Uint8List.fromList(u);

      for (var i = 1; i < iterations; i++) {
        u = _hmacSha256(passwordBytes, u);
        for (var j = 0; j < t.length; j++) {
          t[j] ^= u[j];
        }
      }
      output.addAll(t);
    }

    return output.sublist(0, keyLength);
  }

  List<int> _hmacSha256(List<int> key, List<int> data) {
    return Hmac(sha256, key).convert(data).bytes;
  }

  List<int> _int32Be(int value) {
    return <int>[
      (value >> 24) & 0xff,
      (value >> 16) & 0xff,
      (value >> 8) & 0xff,
      value & 0xff,
    ];
  }

  String _normalizeBase64(String value) {
    final missingPadding = value.length % 4;
    if (missingPadding == 0) {
      return value;
    }
    return value.padRight(value.length + (4 - missingPadding), '=');
  }
}
