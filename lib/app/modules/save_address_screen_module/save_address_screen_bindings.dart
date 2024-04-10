import 'package:akalsahae/app/modules/save_address_screen_module/save_address_screen_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class SaveAddressScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SaveAddressScreenController());
  }
}