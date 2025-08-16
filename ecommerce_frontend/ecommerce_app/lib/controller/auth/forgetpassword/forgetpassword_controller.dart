import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/core/class/status_request.dart';
import 'package:ecommerce_app/core/constant/routes.dart';
import 'package:ecommerce_app/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ForgetpasswordController extends GetxController {
  Future<void> checkMail();
  void goToVerifyCode();
}

class ForgetpasswordControllerImplement extends ForgetpasswordController {
  final crud = Crud();
  late TextEditingController emailController;
  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  void _hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
  void _snack(String t, String m) {
    _hideKeyboard();
    Get.snackbar(t, m,
        snackPosition: SnackPosition.TOP, margin: const EdgeInsets.all(12));
  }

  @override
  Future<void> checkMail() async {
    final form = formKey.currentState;
    if (form == null || !form.validate()) {
      _snack('Forget password', 'Please enter a valid email.');
      return;
    }

    if (isLoading.value) return;
    isLoading.value = true;

    final email = emailController.text.trim().toLowerCase();

    try {
      final res = await crud.postData(AppLink.forgetPassword, {"email": email});
      res.fold(
        (err) {
          isLoading.value = false;
          String msg = "Could not send verification code";
          if (err == StatusRequest.offlineFailure) {
            msg = "No internet connection";
          }
          _snack("Forget password", msg);
        },
        (data) {
          isLoading.value = false;
          final msg = data["message"]?.toString() ??
              "Verification code sent to your email";
          _snack("Forget password", msg);
          // pass the email forward
          Get.offNamed(AppRoute.verfyCode, arguments: {"email": email});
        },
      );
    } catch (e) {
      isLoading.value = false;
      _snack("Forget password", e.toString());
    }
  }

  @override
  void goToVerifyCode() => checkMail();

  @override
  void onInit() {
    emailController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
