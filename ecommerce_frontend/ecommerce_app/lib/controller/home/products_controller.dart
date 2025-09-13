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
      // handle error
      statusRequest = response;
    } else {
      statusRequest = StatusRequest.success;
      products.addAll(response['results'] ?? []);

      // pagination check
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
