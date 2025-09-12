import 'package:ecommerce_app/linkapi.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

abstract class ProductDetailsController extends GetxController {
  addToCart();
  fetchProductDetails();
  stockLabel(int stock);
}

class ProductDetailsControllerImplement extends ProductDetailsController {
  final Map product; // passed from list page

  var stock = 0.obs;
  var images = [].obs; // gallery images
  var description = "".obs;

  ProductDetailsControllerImplement(this.product) {
    stock.value = product["stock"] ?? 0;
  }

  @override
  void onInit() {
    super.onInit();
    fetchProductDetails();
  }

  // ---------------stock-----------------
  @override
  String stockLabel(int stock) {
    if (stock == 0) return "Out of stock";
    if (stock <= 5) return "Only a few left";
    return "In stock";
  }

  // ---------- Add to cart ----------
  @override
  void addToCart() {
    if (stock.value > 0) {
      stock.value--;
      Get.snackbar("Cart", "$productName added to cart!");
    } else {
      Get.snackbar("Cart", "This product is out of stock.");
    }
  }

  // ---------- Getters from lite data ----------
  bool get hasDiscount =>
      product["discount_percent"] != null && product["discount_percent"] > 0;

  String get productName => product["name"] ?? "Unnamed Product";

  String? get categoryName => product["category_name"];

  String get price => product["price"].toString();

  String? get oldPrice => product["old_price"]?.toString();

  String get thumbnailUrl => product["thumbnail_url"] ?? "";

  // ---------- Fetch full details ----------
  @override
  Future<void> fetchProductDetails() async {
    try {
      final dio = Dio();
      final response = await dio.get(
        "${AppLink.products}${product["id"]}/",
      );

      if (response.statusCode == 200) {
        final data = response.data;
        description.value = data["description"] ?? "";
        images.value = data["images"] ?? [];
      }
    } catch (e) {
      print("Error fetching product details: $e");
    }
  }
}
