import 'package:ecommerce_app/controller/home_screen/favorite/favorite_controller.dart';
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
  final favCtrl = Get.find<FavoritesController>();

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
    //searchController.clear();
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

    final response = await homeData.getProducts(
      page: currentPage,
      categoryId: selectedCategoryId,
    );

    final favCtrl = Get.find<FavoritesController>();

    if (response is StatusRequest) {
      // API error
      statusRequest = response;
    } else {
      statusRequest = StatusRequest.success;

      final List newProducts = response["results"] ?? [];

      // Filter out duplicates
      final List uniqueProducts = [];
      for (var product in newProducts) {
        final id = product["id"];
        if (!products.any((p) => p["id"] == id)) {
          uniqueProducts.add(product);

          // Initialize favorites if not already present
          if (!favCtrl.favorites.containsKey(id)) {
            favCtrl.favorites[id] = product["is_favorite"] ?? false;
          }
        }
      }

      products.addAll(uniqueProducts);

      // Pagination check
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
  List getDiscountedProducts() {
    return products
        .where((product) =>
            product["discount_percent"] != null &&
            product["discount_percent"] > 0)
        .toList();
  }
}
