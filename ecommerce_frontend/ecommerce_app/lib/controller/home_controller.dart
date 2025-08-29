import 'package:ecommerce_app/core/services/services.dart';
import 'package:get/get.dart';

abstract class HomeController extends GetxController {}

class HomeControllerImplement extends HomeController {
  MyServices myServices = Get.find();

  String? username;

  initialData() {
    username = myServices.sharedPreferences.getString("username"); // for test
  }

  @override
  void onInit() {
    initialData();
    super.onInit();
  }
}
