import 'package:ecommerce_app/core/constant/routes.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyMiddleware extends GetMiddleware {
  MyServices myServices = Get.find();
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final token = myServices.sharedPreferences.getString("token");
    final onBoarding = myServices.sharedPreferences.getString("onBoarding");

    // If first time, go to onboarding
    if (onBoarding != "1") {
      return const RouteSettings(name: AppRoute.language);
    }

    // If token exists → go to Home, else Login
    if (token != null && token.isNotEmpty) {
      return const RouteSettings(name: AppRoute.home);
    } else {
      return const RouteSettings(name: AppRoute.login);
    }
  }
}
