import 'package:get/get.dart';

abstract class HomeScreenController extends GetxController {
  void changeTab(int index);
}

class HomeScreenControllerImplement extends HomeScreenController {
  final RxInt currentIndex = 0.obs;

  @override
  void changeTab(int index) {
    currentIndex.value = index;
  }
}
