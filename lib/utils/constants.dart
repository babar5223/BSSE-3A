class AuthConstants {
  AuthConstants._();

  static const int minPasswordLength = 8;
  static const int saltLengthBytes = 32;
  static const int sha256HashLengthBytes = 32;
  static const int pbkdf2Iterations = 600000;
  static const String passwordPepper = String.fromEnvironment('AUTH_PASSWORD_PEPPER');

  static const String emailRegex =
      r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';
  static const String uppercaseRegex = r'[A-Z]';
  static const String lowercaseRegex = r'[a-z]';
  static const String digitRegex = r'[0-9]';
  static const String specialCharRegex = r'[!@#$%^&*(),.?":{}|<>[\]_\-+=~`;/\\]';

  static const String invalidEmailMessage = 'Please enter a valid email address.';
  static const String weakPasswordMessage =
      'Password must be at least 8 characters and include uppercase, lowercase, number, and special character.';
  static const String passwordMismatchMessage =
      'Password and confirm password do not match.';
  static const String userExistsMessage = 'An account with this email already exists.';
  static const String userNotFoundMessage = 'No account found for this email.';
  static const String wrongPasswordMessage = 'Incorrect password. Please try again.';
  static const String networkErrorMessage = 'Network error. Please try again later.';
  static const String unknownErrorMessage = 'Something went wrong. Please try again.';
}
