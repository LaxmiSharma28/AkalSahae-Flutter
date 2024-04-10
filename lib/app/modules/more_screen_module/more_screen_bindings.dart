import 'package:akalsahae/app/modules/more_screen_module/more_screen_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class MoreScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MoreScreenController());
  }
}