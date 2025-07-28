import 'package:ecommerce_app/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CheckEmailController extends GetxController {
  checkMail();
  goToSuccesSignUP();
}

class CheckEmailControllerImplement extends CheckEmailController {
  late TextEditingController emailController;

  @override
  goToSuccesSignUP() {
    Get.toNamed(AppRoute.successSignUp);
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
