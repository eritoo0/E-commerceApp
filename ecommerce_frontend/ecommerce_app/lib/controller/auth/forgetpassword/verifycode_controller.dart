import 'package:ecommerce_app/core/constant/routes.dart';
import 'package:get/get.dart';

abstract class VerifycodeController extends GetxController {
  checkCode();
  goToResetCode();
}

class VerifycodeControllerImplement extends VerifycodeController {
  late String verificationCode;
  @override
  goToResetCode() {
    Get.toNamed(AppRoute.resetPassword);
  }

  @override
  checkCode() {
    throw UnimplementedError();
  }
}
