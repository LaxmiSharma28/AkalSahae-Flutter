import 'package:akalsahae/app/modules/check_out_screen_module/check_out_screen_controller.dart';
import 'package:akalsahae/app/modules/fullvoile_turban_screen_module/fullvoile_turban_screen_controller.dart';
import 'package:get/get.dart';

/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class CheckOutScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CheckOutScreenController());
    Get.put(FullvoileTurbanScreenController());

  }
}