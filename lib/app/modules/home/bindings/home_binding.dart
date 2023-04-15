import 'package:get/get.dart';
import 'package:news_app/app/modules/home/controllers/favorit_controller.dart';
import 'package:news_app/app/modules/home/controllers/search_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchkamusController>(
      () => SearchkamusController(),
    );
    Get.lazyPut<FavoritController>(
      () => FavoritController(),
    );
   
  }
}
