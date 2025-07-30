import 'package:ecommerce_app/core/constant/routes.dart';
import 'package:get/get.dart';

abstract class VerifycodeSignupController extends GetxController {
  checkCode();
  goToSuccessSignUP();
}

class VerifycodeSignupControllerImplement extends VerifycodeSignupController {
  late String verificationCode;
  @override
  goToSuccessSignUP() {
    Get.toNamed(AppRoute.successSignUp);
  }

  @override
  checkCode() {
    throw UnimplementedError();
  }
}
