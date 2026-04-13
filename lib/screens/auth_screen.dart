import 'package:flutter/material.dart';

import '../repositories/auth_repository.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final AuthService _authService;

  @override
  void initState() {
    super.initState();
    _authService = AuthService(repository: InMemoryAuthRepository());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Authentication'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Login'),
              Tab(text: 'Sign Up'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LoginScreen(authService: _authService),
            SignupScreen(authService: _authService),
          ],
        ),
      ),
    );
  }
}
