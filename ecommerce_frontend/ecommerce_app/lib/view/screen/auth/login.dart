import 'package:ecommerce_app/controller/auth/login_controller.dart';
import 'package:ecommerce_app/core/functions/alert_exit_app.dart';
import 'package:ecommerce_app/core/functions/valid_input.dart';
import 'package:ecommerce_app/view/widget/auth/custom_body.dart';
import 'package:ecommerce_app/view/widget/auth/custom_text_form_fields.dart';
import 'package:ecommerce_app/view/widget/auth/custom_title.dart';
import 'package:ecommerce_app/view/widget/auth/logo_auth.dart';
import 'package:ecommerce_app/view/widget/auth/signin_up_prompt.dart';
import 'package:ecommerce_app/view/widget/auth/social_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/core/constant/color.dart';
import 'package:ecommerce_app/view/widget/auth/authbutton.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (!didPop) {
            final shouldExit = await alertExitApp(); // returns true or false
            if (shouldExit) {
              Get.close(0); // or SystemNavigator.pop(); exit(0)
            }
          }
        },
        child: Scaffold(
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
            body: GetBuilder<LoginControllerImplement>(
              builder: (controller) => SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const LogoAuth(),
                      CustomTitle(title: "welcome".tr),
                      const SizedBox(height: 10),
                      CustomBody(bodyText: "login_sentence".tr),
                      const SizedBox(height: 24),
                      CustomTextField(
                        validator: (val) {
                          return validInput(val!, 6, 50, 'email');
                        },
                        controller: controller.emailController,
                        labelText: 'email'.tr,
                        hintText: 'email_hint'.tr,
                        preIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        validator: (val) {
                          return validInput(val!, 6, 50, 'password');
                        },
                        controller: controller.passwordController,
                        labelText: 'password'.tr,
                        hintText: 'password_hint'.tr,
                        preIcon: Icons.lock_outline,
                        keyboardType: TextInputType.text,
                        obscureText: controller.isShowPass,
                        suffIcon: Icons.visibility,
                        onTapIcon: () {
                          controller.showPassword();
                        },
                      ),

                      const SizedBox(height: 16),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            controller.goToForgetPassword();
                          },
                          child: Text(
                            'forgot_password'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(decoration: TextDecoration.underline),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                      AuthButton(
                        label: "login".tr,
                        onPressed: () {
                          controller.login();
                        },
                      ),
                      const SizedBox(height: 40),
                      //  Social icons
                      const SocialIcons(),
                      const SizedBox(height: 30),
                      // Sign up prompt
                      SignInUpPrompt(
                          txtOne: "don't_have_account".tr,
                          txtTwo: "signup".tr,
                          onPressed: () {
                            controller.goToSignUp();
                          })
                    ],
                  ),
                ),
              ),
            )));
  }
}
