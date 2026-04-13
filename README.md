# BSSE-3A

Flutter authentication backend structure added under `lib/` with:

- `models/`: `auth_response.dart`, `user.dart`, `validation_error.dart`
- `validators/`: `email_validator.dart`, `password_validator.dart`, `form_validator.dart`
- `repositories/`: `auth_repository.dart` (in-memory repo)
- `services/`: `auth_service.dart` (business logic + state management)
- `exceptions/`: `auth_exception.dart`
- `utils/`: `constants.dart`, `notification_helper.dart`
- `screens/`: `login_screen.dart`, `signup_screen.dart`, `auth_screen.dart`

## Switch-based error handling

### Login switch cases
- `invalidEmail` → invalid email notification
- `userNotFound` → user not found notification
- `wrongPassword` → wrong password notification
- `networkError` → network error notification
- fallback cases → generic error notification

### Sign-up switch cases
- `invalidEmail` → invalid email notification
- `weakPassword` → password requirements notification
- `passwordsDoNotMatch` → mismatch notification
- `userAlreadyExists` → account exists notification
- `networkError` → network error notification
- fallback cases → generic error notification

## Notification trigger
Both screens call `NotificationHelper.showError(...)` / `NotificationHelper.showSuccess(...)` in each `switch` case when button actions complete.

## Note
`AuthService` uses PBKDF2-HMAC-SHA256 for password hashing (`package:crypto/crypto.dart`). Add `crypto` in your Flutter project's `pubspec.yaml` if not already present.
Set a runtime/app-specific pepper with `--dart-define=AUTH_PASSWORD_PEPPER=your-secret-pepper` (required by `AuthService`).
