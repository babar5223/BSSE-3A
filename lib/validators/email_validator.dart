import '../models/validation_error.dart';
import '../utils/constants.dart';

class EmailValidator {
  EmailValidator._();

  static ValidationError validate(String email) {
    if (email.trim().isEmpty) {
      return const ValidationError(
        type: ValidationErrorType.emailEmpty,
        message: 'Email is required.',
      );
    }

    final isValid = RegExp(AuthConstants.emailRegex).hasMatch(email.trim());
    if (!isValid) {
      return const ValidationError(
        type: ValidationErrorType.invalidEmail,
        message: AuthConstants.invalidEmailMessage,
      );
    }

    return const ValidationError(type: ValidationErrorType.none, message: '');
  }
}
