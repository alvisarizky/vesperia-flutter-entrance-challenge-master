import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/constants/local_data_key.dart';
import 'package:entrance_test/src/models/favorite_product_model.dart';
import 'package:entrance_test/src/repositories/favorite_product_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FavoriteController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // Future.delayed(const Duration(seconds: 5), () => getAllFavoriteProducts());
  }

  final _favoriteProducts = Rx<List<FavoriteProductModel>>([]);

  List<FavoriteProductModel> get favoriteProducts => _favoriteProducts.value;

  final _isLoadingRetrieveProduct = false.obs;

  bool get isLoadingRetrieveProduct => _isLoadingRetrieveProduct.value;

  Future<void> getAllFavoriteProducts() async {
    _isLoadingRetrieveProduct.value = !_isLoadingRetrieveProduct.value;

    List<Map<String, dynamic>> favorites =
        await FavoriteProductRepository.query();
    _favoriteProducts.value.assignAll(
        favorites.map((data) => FavoriteProductModel.fromJson(data)).toList());
    _favoriteProducts.refresh();
    print("DATA LENGTH : ${_favoriteProducts.value.length}");

    _isLoadingRetrieveProduct.value = !_isLoadingRetrieveProduct.value;
  }

  void toProductDetail(FavoriteProductModel product) async {
    await GetStorage().write(LocalDataKey.productId, product.productId);
    Get.toNamed(RouteName.productDetail);
  }
}
