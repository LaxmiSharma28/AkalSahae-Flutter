import 'package:akalsahae/app/modules/my_order_screen_module/my_order_screen_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class MyOrderScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyOrderScreenController());
  }
}