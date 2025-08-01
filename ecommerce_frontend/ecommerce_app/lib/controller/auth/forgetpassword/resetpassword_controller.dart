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
  bool isShowPass = true;
  showPassword() {
    isShowPass = isShowPass == true ? false : true;
    update();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  goToSuccessResetpass() {
    var formdata = formKey.currentState;
    if (formdata!.validate()) {
      print("validate");
      Get.offAllNamed(AppRoute.successResetpassword);
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
