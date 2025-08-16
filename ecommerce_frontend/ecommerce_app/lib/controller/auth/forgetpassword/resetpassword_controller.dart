import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/core/class/status_request.dart';
import 'package:ecommerce_app/core/constant/routes.dart';
import 'package:ecommerce_app/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ResetpasswordController extends GetxController {
  Future<void> submit();
  void goToSuccessResetpass();
  void showPassword();
}

class ResetpasswordControllerImplement extends ResetpasswordController {
  final crud = Crud();

  late TextEditingController passwordController;
  late TextEditingController repasswordController;

  late final String email;
  late final String verifycode; // or reset_token if your backend uses that

  final formKey = GlobalKey<FormState>();
  bool isShowPass = true;
  final isLoading = false.obs;

  @override
  void showPassword() {
    isShowPass = !isShowPass;
    update();
  }

  void _hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
  void _snack(String t, String m) {
    _hideKeyboard();
    Get.snackbar(t, m,
        snackPosition: SnackPosition.TOP, margin: const EdgeInsets.all(12));
  }

  @override
  Future<void> submit() async {
    final form = formKey.currentState;
    if (form == null || !form.validate()) {
      _snack("Reset password", "Please fix the errors and try again.");
      return;
    }

    final p1 = passwordController.text;
    final p2 = repasswordController.text;
    if (p1 != p2) {
      _snack("Reset password", "Passwords do not match.");
      return;
    }
    if (p1.length < 6) {
      _snack("Reset password", "Password must be at least 6 characters.");
      return;
    }

    if (isLoading.value) return;
    isLoading.value = true;
    update();

    try {
      final res = await crud.postData(AppLink.resetPassword, {
        "email": email,
        "verifycode": verifycode, // or "reset_token": resetToken
        "new_password": p1,
      });

      res.fold(
        (err) {
          isLoading.value = false;
          update();
          String msg = "Could not reset password";
          if (err == StatusRequest.offlineFailure) {
            msg = "No internet connection";
          }
          _snack("Reset password", msg);
        },
        (data) {
          isLoading.value = false;
          update();
          final msg = data["message"]?.toString() ?? "Password updated";
          _snack("Reset password", msg);
          goToSuccessResetpass();
        },
      );
    } catch (e) {
      isLoading.value = false;
      update();
      _snack("Reset password", e.toString());
    }
  }

  @override
  void goToSuccessResetpass() {
    Get.offAllNamed(AppRoute.successResetpassword);
  }

  @override
  void onInit() {
    passwordController = TextEditingController();
    repasswordController = TextEditingController();
    email = (Get.arguments?['email'] as String?)?.trim().toLowerCase() ?? "";
    verifycode = (Get.arguments?['verifycode'] as String?) ?? "";
    // if you switch to tokens later:
    // resetToken = (Get.arguments?['reset_token'] as String?) ?? "";
    super.onInit();
  }

  @override
  void dispose() {
    passwordController.dispose();
    repasswordController.dispose();
    super.dispose();
  }
}
