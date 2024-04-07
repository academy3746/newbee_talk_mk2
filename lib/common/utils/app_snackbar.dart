import 'package:flutter/material.dart';

class AppSnackbar {
  final String msg;

  AppSnackbar({required this.msg});

  void showSnackbar(BuildContext context) {
    SnackBar snackbar = SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
