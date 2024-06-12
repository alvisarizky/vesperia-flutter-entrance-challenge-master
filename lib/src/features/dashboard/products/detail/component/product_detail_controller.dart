import 'package:entrance_test/src/constants/local_data_key.dart';
import 'package:entrance_test/src/models/request/product_rating_request_model.dart';
import 'package:entrance_test/src/models/response/product_detail_model.dart';
import 'package:entrance_test/src/models/response/product_rating_model.dart';
import 'package:entrance_test/src/repositories/product_repository.dart';
import 'package:entrance_test/src/utils/networking_util.dart';
import 'package:entrance_test/src/widgets/snackbar_widget.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProductDetailController extends GetxController {
  final ProductRepository _productRepository;

  ProductDetailController({required ProductRepository productRepository})
      : _productRepository = productRepository;

  final _product = Rx<ProductDetailData>(ProductDetailData());

  ProductDetailData get product => _product.value;

  final _ratings = Rx<List<ProductRating>>([]);

  List<ProductRating> get ratings => _ratings.value;

  final _isLoadingRetrieveProduct = false.obs;

  bool get isLoadingRetrieveProduct => _isLoadingRetrieveProduct.value;

  @override
  void onInit() {
    super.onInit();
    getProductDetail();
  }

  Future<void> getProductDetail() async {
    _isLoadingRetrieveProduct.value = true;

    try {
      final product = await _productRepository.getProductDetail();
      final ratings = await _productRepository.getProductRatings(
        ProductRatingRequestModel(
          page: 1,
          limit: 5,
          productId: GetStorage().read(LocalDataKey.productId),
        ),
      );

      _product.value = product.data ?? ProductDetailData();
      _ratings.value = ratings.data ?? [];
      _product.refresh();
      _ratings.refresh();
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }

    _isLoadingRetrieveProduct.value = false;
  }
}
