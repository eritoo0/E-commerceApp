import 'package:ecommerce_app/core/constant/routes.dart';
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
  @override
  signUp() {
    Get.offNamed(AppRoute.checkEmail);
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
