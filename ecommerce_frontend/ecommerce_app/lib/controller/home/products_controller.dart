import 'package:ecommerce_app/controller/home/favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/core/class/status_request.dart';
import 'package:ecommerce_app/data/datasource/remote/home_data.dart';

abstract class ProductsController extends GetxController {
  Future<void> fetchProducts({bool refresh});
  onSearch(String query);
}

class ProductsControllerImplement extends ProductsController {
  final int categoryId;

  ProductsControllerImplement(this.categoryId);

  final HomeData homeData = HomeData(Get.find());

  late TextEditingController searchController;
  List products = [];
  int currentPage = 1;
  bool hasMore = true;
  StatusRequest statusRequest = StatusRequest.none;

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
    fetchProducts(refresh: true);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  @override
  Future<void> fetchProducts({bool refresh = false}) async {
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
      categoryId: categoryId,
    );

    if (response is StatusRequest) {
      // API error
      statusRequest = response;
    } else {
      statusRequest = StatusRequest.success;

      final List newProducts = response['results'] ?? [];

      // Add only products that don't exist yet
      final List uniqueProducts = [];
      for (var product in newProducts) {
        final id = product['id'];
        if (!products.any((p) => p['id'] == id)) {
          uniqueProducts.add(product);

          // Initialize favorite if not already set
          final favCtrl = Get.find<FavoritesController>();
          if (!favCtrl.favorites.containsKey(id)) {
            favCtrl.favorites[id] = product['is_favorite'] ?? false;
          }
        }
      }

      products.addAll(uniqueProducts);

      // Pagination check
      if (response['next'] == null) {
        hasMore = false;
      } else {
        currentPage++;
      }
    }

    update();
  }

  @override
  void onSearch(String query) {
    // Optional: filter products or call API
    print(searchController.text);
  }
}
