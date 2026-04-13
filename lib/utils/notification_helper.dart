import 'package:flutter/material.dart';

class NotificationHelper {
  NotificationHelper._();

  static void showSuccess(BuildContext context, String message) {
    _show(context, message, Colors.green.shade700);
  }

  static void showError(BuildContext context, String message) {
    _show(context, message, Colors.red.shade700);
  }

  static void _show(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}
