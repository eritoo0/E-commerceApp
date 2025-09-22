import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/core/class/status_request.dart';
import 'package:ecommerce_app/core/constant/routes.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/linkapi.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// If persist tokens, use GetStorage or SharedPreferences
// import 'package:get_storage/get_storage.dart';

abstract class LoginController extends GetxController {
  Future<void> login();
  void goToSignUp();
  void goToForgetPassword();
  void showPassword();
}

class LoginControllerImplement extends LoginController {
  final crud = Crud();

  MyServices myServices = Get.find();
  // final box = GetStorage(); // if store the auth token

  late TextEditingController emailController;
  late TextEditingController passwordController;

  final formKey = GlobalKey<FormState>();

  bool isShowPass = true;
  final isLoading = false.obs;

  // ---------- UI helpers ----------
  @override
  void showPassword() {
    isShowPass = !isShowPass;
    update(); // rebuild GetBuilder widgets
  }

  void _hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  void _snack(String title, String message) {
    _hideKeyboard();
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 2),
    );
  }

  // Validators you can reference from TextFormField.validator or using function validInput
  String? validateEmail(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return 'Email is required';
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(s);
    if (!ok) return 'Enter a valid email';
    return null;
  }

  String? validatePassword(String? v) {
    final s = (v ?? '');
    if (s.isEmpty) return 'Password is required';
    if (s.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  // ---------- Actions ----------
  @override
  Future<void> login() async {
    _hideKeyboard();

    final form = formKey.currentState;
    if (form == null || !form.validate()) {
      _snack('Login', 'Please fix the errors and try again.');
      return;
    }

    if (isLoading.value) return;
    isLoading.value = true;
    update();

    final email = emailController.text.trim().toLowerCase();
    final password = passwordController.text;

    try {
      final res = await crud.postData(
          AppLink.login,
          {
            // Backend expects email because USERNAME_FIELD='email'
            "email": email,
            "password": password,
          },
          withAuth: false);

      res.fold(
        (err) {
          isLoading.value = false;
          update();

          String msg = "Could not sign in";
          if (err == StatusRequest.offlineFailure) {
            msg = "No internet connection";
          } else if (err == StatusRequest.serverFailure) {
            msg = "Wrong email or password";
          }
          _snack("Login failed", msg);
        },
        (data) {
          isLoading.value = false;
          update();
          print('Login raw response: $data');

          // Typical DRF responses:
          // success => {"token": "..."} or {"auth_token": "..."} or {"key": "..."} + maybe user object
          // error   => {"detail": "..."} or {"non_field_errors": ["..."]} or {"email": ["..."]}

          final token = data["token"] ?? data["auth_token"] ?? data["key"];
          final access = data['access'];
          final refresh = data['refresh'];
          final detail = data["detail"]?.toString();
          final nonField = (data["non_field_errors"] is List &&
                  data["non_field_errors"].isNotEmpty)
              ? data["non_field_errors"][0].toString()
              : null;
          final emailErr = (data["email"] is List && data["email"].isNotEmpty)
              ? data["email"][0].toString()
              : null;
          if (access != null) {
            myServices.sharedPreferences.setString('access', access);
          }
          if (refresh != null) {
            myServices.sharedPreferences.setString('refresh', refresh);
          }

          if (token != null) {
            // Optional: persist token for authenticated requests
            // box.write('token', token);
            // ✅ Save user info into SharedPreferences
            // Save token
            myServices.sharedPreferences.setString("token", token);

            // Extract user object
            final user = data["user"];

            // Save user info
            if (user != null) {
              myServices.sharedPreferences
                  .setString("id", user["id"].toString());
              myServices.sharedPreferences
                  .setString("username", user["username"] ?? "");
              myServices.sharedPreferences
                  .setString("email", user["email"] ?? "");
              myServices.sharedPreferences
                  .setString("phone", user["users_phone"] ?? "");
            }

            // Save step = 2  to check logged in to skip the onboarding
            //MyServices.sharedPreferences.setInt("step", 2);

            _snack("Welcome", "Signed in successfully");

            Get.offAllNamed(AppRoute.home);
            return;
          }

          // Show server-provided error if present
          final msg =
              detail ?? nonField ?? emailErr ?? data["message"]?.toString();
          if (msg != null) {
            _snack("Login failed", msg);
            return;
          }

          // Fallback
          _snack("Login failed", "Invalid email or password");
        },
      );
    } catch (e) {
      isLoading.value = false;
      update();
      _snack("Login failed", e.toString());
    }
  }

  @override
  void goToSignUp() => Get.offNamed(AppRoute.signUp);

  @override
  void goToForgetPassword() => Get.toNamed(AppRoute.forgetPassword);

  // ---------- Lifecycle ----------
  @override
  void onInit() {
    // FirebaseMessaging.instance.getToken().then(
    //   (value) {
    //     print(value);
    //     String? token = value;
    //   },
    // );
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
