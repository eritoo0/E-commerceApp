import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/controller/login_controller.dart';
import 'package:ecommerce_app/core/constant/color.dart';
import 'package:ecommerce_app/view/widget/login/login_button.dart';
import 'package:ecommerce_app/view/widget/login/loginform.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: ColorApp.bgColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorApp.bgColor,
        elevation: 0,
        title: Text(
          "login".tr,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "welcome".tr,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              "login_sentence".tr,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            LoginFields(
              emailController: emailController,
              passwordController: passwordController,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(() => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: controller.toggleRememberMe,
                          checkColor: Colors.white,
                          fillColor: WidgetStateProperty.resolveWith<Color?>(
                            (states) => states.contains(WidgetState.selected)
                                ? ColorApp.primaryColor
                                : Colors.transparent,
                          ),
                          side: const BorderSide(color: Colors.grey),
                        )),
                    Text('remember_me'.tr),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Forgot password
                  },
                  child: Text(
                    'forgot_password'.tr,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            LoginButton(
              label: "login".tr,
              onPressed: () {
                // TODO: Handle login
              },
            ),
            const SizedBox(height: 30),

            // Social icons
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     _socialIcon('assets/icons/google.png'),
            //     const SizedBox(width: 16),
            //     _socialIcon('assets/icons/facebook.png'),
            //     const SizedBox(width: 16),
            //     _socialIcon('assets/icons/twitter.png'),
            //   ],
            // ),
            const SizedBox(height: 20),

            // Sign up prompt
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("don't_have_account".tr),
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to sign-up
                  },
                  child: Text('sign_up'.tr),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialIcon(String path) {
    return GestureDetector(
      onTap: () {
        // TODO: Handle social login
      },
      child: Image.asset(
        path,
        width: 28,
        height: 28,
      ),
    );
  }
}
