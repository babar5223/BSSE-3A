import '../models/validation_error.dart';
import '../utils/constants.dart';

class PasswordValidator {
  PasswordValidator._();

  static ValidationError validate(String password) {
    if (password.isEmpty) {
      return const ValidationError(
        type: ValidationErrorType.passwordEmpty,
        message: 'Password is required.',
      );
    }

    final hasMinLength = password.length >= AuthConstants.minPasswordLength;
    final hasUpper = RegExp(AuthConstants.uppercaseRegex).hasMatch(password);
    final hasLower = RegExp(AuthConstants.lowercaseRegex).hasMatch(password);
    final hasDigit = RegExp(AuthConstants.digitRegex).hasMatch(password);
    final hasSpecial = RegExp(AuthConstants.specialCharRegex).hasMatch(password);

    if (!(hasMinLength && hasUpper && hasLower && hasDigit && hasSpecial)) {
      return const ValidationError(
        type: ValidationErrorType.weakPassword,
        message: AuthConstants.weakPasswordMessage,
      );
    }

    return const ValidationError(type: ValidationErrorType.none, message: '');
  }
}
