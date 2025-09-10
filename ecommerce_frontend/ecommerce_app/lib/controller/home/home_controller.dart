import 'package:ecommerce_app/core/class/status_request.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/datasource/remote/home_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomeController extends GetxController {
  initialData();
  getCategories();
  getProducts();
  getDiscountedProducts();
  onSearch(String query);
  filterByCategory(int? categoryId);
}

class HomeControllerImplement extends HomeController {
  MyServices myServices = Get.find();

  HomeData homeData = HomeData(Get.find());

  late TextEditingController searchController;

  String? username;
  // for categories
  List categories = [];

  // fro products
  List products = [];
  int currentPage = 1;
  bool hasMore = true;
  int? selectedCategoryId; // null = all products

  StatusRequest statusRequest = StatusRequest.none;
  @override
  initialData() {
    username = myServices.sharedPreferences.getString("username"); // for test
  }

  @override
  void onInit() {
    initialData();
    searchController = TextEditingController();
    getCategories(); // fectch
    getProducts();
    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  @override
  void onSearch(String query) {
    print(searchController.text);
  }

  @override
  getCategories() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await homeData.getCategories();

    if (response is StatusRequest) {
      // means it's an error
      statusRequest = response;
    } else {
      // success case
      statusRequest = StatusRequest.success;
      categories = response; // safe: list of categories
    }

    update();
  }

  @override
  Future<void> getProducts({bool refresh = false}) async {
    if (refresh) {
      currentPage = 1;
      products.clear();
      hasMore = true;
    }

    if (!hasMore) return;

    statusRequest = StatusRequest.loading;
    update();

    var response = await homeData.getProducts(
      page: currentPage,
      categoryId: selectedCategoryId,
    );

    if (response is StatusRequest) {
      statusRequest = response; // error
    } else {
      statusRequest = StatusRequest.success;

      // Django pagination response
      final List newProducts = response["results"];
      products.addAll(newProducts);

      // check if more pages exist
      if (response["next"] == null) {
        hasMore = false;
      } else {
        currentPage++;
      }
    }

    update();
  }

  @override
  void filterByCategory(int? categoryId) {
    selectedCategoryId = categoryId;
    getProducts(refresh: true);
  }

  @override
  @override
  List getDiscountedProducts() {
    return products
        .where((product) =>
            product["discount_percent"] != null &&
            product["discount_percent"] > 0)
        .toList();
  }
}
