import 'package:get/get.dart';

import '../../../helper_widget/colors.dart';
import '../../apiCollection/api_client.dart';
import '../my_order_screen_module/GetPlaceOrderApiModal.dart';

class OrderConfirmScreenController extends GetxController {
  AppColors appColors=AppColors();
  Rx<GetOrderApiModal> getOrderApiData = GetOrderApiModal().obs;
  RxBool isLoading = false.obs;

  Data data=Data();
  @override
  void onInit() {
    getOrderId();
    super.onInit();
  }
  getOrderId() async {
    isLoading.value = true;
    await ApiClient.getOrderApiModal().then((value) {
      print("Place id: ${value}");
      if (value != null) {
        getOrderApiData.value = value;
        print(getOrderApiData.value.data?.first.orderId.toString());
      }
    });
    isLoading.value = false;
  }

}