import 'package:dio/dio.dart';
import 'package:entrance_test/src/models/request/product_list_request_model.dart';
import 'package:entrance_test/src/models/response/product_detail_model.dart';
import 'package:entrance_test/src/models/response/product_rating_model.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/endpoint.dart';
import '../constants/local_data_key.dart';
import '../models/request/product_rating_request_model.dart';
import '../models/response/product_list_response_model.dart';
import '../utils/networking_util.dart';

class ProductRepository {
  final Dio _client;
  final GetStorage _local;

  ProductRepository({required Dio client, required GetStorage local})
      : _client = client,
        _local = local;

  Future<ProductListResponseModel> getProductList(
      ProductListRequestModel request) async {
    try {
      String endpoint = Endpoint.getProductList;
      final responseJson = await _client.get(
        endpoint,
        data: request,
        options: NetworkingUtil.setupNetworkOptions(
            'Bearer ${_local.read(LocalDataKey.token)}'),
      );
      return ProductListResponseModel.fromJson(responseJson.data);
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<ProductDetailModel> getProductDetail() async {
    try {
      String endpoint = Endpoint.getProductList;
      final responseJson = await _client.get(
        "$endpoint/${_local.read(LocalDataKey.productId)}",
        options: NetworkingUtil.setupNetworkOptions(
            'Bearer ${_local.read(LocalDataKey.token)}'),
      );

      return ProductDetailModel.fromJson(responseJson.data);
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<ProductRatingModel> getProductRatings(
      ProductRatingRequestModel request) async {
    try {
      String endpoint = Endpoint.getProductRatings;
      final responseJson = await _client.get(
        endpoint,
        data: request,
        options: NetworkingUtil.setupNetworkOptions(
            'Bearer ${_local.read(LocalDataKey.token)}'),
      );
      return ProductRatingModel.fromJson(responseJson.data);
    } on DioException catch (_) {
      rethrow;
    }
  }
}
