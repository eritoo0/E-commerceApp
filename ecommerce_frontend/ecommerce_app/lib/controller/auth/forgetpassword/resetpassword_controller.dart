import 'package:ecommerce_app/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ResetpasswordController extends GetxController {
  checkMail();
  goToSuccessResetpass();
}

class ResetpasswordControllerImplement extends ResetpasswordController {
  late TextEditingController passwordController;
  late TextEditingController repasswordController;

  @override
  goToSuccessResetpass() {
    Get.offAllNamed(AppRoute.successResetpassword);
  }

  @override
  checkMail() {
    throw UnimplementedError();
  }

  @override
  void onInit() {
    passwordController = TextEditingController();
    repasswordController = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    passwordController.dispose();
    repasswordController.dispose();

    super.dispose();
  }
}
