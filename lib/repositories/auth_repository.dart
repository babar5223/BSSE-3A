import '../models/user.dart';

abstract class AuthRepository {
  Future<AppUser?> findByEmail(String email);

  Future<void> saveUser(AppUser user);

  void setSimulatedNetworkFailure(bool value);
}

class InMemoryAuthRepository implements AuthRepository {
  final Map<String, AppUser> _users = <String, AppUser>{};
  bool _simulateNetworkFailure = false;

  @override
  Future<AppUser?> findByEmail(String email) async {
    _throwIfNetworkError();
    return _users[email.toLowerCase()];
  }

  @override
  Future<void> saveUser(AppUser user) async {
    _throwIfNetworkError();
    _users[user.email.toLowerCase()] = user;
  }

  @override
  void setSimulatedNetworkFailure(bool value) {
    _simulateNetworkFailure = value;
  }

  void _throwIfNetworkError() {
    if (_simulateNetworkFailure) {
      throw const _NetworkFailure();
    }
  }
}

class _NetworkFailure implements Exception {
  const _NetworkFailure();
}
