import 'package:akalsahae/app/modules/home_screen_module/home_screen_controller.dart';
import 'package:get/get.dart';

import 'bottom_screen_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class BottomScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>BottomScreenController());
    Get.lazyPut(() => HomeScreenController());
  }
}