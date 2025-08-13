import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/core/class/status_request.dart';
import 'package:ecommerce_app/core/constant/routes.dart';
import 'package:ecommerce_app/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class VerifycodeSignupController extends GetxController {
  Future<void> checkCode({required String code});
  Future<void> resendCode();
  void goToSuccessSignUP();
}

class VerifycodeSignupControllerImplement extends VerifycodeSignupController {
  final crud = Crud();

  /// email passed from the signup page
  late final String email;

  /// code input from the user
  late TextEditingController codeController;

  final isLoading = false.obs;
  // Optional: convert Arabic/Persian digits → ASCII and strip non‑digits
  String _normalizeDigits(String s) {
    const ai = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    const pe = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    final buf = StringBuffer();
    for (final r in s.runes) {
      final ch = String.fromCharCode(r);
      final i1 = ai.indexOf(ch);
      if (i1 != -1) {
        buf.write(i1);
        continue;
      }
      final i2 = pe.indexOf(ch);
      if (i2 != -1) {
        buf.write(i2);
        continue;
      }
      buf.write(ch);
    }
    return buf.toString().replaceAll(RegExp(r'[^0-9]'), '');
  }

  @override
  void onInit() {
    super.onInit();
    codeController = TextEditingController();
    // grab email from previous screen (we passed it in signup controller)
    email =
        (Get.arguments != null ? Get.arguments['email'] as String? : null) ??
            "";
  }

  @override
  void onClose() {
    codeController.dispose();
    super.onClose();
  }

  @override
  Future<void> checkCode({required String code}) async {
    if (email.isEmpty) {
      Get.snackbar("Verify", "Missing email. Go back and sign up again.",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // sanitize input
    code = _normalizeDigits(code.trim());

    if (code.length != 6) {
      Get.snackbar("Verify", "Enter the 6‑digit code.",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final res = await crud.postData(AppLink.verify, {
        "email": email,
        "verifycode": code,
      });

      res.fold(
        (err) {
          isLoading.value = false;
          String msg = "Something went wrong";
          if (err == StatusRequest.offlineFailure) {
            msg = "No internet connection";
          } else if (err == StatusRequest.serverFailure) {
            msg = "Server error";
          } else if (err == StatusRequest.failure) msg = "Unexpected error";
          Get.snackbar("Verification failed", msg,
              snackPosition: SnackPosition.BOTTOM);
        },
        (data) {
          isLoading.value = false;
          final msg = data["message"]?.toString() ?? "Account verified";
          Get.snackbar("Success", msg, snackPosition: SnackPosition.BOTTOM);
          Future.delayed(const Duration(milliseconds: 600), goToSuccessSignUP);
        },
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Verification failed", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Future<void> resendCode() async {
    if (email.isEmpty) {
      Get.snackbar("Resend code", "Missing email.",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final res = await crud.postData(AppLink.resendCode, {
        "email": email,
      });

      res.fold(
        (err) {
          isLoading.value = false;
          String msg = "Could not resend code";
          if (err == StatusRequest.offlineFailure) {
            msg = "No internet connection";
          }
          Get.snackbar("Resend code", msg, snackPosition: SnackPosition.BOTTOM);
        },
        (data) {
          isLoading.value = false;
          final msg = data["message"]?.toString() ?? "Verification code resent";
          Get.snackbar("Resend code", msg, snackPosition: SnackPosition.BOTTOM);
        },
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Resend code", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void goToSuccessSignUP() {
    Get.offAllNamed(AppRoute.successSignUp);
  }
}
