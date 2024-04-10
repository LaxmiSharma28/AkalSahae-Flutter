import 'package:akalsahae/app/modules/Accessory_Product_detail/product_controller.dart';
import 'package:get/get.dart';

class ProductBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ProductController());
  }

}