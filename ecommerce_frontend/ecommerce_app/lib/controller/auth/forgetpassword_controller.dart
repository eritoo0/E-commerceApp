import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ForgetpasswordController extends GetxController {
  goToVerifyCode();
}

class ForgetpasswordControllerImplement extends ForgetpasswordController {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  goToVerifyCode() {}

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
