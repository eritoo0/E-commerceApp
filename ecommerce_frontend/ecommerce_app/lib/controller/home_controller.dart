import 'package:ecommerce_app/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomeController extends GetxController {}

class HomeControllerImplement extends HomeController {
  MyServices myServices = Get.find();

  late TextEditingController searchController;

  String? username;

  initialData() {
    username = myServices.sharedPreferences.getString("username"); // for test
  }

  @override
  void onInit() {
    initialData();
    searchController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void onSearch(String query) {
    print(searchController.text);
  }
}
