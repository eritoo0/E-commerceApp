import 'package:ecommerce_app/core/constant/color.dart';
import 'package:ecommerce_app/view/screen/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageButton extends StatelessWidget {
  final String label;
  final Locale locale;

  const LanguageButton({super.key, required this.label, required this.locale});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Make it full width inside Column
      child: ElevatedButton(
        onPressed: () {
          Get.updateLocale(locale);
          Get.off(const OnBoarding());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorApp.primaryColor, // Primary blue color
          foregroundColor: Colors.white,
          elevation: 4,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: const Size(0, 56), // height 56, width fills parent
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
