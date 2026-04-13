import '../models/validation_error.dart';
import '../utils/constants.dart';
import 'email_validator.dart';
import 'password_validator.dart';

class FormValidator {
  FormValidator._();

  static ValidationError validateSignUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    final emailResult = EmailValidator.validate(email);
    if (emailResult.hasError) {
      return emailResult;
    }

    final passwordResult = PasswordValidator.validate(password);
    if (passwordResult.hasError) {
      return passwordResult;
    }

    if (confirmPassword.isEmpty) {
      return const ValidationError(
        type: ValidationErrorType.confirmPasswordEmpty,
        message: 'Confirm password is required.',
      );
    }

    if (password != confirmPassword) {
      return const ValidationError(
        type: ValidationErrorType.passwordsDoNotMatch,
        message: AuthConstants.passwordMismatchMessage,
      );
    }

    return const ValidationError(type: ValidationErrorType.none, message: '');
  }

  static ValidationError validateLogin({
    required String email,
    required String password,
  }) {
    final emailResult = EmailValidator.validate(email);
    if (emailResult.hasError) {
      return emailResult;
    }

    if (password.isEmpty) {
      return const ValidationError(
        type: ValidationErrorType.passwordEmpty,
        message: 'Password is required.',
      );
    }

    return const ValidationError(type: ValidationErrorType.none, message: '');
  }
}
