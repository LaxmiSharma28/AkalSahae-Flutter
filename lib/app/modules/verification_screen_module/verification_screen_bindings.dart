import 'package:akalsahae/app/modules/verification_screen_module/verification_screen_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class VerificationScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerificationScreenController());
  }
}