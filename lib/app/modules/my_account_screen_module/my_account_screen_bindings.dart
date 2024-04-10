import 'package:akalsahae/app/modules/my_account_screen_module/my_account_screen_controller.dart';
import 'package:get/get.dart';
/// GetX Template Generator - fb.com/htngu.99


class MyAccountScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyAccountScreenController());
  }
}