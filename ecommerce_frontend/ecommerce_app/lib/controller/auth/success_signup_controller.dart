import 'package:ecommerce_app/core/constant/routes.dart';

import 'package:get/get.dart';

abstract class SuccessSignupController extends GetxController {
  goToLogin();
}

class SuccessSignupControllerImplement extends SuccessSignupController {
  @override
  goToLogin() {
    Get.offAllNamed(AppRoute.login);
  }
}
