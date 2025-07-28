import 'package:ecommerce_app/core/constant/routes.dart';
import 'package:ecommerce_app/view/screen/auth/forgetpassword.dart';
import 'package:ecommerce_app/view/screen/auth/login.dart';
import 'package:ecommerce_app/view/screen/auth/reset_password.dart';
import 'package:ecommerce_app/view/screen/auth/sign_up.dart';
import 'package:ecommerce_app/view/screen/auth/verify_code.dart';
import 'package:ecommerce_app/view/screen/onboarding.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  //auth
  AppRoute.login: (context) => const Login(),
  AppRoute.signUp: (context) => const SignUp(),
  AppRoute.forgetPassword: (context) => const Forgetpassword(),
  AppRoute.verfyCode: (context) => const VerifyCode(),
  AppRoute.resetPassword: (context) => const ResetPassword(),

  //onboarding
  AppRoute.onBoarding: (context) => const OnBoarding()
};
