import 'package:get/get.dart';

validInput(String val, int min, int max, String type) {
  if (val.isEmpty) {
    return 'required'.tr;
  }
  if (type == "username") {
    if (val.isEmpty) {
      return 'required'.tr;
    } else if (val.length < min || val.length > max) {
      return 'username_length'
          .tr
          .trParams({'min': min.toString(), 'max': max.toString()});
    } else if (!GetUtils.isUsername(val)) {
      return 'username_not_valid'.tr;
    }
  }

  if (type == "email") {
    if (val.isEmpty) {
      return 'required'.tr;
    } else if (!GetUtils.isEmail(val)) {
      return 'email_not_valid'.tr;
    }
  }

  if (type == "password") {
    if (val.isEmpty) {
      return 'required'.tr;
    } else if (val.length < min || val.length > max) {
      return 'password_length'
          .trParams({'min': min.toString(), 'max': max.toString()});
    } else if (val.length < min) {
      return 'password_too_short'.trParams({'min': min.toString()});
    }
  }

  if (type == "phone") {
    if (val.isEmpty) {
      return 'required'.tr;
    } else if (!GetUtils.isPhoneNumber(val)) {
      return 'phone_not_valid'.tr;
    }
  }

  return null; // No error
}
