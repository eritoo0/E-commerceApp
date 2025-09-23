import 'package:ecommerce_app/controller/auth/forgetpassword/forgetpassword_controller.dart';
import 'package:ecommerce_app/controller/auth/forgetpassword/resetpassword_controller.dart';
import 'package:ecommerce_app/controller/auth/forgetpassword/verifycode_controller.dart';
import 'package:ecommerce_app/controller/auth/login_controller.dart';
import 'package:ecommerce_app/controller/auth/signup_controller.dart';
import 'package:ecommerce_app/controller/home_screen/cart/cart_controller.dart';
import 'package:ecommerce_app/controller/home_screen/favorite/favorite_controller.dart';
import 'package:ecommerce_app/controller/home_screen/home/home_controller.dart';
import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/data/datasource/remote/home_data.dart';
import 'package:get/get.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginControllerImplement>(() => LoginControllerImplement(),
        fenix: true);
    Get.lazyPut<SignUpControllerImplement>(() => SignUpControllerImplement(),
        fenix: true);
    Get.lazyPut<ForgetpasswordControllerImplement>(
        () => ForgetpasswordControllerImplement(),
        fenix: true);
    Get.lazyPut<ResetpasswordControllerImplement>(
        () => ResetpasswordControllerImplement(),
        fenix: true);
    Get.lazyPut<VerifycodeControllerImplement>(
        () => VerifycodeControllerImplement(),
        fenix: true);
    Get.lazyPut<HomeControllerImplement>(() => HomeControllerImplement(),
        fenix: true);
    Get.lazyPut<Crud>(() => Crud(), fenix: true);
    Get.lazyPut<HomeData>(() => HomeData(Get.find<Crud>()), fenix: true);

    // Global Favorites controller with HomeData injected
    Get.lazyPut<FavoritesController>(
      () => FavoritesController(Get.find<HomeData>()),
      fenix: true,
    );
    Get.lazyPut<CartControllerImplement>(() => CartControllerImplement(),
        fenix: true);
  }
}
