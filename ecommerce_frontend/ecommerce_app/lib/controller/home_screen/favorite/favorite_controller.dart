import 'package:ecommerce_app/data/datasource/remote/home_data.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/core/class/status_request.dart';

class FavoritesController extends GetxController {
  final favorites = <int, bool>{}.obs;
  final HomeData _homeData;

  FavoritesController(this._homeData);

  /// Initialize favorites map from product list
  void initFavorites(List<Map<String, dynamic>> products) {
    for (var p in products) {
      final id = p["id"];
      if (!favorites.containsKey(id)) {
        favorites[id] = p["is_favorite"] == true;
      }
    }
  }

  Future<void> toggle(int productId) async {
    final current = favorites[productId] ?? false;
    favorites[productId] = !current;

    final res = await _homeData.toggleFavorite(productId);
    if (res is StatusRequest) {
      favorites[productId] = current;
    }
  }
}
