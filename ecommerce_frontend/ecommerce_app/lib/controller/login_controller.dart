import 'package:get/get.dart';

class LoginController extends GetxController {
  var rememberMe = false.obs;

  void toggleRememberMe(bool? value) {
    rememberMe.value = value!;
  }
}
