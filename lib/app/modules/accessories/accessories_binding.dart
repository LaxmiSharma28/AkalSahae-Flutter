import 'package:akalsahae/app/modules/accessories/accessories_controller.dart';
import 'package:get/get.dart';

class AccessoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AccessoriesController);
  }
}
