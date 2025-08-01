import 'package:ecommerce_app/controller/auth/forgetpassword/forgetpassword_controller.dart';
import 'package:ecommerce_app/controller/auth/forgetpassword/resetpassword_controller.dart';
import 'package:ecommerce_app/controller/auth/forgetpassword/verifycode_controller.dart';
import 'package:ecommerce_app/controller/auth/login_controller.dart';
import 'package:ecommerce_app/controller/auth/signup_controller.dart';
import 'package:get/get.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginControllerImplement>(() => LoginControllerImplement(),
        fenix: true);
    Get.lazyPut<SignUpControllerImplement>(() => SignUpControllerImplement(),
        fenix: true);
    Get.lazyPut<ForgetpasswordControllerImplement>(
        () => ForgetpasswordControllerImplement(),
        fenix: true);
    Get.lazyPut<ResetpasswordControllerImplement>(
        () => ResetpasswordControllerImplement(),
        fenix: true);
    Get.lazyPut<VerifycodeControllerImplement>(
        () => VerifycodeControllerImplement(),
        fenix: true);
  }
}
