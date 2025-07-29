import 'package:ecommerce_app/core/constant/apptheme.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalController extends GetxController {
  Locale? language;

  MyServices myServices = Get.find();

  ThemeData themeApp = themeEnFr;

  changeLang(String langCode) {
    Locale locale = Locale(langCode);
    myServices.sharedPreferences.setString("lang", langCode);
    themeApp = (langCode == "en" || langCode == "fr") ? themeEnFr : themeAr;
    Get.changeTheme(themeApp);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    String? sharedPrefLang = myServices.sharedPreferences.getString("lang");

    if (sharedPrefLang == "ar") {
      language = const Locale("ar");
      themeApp = themeAr;
    } else if (sharedPrefLang == "en") {
      language = const Locale("en");
      themeApp = themeEnFr;
    } else if (sharedPrefLang == "fr") {
      language = const Locale("fr");
      themeApp = themeEnFr;
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
      themeApp = themeEnFr;
    }
    super.onInit();
  }
}
