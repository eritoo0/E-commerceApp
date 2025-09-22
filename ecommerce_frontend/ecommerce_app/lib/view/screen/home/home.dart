import 'package:ecommerce_app/controller/home/home_controller.dart';
import 'package:ecommerce_app/core/class/status_request.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/view/widget/home/categories_list.dart';
import 'package:ecommerce_app/view/widget/home/hot_deals_list.dart';
import 'package:ecommerce_app/view/widget/home/offer_banner.dart';
import 'package:ecommerce_app/view/widget/home/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        // load more products when reaching bottom
        Get.find<HomeControllerImplement>().getProducts();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeControllerImplement>(
      builder: (controller) {
        if (controller.statusRequest == StatusRequest.loading &&
            controller.categories.isEmpty &&
            controller.products.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.statusRequest == StatusRequest.failure) {
          return const Center(child: Text("Something went wrong"));
        }

        return ListView(
          controller: _scrollController,
          children: [
            Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                    onPressed: () async {
                      final myServices = Get.find<MyServices>();
                      await myServices.sharedPreferences.remove('token');
                      await myServices.sharedPreferences.remove('access');
                      await myServices.sharedPreferences.remove('refresh');
                      await myServices.sharedPreferences.remove('id');
                      await myServices.sharedPreferences.remove('username');
                      await myServices.sharedPreferences.remove('email');
                      await myServices.sharedPreferences.remove('phone');
                      Get.offAllNamed('/login');
                    },
                    child: const Text("logout"))),
            const OfferBanner(),
            const SizedBox(height: 20),
            CategoriesList(categories: controller.categories),
            const SizedBox(height: 20),
            HotDealsList(products: controller.getDiscountedProducts()),
            ProductGrid(
              products: controller.products,
              scrollController: _scrollController,
              onFavorite: controller.toggleFavorite,
            ),
            if (controller.statusRequest == StatusRequest.loading &&
                controller.products.isNotEmpty)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        );
      },
    );
  }
}
