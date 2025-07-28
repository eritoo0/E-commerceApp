import 'package:ecommerce_app/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ForgetpasswordController extends GetxController {
  checkMail();
  goToVerifyCode();
}

class ForgetpasswordControllerImplement extends ForgetpasswordController {
  late TextEditingController emailController;

  @override
  goToVerifyCode() {
    Get.toNamed(AppRoute.verfyCode);
  }

  @override
  checkMail() {
    throw UnimplementedError();
  }

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
