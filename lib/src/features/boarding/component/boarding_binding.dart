import 'package:entrance_test/src/features/boarding/component/boarding_controller.dart';
import 'package:get/get.dart';

class BoardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BoardingController());
  }
}
