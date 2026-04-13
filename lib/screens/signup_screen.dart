import 'package:flutter/material.dart';

import '../models/auth_response.dart';
import '../services/auth_service.dart';
import '../utils/constants.dart';
import '../utils/notification_helper.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key, required this.authService});

  final AuthService authService;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _onSignupPressed() async {
    final response = await widget.authService.signUp(
      email: _emailController.text,
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
    );

    switch (response.status) {
      case AuthStatus.success:
        NotificationHelper.showSuccess(context, response.message);
        break;
      case AuthStatus.invalidEmail:
        NotificationHelper.showError(context, response.message);
        break;
      case AuthStatus.weakPassword:
        NotificationHelper.showError(context, response.message);
        break;
      case AuthStatus.passwordsDoNotMatch:
        NotificationHelper.showError(context, response.message);
        break;
      case AuthStatus.userAlreadyExists:
        NotificationHelper.showError(context, response.message);
        break;
      case AuthStatus.networkError:
        NotificationHelper.showError(context, response.message);
        break;
      default:
        NotificationHelper.showError(
          context,
          response.message.isEmpty ? AuthConstants.unknownErrorMessage : response.message,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.authService,
      builder: (context, _) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Confirm Password'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: widget.authService.isLoading ? null : _onSignupPressed,
                child: widget.authService.isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Sign Up'),
              ),
            ],
          ),
        );
      },
    );
  }
}
