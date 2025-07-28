import 'package:ecommerce_app/controller/auth/success_signup_controller.dart';
import 'package:ecommerce_app/core/constant/color.dart';
import 'package:ecommerce_app/view/widget/auth/authbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessSignup extends StatelessWidget {
  const SuccessSignup({super.key});

  @override
  Widget build(BuildContext context) {
    SuccessSignupControllerImplement controller =
        SuccessSignupControllerImplement();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: ColorApp.primaryColor,
                  size: 120,
                ),
                const SizedBox(height: 24),
                Text(
                  "signup_success_title".tr,
                  style: const TextStyle(
                    // adding to theme
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'signup_success_subtitle'.tr,
                  style: const TextStyle(
                    // adding to theme
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 36),
                SizedBox(
                  width: double.infinity,
                  child: AuthButton(
                      label: 'go_to_home'.tr,
                      onPressed: () {
                        controller.goToLogin();
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
