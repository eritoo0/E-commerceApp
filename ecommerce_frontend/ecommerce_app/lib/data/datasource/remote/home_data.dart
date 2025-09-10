import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/linkapi.dart';

class HomeData {
  Crud crud;
  HomeData(this.crud);

  Future<dynamic> getCategories() async {
    var response = await crud.getData(AppLink.categories);

    return response.fold((l) => l, (r) {
      // Replace 127.0.0.1 with LAN IP in image urls
      for (var category in r) {
        if (category["image_url"] != null) {
          category["image_url"] = category["image_url"]
              .toString()
              .replaceFirst("127.0.0.1", "yoursomain.com");
        }
      }
      return r;
    });
  }

  /// Fetch products with pagination and optional category filter
  Future<dynamic> getProducts({int page = 1, int? categoryId}) async {
    String url = "${AppLink.products}?page=$page";

    if (categoryId != null) {
      url += "&category=$categoryId";
    }

    var response = await crud.getData(url);

    return response.fold((l) => l, (r) {
      for (var product in r["results"]) {
        if (product["thumbnail_url"] != null) {
          product["thumbnail_url"] = product["thumbnail_url"]
              .toString()
              .replaceFirst("127.0.0.1", "192.168.1.11");
        }
      }
      return r;
    });
  }
}
