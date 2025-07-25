import 'package:ecommerce_app/core/constant/color.dart';
import 'package:ecommerce_app/core/localization/translation.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/routes.dart';
import 'package:ecommerce_app/view/screen/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: MyTranslation(),
      title: 'Flutter Demo',
      theme: ThemeData(
          textTheme: const TextTheme(
        headlineMedium: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: ColorApp.titleFont),
        bodyMedium: TextStyle(
            height: 2,
            color: ColorApp.bodyFont,
            fontWeight: FontWeight.w600,
            fontSize: 16),
      )),
      home: const OnBoarding(),
      routes: routes,
    );
  }
}
