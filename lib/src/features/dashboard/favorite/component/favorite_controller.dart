import 'dart:async';

import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/constants/local_data_key.dart';
import 'package:entrance_test/src/models/favorite_product_model.dart';
import 'package:entrance_test/src/repositories/favorite_product_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FavoriteController extends GetxController {
  final FavoriteProductRepository _favoriteProductRepository;

  FavoriteController({
    required FavoriteProductRepository favoriteProductRepository,
  }) : _favoriteProductRepository = favoriteProductRepository;

  @override
  void onInit() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) => getAllFavoriteProducts(),
    );
    super.onInit();
  }

  final _favoriteProducts = Rx<List<FavoriteProductModel>>([]);

  List<FavoriteProductModel> get favoriteProducts => _favoriteProducts.value;

  Future<void> getAllFavoriteProducts() async {
    List<Map<String, dynamic>> favorites =
        await _favoriteProductRepository.query();
    _favoriteProducts.value =
        favorites.map((data) => FavoriteProductModel.fromJson(data)).toList();
    _favoriteProducts.refresh();
  }

  void toProductDetail(FavoriteProductModel product) async {
    await GetStorage().write(LocalDataKey.productId, product.productId);
    Get.toNamed(RouteName.productDetail);
  }

  void setFavorite(FavoriteProductModel product) async {
    product.isFavorite = !product.isFavorite;
    await _favoriteProductRepository.delete(FavoriteProductModel(
      productId: product.productId,
      name: product.name,
      price: product.price,
      discountPrice: product.discountPrice,
      images: product.images,
    ));
    _favoriteProducts.refresh();
  }
}
