import 'package:akalsahae/app/modules/try_now_screen_module/try_now_screen_controller.dart';
import 'package:get/get.dart';
/// GetX Template Generator - fb.com/htngu.99


class TryNowScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TryNowScreenController());
  }
}