import 'package:ecommerce_app/core/class/status_request.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/datasource/remote/home_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomeController extends GetxController {
  initialData();
  getCategories();
  onSearch(String query);
}

class HomeControllerImplement extends HomeController {
  MyServices myServices = Get.find();

  HomeData homeData = HomeData(Get.find());

  late TextEditingController searchController;

  String? username;
  List categories = [];

  StatusRequest statusRequest = StatusRequest.none;
  @override
  initialData() {
    username = myServices.sharedPreferences.getString("username"); // for test
  }

  @override
  void onInit() {
    initialData();
    searchController = TextEditingController();
    getCategories(); // fectch
    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  @override
  void onSearch(String query) {
    print(searchController.text);
  }

  getCategories() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await homeData.getCategories();

    if (response is StatusRequest) {
      // means it's an error
      statusRequest = response;
    } else {
      // success case
      statusRequest = StatusRequest.success;
      categories = response; // safe: list of categories
    }

    update();
  }
}
