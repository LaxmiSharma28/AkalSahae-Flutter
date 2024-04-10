// ignore_for_file: empty_catches, avoid_print

import 'dart:ffi';

import 'package:akalsahae/app/apiCollection/api_client.dart';
import 'package:akalsahae/app/modules/check_out_screen_module/Get_Add_To_Cart_api_modal.dart';
import 'package:akalsahae/app/modules/check_out_screen_module/PinCodeApiModal.dart';
import 'package:akalsahae/app/modules/check_out_screen_module/PlaceOrderApiModal.dart';
import 'package:akalsahae/app/modules/check_out_screen_module/UpdateRemoveCartApiModal.dart';
import 'package:akalsahae/app/modules/fullvoile_turban_screen_module/fullvoile_turban_screen_controller.dart';
import 'package:akalsahae/app/modules/home_screen_module/home_screen_controller.dart';
import 'package:akalsahae/app/modules/save_address_screen_module/save_address_screen_controller.dart';
import 'package:akalsahae/app/modules/shop_screen_module/shop_screen_controller.dart';
import 'package:akalsahae/app/utils/shared_preferences_helper.dart';
import 'package:akalsahae/app/utils/shared_prefs_keys.dart';
import 'package:akalsahae/helper_widget/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../main.dart';
import '../../routes/app_pages.dart';
import 'DeleteCartApiModal.dart';

class CheckOutScreenController extends GetxController {
  SaveAddressScreenController saveAddressScreenController = Get.put(SaveAddressScreenController());
  final homeController = Get.put(HomeScreenController());
  final shopController = Get.put(ShopScreenController());
  RxBool isAddress = false.obs;
  AppColors appColors = AppColors();
  Rx<GetAddToCartApiModal> getAddToCartApiModal = GetAddToCartApiModal().obs;
  Rx<PlaceOrderApiModal> placeOrderApiModal = PlaceOrderApiModal().obs;
  Rx<RemoveCartApiModal> removeCart = RemoveCartApiModal().obs;
  Rx<DeleteCartApiModal> deleteCart = DeleteCartApiModal().obs;
  Rx<PinCodeApiModal> pinCodeValue = PinCodeApiModal().obs;
  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  ShopScreenController shopScreenController = Get.put(ShopScreenController());
  TextEditingController pincodeController = TextEditingController();

  var isTapped = false.obs;

//AccessoriesController accessoriesController=Get.put(AccessoriesController());
  Rx<AddData> data = AddData().obs;

  var address = "".obs;
  RxBool isLoading = false.obs;
  RxInt value = 1.obs;

  getCart() async {
    debugPrint("Cart Step 1");
    isLoading.value = true;
    var deviceId = SharePreferencesHelper.getString(SharedPrefKeys.DEVICE_ID);

    await ApiClient.getAddToCartApiModal().then((value) {
      if (value != null) {
        getAddToCartApiModal.value = value;
        homeScreenController.counter.value = getAddToCartApiModal.value.data!.length;
        shopScreenController.counter.value = getAddToCartApiModal.value.data!.length;
        if (cartKey.currentState != null)
          cartKey.currentState!.updateBadge(homeScreenController.counter.value.toString());

        print(getAddToCartApiModal.value.data!.length);
        update();
      }
    });
    isLoading.value = false;
  }

  placeOrderData({required String id, required String payId, required String transId}) async {
    try {
      print("ID: $id");
      print("Trans:$transId");
      print("Pay:$payId");
      await ApiClient.placeOderApiData(addressId: id.toString(), payId: payId, transId: transId).then((value) {
        print("Value:$value");
        if (value != null) {
          placeOrderApiModal.value = value;
          homeScreenController.counter.value = 0;
          shopScreenController.counter.value = 0;
          Get.offNamed(Routes.MY_ORDER_SCREEN);
        }
      });
    } catch (error) {
      print(error);
    }
    // var id = int.parse(saveAddressScreenController.selectAddress.value.id.toString()) ?? "";
  }

  deleteCartData(int cardID) async {
    isLoading.value = true;
    printData("Card ID: $cardID");
    try {
      await ApiClient.deleteCartData(cartId: cardID).then((value) async {
        if (value != null) {
          deleteCart.value = value;
          if (getAddToCartApiModal.value.data!.isNotEmpty) {
            getAddToCartApiModal.value.data?.removeWhere((element) => element.cartId == cardID);
            homeScreenController.counter.value = getAddToCartApiModal.value.data!.length;
            shopScreenController.counter.value = getAddToCartApiModal.value.data!.length;
            update();
            getCart();
          }
        }
      });
      isLoading.value = false;
    } catch (err) {
      isLoading.value = false;
      print("${err} ERROR");
    }
  }

  Future<PinCodeApiModal?> pinCodeData() async {
    try {
      final response = await ApiClient.enterPinCode(pinCode: pincodeController.text);
      if (response != null) {
        pinCodeValue.value = response;
      }
      return response;
    } catch (err) {

      print("pin error $err");
      return null;
    }
  }

  removeCartApi(int cardID, {required int index}) async {
    printData("Card ID: $cardID");
    try {
      await ApiClient.removeApiData(cardId: cardID, quantity: 0).then((value) {
        if (value != null) {
          removeCart.value = value;
          getAddToCartApiModal.value.data!.removeAt(index);
          update();
          Get.toNamed(Routes.CHECK_OUT_SCREEN);
        }
      });
    } catch (err) {
    }
  }

  void showAlertDialog(BuildContext context, id, {required int index}) {
    Get.dialog(AlertDialog(
      scrollable: true,
      backgroundColor: appColors.lightBlackColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.sp)),
      content: Container(
        //height: MediaQuery.of(context).size.height * 0.20,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: appColors.lightBlackColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                'Remove Item',
                style: TextStyle(fontSize: 15.sp, color: appColors.whiteColor, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Center(
                child: Text(
              'Are you sure',
              style: TextStyle(
                fontSize: 11.sp,
                color: appColors.whiteColor,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins",
              ),
            )),
            SizedBox(
              height: 0.5.h,
            ),
            Text(
              'you want to remove this item?',
              style: TextStyle(
                fontSize: 11.sp,
                color: appColors.whiteColor,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, right: 0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 100,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: appColors.darkYellowColor, width: 1),
                      ),
                      child: Text(
                        "NO",
                        style: TextStyle(
                            letterSpacing: 1.5,
                            color: appColors.whiteColor,
                            fontFamily: "Poppins",
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    deleteCartData(id);
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10, right: 0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 100,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: appColors.darkYellowColor,
                      ),
                      child: Text(
                        "YES",
                        style: TextStyle(
                            letterSpacing: 1.5,
                            color: appColors.whiteColor,
                            fontFamily: "Poppins",
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

}
