import '../models/user.dart';

abstract class AuthRepository {
  Future<AppUser?> findByEmail(String email);

  Future<void> saveUser(AppUser user);
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

  void setSimulatedNetworkFailure(bool value) {
    assert(() {
      _simulateNetworkFailure = value;
      return true;
    }());
  }

  void _throwIfNetworkError() {
    if (_simulateNetworkFailure) {
      throw const AuthRepositoryNetworkException();
    }
  }
}

class AuthRepositoryNetworkException implements Exception {
  const AuthRepositoryNetworkException();
}
