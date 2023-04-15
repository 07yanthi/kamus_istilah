import 'package:get/get.dart';

import 'package:news_app/app/modules/home/bindings/home_binding.dart';
import 'package:news_app/splash.dart';

part 'app_routes.dart';

class AppPages {
  // ignore: constant_identifier_names
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => SplashScreen(),
      binding: HomeBinding(),
    ),
  ];
}
