import 'package:ecommerce_app/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/data/datasource/static/static.dart';

class OnBoardingController extends GetxController {
  PageController pageController = PageController();
  int currentPage = 0;

  void nextPage() {
    if (currentPage < onBoardingList.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    } else {
      //print("Finished onboarding");
      Get.offAllNamed(AppRoute.login); // or navigation
    }
  }

  void skip() {
    //print("Skipped onboarding");
    Get.offAllNamed(AppRoute.login);
  }

  void onPageChanged(int index) {
    currentPage = index;
    update(); // this notifies GetBuilder
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
