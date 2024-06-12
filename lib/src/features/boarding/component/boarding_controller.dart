import 'package:carousel_slider/carousel_controller.dart';
import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/constants/image.dart';
import 'package:entrance_test/src/constants/local_data_key.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BoardingController extends GetxController {
  RxInt currentIndex = 0.obs;

  final _carouselController = Rx<CarouselController>(CarouselController());

  CarouselController get carouselController => _carouselController.value;

  RxList<Map<String, String>> carouselItems = [
    {
      'image': boardingImage1,
      'title': 'Discover Local Treasures',
      'subtitle':
          'Welcome to UMKM Market! Explore unique products from local entrepreneurs. Support small businesses by shopping here and find high-quality items you’ll love!',
    },
    {
      'image': boardingImage2,
      'title': 'Easy Shopping, Great Prices',
      'subtitle':
          'Hi there! At Local Biz Hub, we offer the best local products at friendly prices. Start shopping now and help local businesses grow!',
    },
    {
      'image': boardingImage3,
      'title': 'Your Source for Unique Local Goods',
      'subtitle':
          'Welcome to Market Place! Discover high-quality and unique UMKM products here. Support small entrepreneurs by shopping with us. Start exploring now!',
    },
    {
      'image': boardingImage4,
      'title': 'Quality Products, Global Standards',
      'subtitle':
          'Hello! At Shop Local, you’ll find local products with global quality. Enjoy easy shopping and support small businesses around you. Happy shopping!',
    },
  ].obs;

  void changePageIndex(int index) {
    currentIndex.value = index;
  }

  void navigateToLogin() async {
    await GetStorage().write(LocalDataKey.isFirstTime, true);
    Get.offAllNamed(RouteName.login);
  }
}
