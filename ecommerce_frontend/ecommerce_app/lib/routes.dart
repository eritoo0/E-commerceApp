import 'package:ecommerce_app/core/constant/routes.dart';
import 'package:ecommerce_app/view/screen/auth/checkemail.dart';
import 'package:ecommerce_app/view/screen/auth/forgetpassword/forgetpassword.dart';
import 'package:ecommerce_app/view/screen/auth/forgetpassword/success_resetpassword.dart';
import 'package:ecommerce_app/view/screen/auth/login.dart';
import 'package:ecommerce_app/view/screen/auth/forgetpassword/reset_password.dart';
import 'package:ecommerce_app/view/screen/auth/sign_up.dart';
import 'package:ecommerce_app/view/screen/auth/forgetpassword/verify_code.dart';
import 'package:ecommerce_app/view/screen/auth/success_signup.dart';
import 'package:ecommerce_app/view/screen/auth/verify_code_signup.dart';
import 'package:ecommerce_app/view/screen/onboarding.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  //auth
  AppRoute.login: (context) => const Login(),
  AppRoute.signUp: (context) => const SignUp(),
  AppRoute.forgetPassword: (context) => const Forgetpassword(),
  AppRoute.verfyCode: (context) => const VerifyCode(),
  AppRoute.checkEmail: (context) => const CheckEmail(),
  AppRoute.resetPassword: (context) => const ResetPassword(),
  AppRoute.successResetpassword: (context) => const SuccessResetpassword(),
  AppRoute.successSignUp: (context) => const SuccessSignup(),
  AppRoute.verifyCodeSignUp: (context) => const VerifyCodeSignup(),

  //onboarding
  AppRoute.onBoarding: (context) => const OnBoarding()
};
