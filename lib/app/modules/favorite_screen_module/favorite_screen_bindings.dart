import 'package:akalsahae/app/modules/favorite_screen_module/favorite_screen_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class FavoriteScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteScreenController());
  }
}