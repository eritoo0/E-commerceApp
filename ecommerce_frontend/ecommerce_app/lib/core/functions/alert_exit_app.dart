import 'package:get/get.dart';

Future<bool> alertExitApp() async {
  bool shouldExit = false;
  await Get.defaultDialog(
    title: "exit_title".tr,
    middleText: "exit_message".tr,
    textCancel: "cancel".tr,
    textConfirm: "exit".tr,
    onConfirm: () {
      shouldExit = true;
      Get.back();
    },
    onCancel: () {
      shouldExit = false;
    },
  );
  return shouldExit;
}
