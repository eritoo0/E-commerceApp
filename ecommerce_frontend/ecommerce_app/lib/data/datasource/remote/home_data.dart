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
              .replaceFirst("127.0.0.1", "yourdomain.com");
        }
      }
      return r;
    });
  }
}
