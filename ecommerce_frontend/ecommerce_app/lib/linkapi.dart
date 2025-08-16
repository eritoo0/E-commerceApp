class AppLink {
  static const String server = "http://127.0.0.1:8000/";
  static const String api = "${server}api/";
  static const String users = "${api}users/";

  // Auth flow
  static const String signup = "${users}signup/"; // POST
  static const String login = "${users}login/"; // POST
  static const String verify = "${users}verify/"; // POST
  static const String resendCode = "${users}resend-code/"; // POST
  //forget pass
  static const String forgetPassword = "${users}forgot-password/"; // POST
  static const String verifyResetCode = "${users}verify-reset-code/"; // POST
  static const String resetPassword = "${users}reset-password/"; // POST
}
