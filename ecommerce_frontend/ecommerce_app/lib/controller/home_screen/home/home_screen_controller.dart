import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomeScreenController extends GetxController {
  void changeTab(int index);
  onSearch(String query);
}

class HomeScreenControllerImplement extends HomeScreenController {
  final RxInt currentIndex = 0.obs;
  late TextEditingController searchController;

  @override
  void changeTab(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
  }

  @override
  void onClose() {
    searchController.dispose();
    searchController.clear();
    super.onClose();
  }

  @override
  void onSearch(String query) {
    print(searchController.text);
  }
}
