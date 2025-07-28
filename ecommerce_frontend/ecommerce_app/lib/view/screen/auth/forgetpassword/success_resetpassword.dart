import 'package:ecommerce_app/controller/auth/forgetpassword/success_resetpassword_controller.dart';
import 'package:ecommerce_app/core/constant/color.dart';
import 'package:ecommerce_app/view/widget/auth/authbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessResetpassword extends StatelessWidget {
  const SuccessResetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    SuccessResetpasswordControllerImplement controller =
        SuccessResetpasswordControllerImplement();
    return Scaffold(
      backgroundColor: ColorApp.bgColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.lock_open_outlined,
                  color: ColorApp.primaryColor,
                  size: 120,
                ),
                const SizedBox(height: 24),
                Text(
                  'reset_success_title'.tr,
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
                  'reset_success_subtitle'.tr,
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
                      label: 'go_to_login'.tr,
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
