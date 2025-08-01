import 'package:ecommerce_app/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ForgetpasswordController extends GetxController {
  checkMail();
  goToVerifyCode();
}

class ForgetpasswordControllerImplement extends ForgetpasswordController {
  late TextEditingController emailController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  goToVerifyCode() {
    var formdata = formKey.currentState;
    if (formdata!.validate()) {
      print("validate");
      Get.offNamed(AppRoute.verfyCode);
    } else {
      print("Not Valide");
    }
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
