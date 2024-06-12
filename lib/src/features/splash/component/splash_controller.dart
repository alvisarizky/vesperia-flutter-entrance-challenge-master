import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/constants/local_data_key.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  final getStorage = GetStorage();

  @override
  void onReady() {
    super.onReady();
    print("LOCAL TOKEN : ${getStorage.read(LocalDataKey.token) != null}");
    Future.delayed(const Duration(seconds: 3), () {
      if (getStorage.read(LocalDataKey.isFirstTime) == null) {
        Get.offAllNamed(RouteName.boarding);
      } else {
        if (getStorage.read(LocalDataKey.token) != null) {
          Get.offAllNamed(RouteName.dashboard);
        } else {
          Get.offAllNamed(RouteName.login);
        }
      }
    });
  }
}
