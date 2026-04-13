enum ValidationErrorType {
  none,
  emailEmpty,
  invalidEmail,
  passwordEmpty,
  weakPassword,
  confirmPasswordEmpty,
  passwordsDoNotMatch,
}

class ValidationError {
  const ValidationError({required this.type, required this.message});

  final ValidationErrorType type;
  final String message;

  bool get hasError => type != ValidationErrorType.none;
}
