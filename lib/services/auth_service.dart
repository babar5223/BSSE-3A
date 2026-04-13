import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';

import '../exceptions/auth_exception.dart';
import '../models/auth_response.dart';
import '../models/user.dart';
import '../models/validation_error.dart';
import '../repositories/auth_repository.dart';
import '../utils/constants.dart';
import '../validators/form_validator.dart';

class AuthService extends ChangeNotifier {
  AuthService({required AuthRepository repository}) : _repository = repository;

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
    _setLoading(true);
    try {
      final validation = FormValidator.validateSignUp(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
      if (validation.hasError) {
        throw _mapValidationError(validation);
      }

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
    } on Exception {
      return AuthResponse.failure(
        status: AuthStatus.networkError,
        message: AuthConstants.networkErrorMessage,
      );
    } finally {
      _setLoading(false);
    }
  }

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    try {
      final validation = FormValidator.validateLogin(email: email, password: password);
      if (validation.hasError) {
        throw _mapValidationError(validation);
      }

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
    } on Exception {
      return AuthResponse.failure(
        status: AuthStatus.networkError,
        message: AuthConstants.networkErrorMessage,
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
          message: validation.message.isEmpty
              ? AuthConstants.invalidEmailMessage
              : validation.message,
        );
      case ValidationErrorType.weakPassword:
      case ValidationErrorType.passwordEmpty:
        return AuthException(
          type: AuthExceptionType.weakPassword,
          message:
              validation.message.isEmpty ? AuthConstants.weakPasswordMessage : validation.message,
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
    final values = List<int>.generate(16, (_) => random.nextInt(256));
    return base64UrlEncode(values);
  }

  String _hashPassword(String password, String salt) {
    var result = '$salt|$password|${AuthConstants.passwordPepper}';
    for (var i = 0; i < 1000; i++) {
      result = base64UrlEncode(utf8.encode(result));
    }
    return result;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
