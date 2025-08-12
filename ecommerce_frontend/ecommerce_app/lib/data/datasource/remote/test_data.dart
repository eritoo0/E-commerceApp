import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/linkapi.dart';

Future<void> main() async {
  final crud = Crud();

  // 1) SIGNUP
  final email = "eritoobnz@gmail.com";
  final password = "12345678";
  final username =
      "batima_ta3_rjal"; // use this to dont change the username ${DateTime.now().millisecondsSinceEpoch}";
  print("==> Signup...");
  final signup = await crud.postData(AppLink.signup, {
    "username": username,
    "email": email,
    "password": password,
    "users_phone": "0500000000",
  });

  signup.fold(
    (err) => print(
        "Signup error: $err"), // to handle  if failure --> no data () or offline
    (data) => print("Signup ok: $data"),
  );

  // 2) VERIFY
  // Get the code from your email (or from Django admin) and paste it here after sign up make sure to comment the signuosection:
  final codeFromEmail = "123456"; // here!
  print("==> Verify...");
  final verify = await crud.postData(AppLink.verify, {
    "email": email,
    "verifycode": codeFromEmail,
  });

  verify.fold(
    (err) => print("Verify error: $err"),
    (data) => print("Verify ok: $data"),
  );

  // 3) LOGIN
  print("==> Login...");
  final login = await crud.postData(AppLink.login, {
    "email": email,
    "password": password,
  });

  login.fold(
    (err) => print("Login error: $err"),
    (data) {
      print("Login ok: $data");
    },
  );

  print("==> Done.");
}
