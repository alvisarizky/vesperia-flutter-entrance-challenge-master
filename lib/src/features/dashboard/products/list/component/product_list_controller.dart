import 'dart:async';

import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/constants/local_data_key.dart';
import 'package:entrance_test/src/models/favorite_product_model.dart';
import 'package:entrance_test/src/models/request/product_list_request_model.dart';
import 'package:entrance_test/src/repositories/favorite_product_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../models/product_model.dart';
import '../../../../../repositories/product_repository.dart';
import '../../../../../utils/networking_util.dart';
import '../../../../../widgets/snackbar_widget.dart';

class ProductListController extends GetxController {
  final ProductRepository _productRepository;
  final FavoriteProductRepository _favoriteProductRepository;

  ProductListController({
    required ProductRepository productRepository,
    required FavoriteProductRepository favoriteProductRepository,
  })  : _productRepository = productRepository,
        _favoriteProductRepository = favoriteProductRepository;

  final _products = Rx<List<ProductModel>>([]);

  List<ProductModel> get products => _products.value;

  final _isLoadingRetrieveProduct = false.obs;

  bool get isLoadingRetrieveProduct => _isLoadingRetrieveProduct.value;

  final _isLoadingRetrieveMoreProduct = false.obs;

  bool get isLoadingRetrieveMoreProduct => _isLoadingRetrieveMoreProduct.value;

  final _isLoadingRetrieveCategory = false.obs;

  bool get isLoadingRetrieveCategory => _isLoadingRetrieveCategory.value;

  final _canFilterCategory = true.obs;

  bool get canFilterCategory => _canFilterCategory.value;

  final _isLastPageProduct = false.obs;

  bool get isLastPageProduct => _isLastPageProduct.value;

  //The number of product retrieved each time a call is made to server
  final _limit = 10;

  //The number which shows how many product already loaded to the device,
  //thus giving the command to ignore the first x number of data when retrieving
  int _skip = 0;

  final _scrollController = Rx<ScrollController>(ScrollController());

  ScrollController get scrollController => _scrollController.value;

  final _favoriteProducts = Rx<List<FavoriteProductModel>>([]);

  List<FavoriteProductModel> get favoriteProducts => _favoriteProducts.value;

  @override
  void onInit() {
    super.onInit();
    getProducts();
    _scrollController.value.addListener(() async {
      var nextPageTrigger =
          0.8 * _scrollController.value.position.maxScrollExtent;

      if (_scrollController.value.position.pixels > nextPageTrigger) {
        getMoreProducts();
      }
    });
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) => setDefaultFavoriteValue(),
    );
  }

  //first load or after refresh.
  void getProducts() async {
    _isLoadingRetrieveProduct.value = true;
    _skip = 0;
    try {
      final productList =
          await _productRepository.getProductList(ProductListRequestModel(
        limit: _limit,
        skip: _skip,
      ));
      _products.value = productList.data;
      _products.refresh();
      _isLastPageProduct.value = productList.data.length < _limit;
      _skip = products.length;
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
    _isLoadingRetrieveProduct.value = false;
  }

  void getMoreProducts() async {
    if (_isLastPageProduct.value || _isLoadingRetrieveMoreProduct.value) return;

    _isLoadingRetrieveMoreProduct.value = true;

    //TODO: finish this function by calling get product list with appropriate parameters
    try {
      final productList =
          await _productRepository.getProductList(ProductListRequestModel(
        limit: _limit,
        skip: _skip,
      ));
      _products.value.addAllIf(productList.data.isNotEmpty, productList.data);
      _products.refresh();
      _isLastPageProduct.value = productList.data.length < _limit;
      _skip = _products.value.length;
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }

    _isLoadingRetrieveMoreProduct.value = false;
  }

  void toProductDetail(ProductModel product) async {
    await GetStorage().write(LocalDataKey.productId, product.id);
    Get.toNamed(RouteName.productDetail);
  }

  void setFavorite(ProductModel product) async {
    if (product.isFavorite) {
      product.isFavorite = !product.isFavorite;
      await _favoriteProductRepository.delete(FavoriteProductModel(
        productId: product.id,
        name: product.name,
        price: product.price,
        discountPrice: product.discountPrice,
        images: product.images,
      ));
    } else {
      product.isFavorite = !product.isFavorite;
      await _favoriteProductRepository.insert(FavoriteProductModel(
        productId: product.id,
        name: product.name,
        price: product.price,
        discountPrice: product.discountPrice,
        images: product.images,
      ));
    }
  }

  void setDefaultFavoriteValue() async {
    List<Map<String, dynamic>> favorites =
        await _favoriteProductRepository.query();
    _favoriteProducts.value =
        favorites.map((data) => FavoriteProductModel.fromJson(data)).toList();

    for (var product in _products.value) {
      for (var favorite in favoriteProducts) {
        if (product.id == favorite.productId) {
          product.isFavorite = favorite.isFavorite;
        }
      }
    }
    _products.refresh();
    _favoriteProducts.refresh();
  }
}
