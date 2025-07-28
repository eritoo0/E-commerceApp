import 'package:ecommerce_app/core/constant/routes.dart';

import 'package:get/get.dart';

abstract class SuccessResetpasswordController extends GetxController {
  goToLogin();
}

class SuccessResetpasswordControllerImplement
    extends SuccessResetpasswordController {
  @override
  goToLogin() {
    Get.offAllNamed(AppRoute.login);
  }
}
