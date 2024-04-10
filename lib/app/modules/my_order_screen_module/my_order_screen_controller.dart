import 'package:akalsahae/app/apiCollection/api_client.dart';
import 'package:akalsahae/app/modules/my_order_screen_module/GetPlaceOrderApiModal.dart';
import 'package:akalsahae/helper_widget/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrderScreenController extends GetxController {
  AppColors appColors = AppColors();
  Rx<GetOrderApiModal> getOrderApiData = GetOrderApiModal().obs;
  RxBool isLoading = false.obs;
  CartItems cartItems = CartItems();
  RxInt isSelected = (-1).obs;

  getOrderData() async {
    isLoading.value = true;
    await ApiClient.getOrderApiModal().then((value) {
      if (value != null) {
        getOrderApiData.value = value;
      }
    });
    isLoading.value = false;
  }

  RxInt currentView = 0.obs;

  void changeView(index) {
    currentView.value = index;
    update();
  }

  colorStatus(int orderStatus) {
    if (orderStatus == 2) {
      return const Color(0xffFF795C);
    } else if (orderStatus == 0 || orderStatus == 3) {
      return const Color(0xffFFEB3B);
    } else if (orderStatus == 1 || orderStatus == 5 || orderStatus == 4) {
      return const Color(0xff05D677);
    }
  }

  orderStatus(int orderStatus) {
    if (orderStatus == 0) {
      return "Pending";
    } else if (orderStatus == 1) {
      return "Accepted";
    } else if (orderStatus == 2) {
      return "Rejected";
    } else if (orderStatus == 3) {
      return "In-Process";
    } else if (orderStatus == 4) {
      return "Order Shipped";
    } else if (orderStatus == 5) {
      return "Order Delivered";
    } else {
      return "";
    }
  }
}
