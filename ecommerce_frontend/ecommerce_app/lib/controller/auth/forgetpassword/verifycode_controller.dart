import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/core/class/status_request.dart';
import 'package:ecommerce_app/core/constant/routes.dart';
import 'package:ecommerce_app/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class VerifycodeController extends GetxController {
  Future<void> checkCode(String code);
  void goToResetCode();
}

class VerifycodeControllerImplement extends VerifycodeController {
  final crud = Crud();
  late final String email;
  final isLoading = false.obs;

  String _normalizeDigits(String s) {
    const ai = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    const pe = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    final b = StringBuffer();
    for (final r in s.runes) {
      final ch = String.fromCharCode(r);
      final i1 = ai.indexOf(ch);
      if (i1 != -1) {
        b.write(i1);
        continue;
      }
      final i2 = pe.indexOf(ch);
      if (i2 != -1) {
        b.write(i2);
        continue;
      }
      b.write(ch);
    }
    return b.toString().replaceAll(RegExp(r'[^0-9]'), '');
  }

  void _hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
  void _snack(String t, String m) {
    _hideKeyboard();
    Get.snackbar(t, m,
        snackPosition: SnackPosition.TOP, margin: const EdgeInsets.all(12));
  }

  @override
  Future<void> checkCode(String code) async {
    code = _normalizeDigits(code.trim());
    if (code.length != 6) {
      _snack("Verify", "Enter the 6-digit code.");
      return;
    }
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final res = await crud.postData(
          AppLink.verifyResetCode, {"email": email, "verifycode": code},
          withAuth: false);

      res.fold(
        (err) {
          isLoading.value = false;
          String msg = "Wrong or expired code";
          if (err == StatusRequest.offlineFailure) {
            msg = "No internet connection";
          }
          _snack("Verification failed", msg);
        },
        (data) {
          isLoading.value = false;
          final msg = data["message"]?.toString() ?? "Code verified";
          _snack("Verify", msg);
          // go forward carrying email + code (or reset_token if your backend returns one)
          Get.toNamed(AppRoute.resetPassword, arguments: {
            "email": email,
            "verifycode": code,
            // if backend returns reset_token: "reset_token": data["reset_token"]
          });
        },
      );
    } catch (e) {
      isLoading.value = false;
      _snack("Verification failed", e.toString());
    }
  }

  @override
  void goToResetCode() {
    // not used; we navigate only after successful checkCode
  }

  @override
  void onInit() {
    email = (Get.arguments?['email'] as String?)?.trim().toLowerCase() ?? "";
    super.onInit();
  }
}
