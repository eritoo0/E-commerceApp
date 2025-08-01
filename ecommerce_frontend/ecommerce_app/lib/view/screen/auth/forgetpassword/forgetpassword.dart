import 'package:ecommerce_app/controller/auth/forgetpassword/forgetpassword_controller.dart';
import 'package:ecommerce_app/core/functions/valid_input.dart';
import 'package:ecommerce_app/view/widget/auth/custom_body.dart';
import 'package:ecommerce_app/view/widget/auth/custom_text_form_fields.dart';
import 'package:ecommerce_app/view/widget/auth/custom_title.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/core/constant/color.dart';
import 'package:ecommerce_app/view/widget/auth/authbutton.dart';

class Forgetpassword extends StatelessWidget {
  const Forgetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorApp.bgColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorApp.bgColor,
          elevation: 0,
          title: Text(
            "forgetPassword".tr,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        body: GetBuilder<ForgetpasswordControllerImplement>(
          builder: (controller) => SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTitle(title: "check_email".tr),
                  const SizedBox(height: 10),
                  CustomBody(bodyText: "check_email_sentence".tr),
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
                  AuthButton(
                    label: "check_email".tr,
                    onPressed: () {
                      controller.goToVerifyCode();
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
