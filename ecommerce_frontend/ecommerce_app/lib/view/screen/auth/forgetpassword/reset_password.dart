import 'package:ecommerce_app/controller/auth/forgetpassword/resetpassword_controller.dart';
import 'package:ecommerce_app/core/functions/valid_input.dart';
import 'package:ecommerce_app/view/widget/auth/custom_body.dart';
import 'package:ecommerce_app/view/widget/auth/custom_text_form_fields.dart';
import 'package:ecommerce_app/view/widget/auth/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/core/constant/color.dart';
import 'package:ecommerce_app/view/widget/auth/authbutton.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorApp.bgColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorApp.bgColor,
          elevation: 0,
          title: Text(
            "reset_password".tr,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        body: GetBuilder<ResetpasswordControllerImplement>(
          builder: (controller) => SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTitle(title: "reset_your_password".tr),
                  const SizedBox(height: 10),
                  CustomBody(bodyText: "reset_pass_sentence".tr),
                  const SizedBox(height: 24),
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
                  const SizedBox(height: 24),
                  CustomTextField(
                    validator: (val) {
                      return validInput(val!, 6, 50, 'password');
                    },
                    controller: controller.repasswordController,
                    labelText: 'password'.tr,
                    hintText: "reenter_password_hint".tr,
                    preIcon: Icons.lock_outline,
                    keyboardType: TextInputType.text,
                    obscureText: controller.isShowPass,
                    suffIcon: Icons.visibility,
                    onTapIcon: () {
                      controller.showPassword();
                    },
                  ),
                  const SizedBox(height: 20),
                  AuthButton(
                    label: "reset_pass".tr,
                    onPressed: () {
                      controller.goToSuccessResetpass();
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
