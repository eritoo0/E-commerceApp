import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/core/class/status_request.dart';

import 'package:ecommerce_app/core/constant/routes.dart';
import 'package:ecommerce_app/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SignUpController extends GetxController {
  signUp();
  goToLogin();
}

class SignUpControllerImplement extends SignUpController {
  late TextEditingController fullNameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final crud = Crud();
  bool isShowPass = true;
  final isLoading = false.obs;
  showPassword() {
    isShowPass = isShowPass == true ? false : true;
    update();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  signUp() async {
    var formdata = formKey.currentState;
    if (formdata!.validate()) {
      // print("validate");

      // Optional: prevent double taps
      if (isLoading.value) return;

      isLoading.value = true;
      try {
        final username = fullNameController.text.trim();
        final email = emailController.text.trim();
        final password = passwordController.text;
        final phone = phoneController.text.trim();

        final res = await crud.postData(AppLink.signup, {
          "username": username,
          "email": email,
          "password": password,
          "users_phone": phone,
        });

        res.fold(
          (err) {
            isLoading.value = false;
            // Show a friendly message based on the error
            String message = "Something went wrong";
            if (err == StatusRequest.offlineFailure) {
              message = "No internet connection";
            } else if (err == StatusRequest.serverFailure) {
              message = "Server error";
            } else if (err == StatusRequest.failure) {
              message = "Unexpected error";
            }
            Get.snackbar("Signup failed", message,
                snackPosition: SnackPosition.BOTTOM);
          },
          (data) {
            isLoading.value = false;

            // Optional: read backend message
            final msg = data["message"] ?? "User created";
            Get.snackbar("Success", msg, snackPosition: SnackPosition.BOTTOM);
            // print("Signup success branch. Data: $data");

            // Navigate ONLY on success
            Get.offNamed(AppRoute.verifyCodeSignUp, arguments: {
              "email": email, // pass it so the verify screen can prefill
            });
          },
        );
      } catch (e) {
        isLoading.value = false;
        Get.snackbar("Signup failed", e.toString(),
            snackPosition: SnackPosition.BOTTOM);
      }
    }
    //  else {
    //    print("Not Valide");
    // }
  }

  @override
  goToLogin() {
    Get.offAllNamed(AppRoute.login);
  }

  @override
  void onInit() {
    fullNameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
