import 'package:ansicolor/ansicolor.dart';
import 'package:dio/dio.dart';
import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/constants/local_data_key.dart';
import 'package:entrance_test/src/repositories/favorite_product_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import '../src/constants/endpoint.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GetStorage>(GetStorage());
    Get.put<FavoriteProductRepository>(FavoriteProductRepository());
    Get.put(FavoriteProductRepository().initDb());

    Get.put<Dio>(
      Dio(
        BaseOptions(
          baseUrl: Endpoint.baseUrl,
          connectTimeout: const Duration(minutes: 1),
          followRedirects: false,
        ),
      )..interceptors.addAll([
          TalkerDioLogger(
            settings: TalkerDioLoggerSettings(
              printRequestHeaders: true,
              printResponseHeaders: true,
              printResponseMessage: true,
              // Blue http requests logs in console
              requestPen: AnsiPen()..blue(),
              // Green http responses logs in console
              responsePen: AnsiPen()..green(),
              // Error http logs in console
              errorPen: AnsiPen()..red(),
            ),
          ),
          InterceptorsWrapper(
            onError: (error, handler) async {
              if (error.response?.statusCode == 401) {
                await GetStorage().remove(LocalDataKey.token);
                Get.offAllNamed(RouteName.login);
                return;
              }
              handler.next(error);
            },
          )
        ]),
      permanent: true,
    );
  }
}
