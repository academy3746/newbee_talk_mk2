import 'package:get/get.dart';

/// Customized Material Snackbar
class AppSnackbar {
  final String msg;

  AppSnackbar({required this.msg});

  void showSnackbar() {
    Get.showSnackbar(
      GetSnackBar(
        message: msg,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
