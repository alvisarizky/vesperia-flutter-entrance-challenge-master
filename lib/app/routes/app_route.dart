import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/features/boarding/boarding_page.dart';
import 'package:entrance_test/src/features/boarding/component/boarding_binding.dart';
import 'package:entrance_test/src/features/dashboard/component/dashboard_binding.dart';
import 'package:entrance_test/src/features/dashboard/dashboard_page.dart';
import 'package:entrance_test/src/features/dashboard/products/detail/component/product_detail_binding.dart';
import 'package:entrance_test/src/features/dashboard/products/detail/product_detail_page.dart';
import 'package:entrance_test/src/features/dashboard/profile/edit/edit_profile_page.dart';
import 'package:entrance_test/src/features/splash/component/splash_binding.dart';
import 'package:entrance_test/src/features/splash/splash_page.dart';
import 'package:get/get.dart';

import '../../src/features/dashboard/profile/edit/component/edit_profile_binding.dart';
import '../../src/features/login/component/login_binding.dart';
import '../../src/features/login/login_page.dart';

class AppRoute {
  static final pages = [
    GetPage(
      name: RouteName.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: RouteName.boarding,
      page: () => const BoardingPage(),
      binding: BoardingBinding(),
    ),
    GetPage(
      name: RouteName.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: RouteName.dashboard,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: RouteName.editProfile,
      page: () => EditProfilePage(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: RouteName.productDetail,
      page: () => const ProductDetailPage(),
      binding: ProductDetailBinding(),
    ),
  ];
}
