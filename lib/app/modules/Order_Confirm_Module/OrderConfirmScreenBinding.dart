import 'package:get/get.dart';

import 'OrderConfirmScreen.dart';
import 'OrderConfirmScreenController.dart';

class OrderConfirmScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderConfirmScreenController());
  }
}