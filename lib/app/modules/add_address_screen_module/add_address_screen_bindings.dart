import 'package:akalsahae/app/modules/add_address_screen_module/add_address_screen_controller.dart';
import 'package:get/get.dart';


class AddAddressScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddAddressScreenController());
    Get.lazyPut(() => AddAddressScreenController(),tag: "shipping");
  }
}