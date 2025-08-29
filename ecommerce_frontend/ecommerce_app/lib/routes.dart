import 'package:ecommerce_app/core/constant/routes.dart';
import 'package:ecommerce_app/core/middleware/middleware.dart';
import 'package:ecommerce_app/view/screen/auth/forgetpassword/forgetpassword.dart';
import 'package:ecommerce_app/view/screen/auth/forgetpassword/success_resetpassword.dart';
import 'package:ecommerce_app/view/screen/auth/login.dart';
import 'package:ecommerce_app/view/screen/auth/forgetpassword/reset_password.dart';
import 'package:ecommerce_app/view/screen/auth/sign_up.dart';
import 'package:ecommerce_app/view/screen/auth/forgetpassword/verify_code.dart';
import 'package:ecommerce_app/view/screen/auth/success_signup.dart';
import 'package:ecommerce_app/view/screen/auth/verify_code_signup.dart';
import 'package:ecommerce_app/view/screen/home.dart';
import 'package:ecommerce_app/view/screen/language.dart';
import 'package:ecommerce_app/view/screen/onboarding.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

List<GetPage<dynamic>>? routes = [
  // Auth routes
  GetPage(
      name: AppRoute.language,
      page: () => const Language(),
      middlewares: [MyMiddleware()]),
  GetPage(name: AppRoute.login, page: () => const Login()),

  GetPage(name: AppRoute.signUp, page: () => const SignUp()),
  GetPage(name: AppRoute.forgetPassword, page: () => const Forgetpassword()),
  GetPage(name: AppRoute.verfyCode, page: () => const VerifyCode()),
  GetPage(name: AppRoute.resetPassword, page: () => const ResetPassword()),
  GetPage(
      name: AppRoute.successResetpassword,
      page: () => const SuccessResetpassword()),
  GetPage(name: AppRoute.successSignUp, page: () => const SuccessSignup()),
  GetPage(
      name: AppRoute.verifyCodeSignUp, page: () => const VerifyCodeSignup()),

  // Onboarding
  GetPage(name: AppRoute.onBoarding, page: () => const OnBoarding()),

  //
  GetPage(name: AppRoute.home, page: () => const Home()),
];

// Map<String, Widget Function(BuildContext)> routess = {
//   //auth
//   AppRoute.login: (context) => const Login(),
//   AppRoute.signUp: (context) => const SignUp(),
//   AppRoute.forgetPassword: (context) => const Forgetpassword(),
//   AppRoute.verfyCode: (context) => const VerifyCode(),
//   AppRoute.resetPassword: (context) => const ResetPassword(),
//   AppRoute.successResetpassword: (context) => const SuccessResetpassword(),
//   AppRoute.successSignUp: (context) => const SuccessSignup(),
//   AppRoute.verifyCodeSignUp: (context) => const VerifyCodeSignup(),

//   //onboarding
//   AppRoute.onBoarding: (context) => const OnBoarding()
// };
