import 'package:akalsahae/app/apiCollection/api_client.dart';
import 'package:akalsahae/app/modules/Accessory_Product_detail/AccessoryAddToCarrtModal.dart';
import 'package:akalsahae/app/modules/Accessory_Product_detail/AccessoryProductDetailApiModal.dart';
import 'package:akalsahae/app/modules/accessories/accessories_controller.dart';
import 'package:akalsahae/app/modules/check_out_screen_module/check_out_screen_controller.dart';
import 'package:akalsahae/app/modules/favorite_screen_module/favorite_screen_controller.dart';
import 'package:akalsahae/app/modules/home_screen_module/home_screen_controller.dart';
import 'package:akalsahae/app/modules/shop_screen_module/shop_screen_controller.dart';
import 'package:akalsahae/helper_widget/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../utils/shared_preferences_helper.dart';
import '../../utils/shared_prefs_keys.dart';
import 'AccessoryAddToFavApiModal.dart';

class ProductController extends GetxController {
  AppColors appColors = AppColors();
  RxBool isLoading = false.obs;
  var productId = "".obs;
  var productName = ''.obs;
  var price = "".obs;
  bool check = false;
  AccessoriesController accessoriesController = Get.put(AccessoriesController());
  Rx<AccessoryProductDetailApiModal> accessoryProductDetailApiModal = AccessoryProductDetailApiModal().obs;
  CheckOutScreenController checkOutScreenController = Get.put(CheckOutScreenController());
  ShopScreenController shopScreenController = Get.put(ShopScreenController());
  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  Rx<AccessoryAddToCartModal> accessoryAddToCartModal = AccessoryAddToCartModal().obs;
  Rx<ProductData> productData = ProductData().obs;
  TextEditingController quantityController = TextEditingController(text: "1");
  RxBool selectFav = false.obs;
  Rx<AccessoryAddToFavApiModal> favData = AccessoryAddToFavApiModal().obs;
  RxString sizeData = "".obs;

  getProductData({String? productId}) async {
    isLoading.value = true;
    accessoryProductDetailApiModal.value.data?.productName = "";
    await ApiClient.getAccessoryProductDetailData(productId: productId!).then((value) {
      if (value != null) {
        accessoryProductDetailApiModal.value = value;
        selectFav.value = accessoryProductDetailApiModal.value.data!.isFavorite ?? false;
        if (value.data?.productVariations != null) {
          if (value.data?.productVariations!.data != null && value.data!.productVariations!.data!.isNotEmpty) {
            sizeData.value = "${value.data?.productVariations?.data?[0].attributeValue}";
          }
        }
      }
    });

    isLoading.value = false;
  }

  RxBool isVisible1 = false.obs;

  void toggleVisibility1() {
    isVisible1.value = !isVisible1.value;
    update();
  }

  var discount=''.obs;

  Future<bool> accessoryAddToCartData({String? productId, String? price,String?discount}) async {
    bool result = false;
    var deviceId = SharePreferencesHelper.getString(SharedPrefKeys.DEVICE_ID);
    //var total = double.parse(price.toString()) * double.parse(quantityController.text.toString());
    print(productId);
    print(price.toString());
    await ApiClient.accessoryAddToCartModal(
      priceBeforeDiscount: price.toString(),
      priceAfterDiscount: discount.toString(),
      productId: productId!,
    ).then((value) {
      if (value != null) {
        result = true;
        shopScreenController.counter.value = shopScreenController.counter.value + 1;
        homeScreenController.counter.value = homeScreenController.counter.value + 1;
        //Get.toNamed(Routes.CHECK_OUT_SCREEN);
      }
    });
    return result;
  }

  Future<bool> checkOut({String? productId, String? price,String? discount}) async {
    checkOutScreenController.isAddress.value = true;
    bool value = await accessoryAddToCartData(productId: productId, price: price,discount: discount);
    return value;
  }

  checkValidations() {
    if (quantityController.text == null || quantityController.text.isEmpty) {
      ApiClient.toAst("Please enter quantity");
      return false;
    }
    return true;
  }

  addToFavAccessoryData({String? productId}) async {
    // isLoading.value = true;
    await ApiClient.accessoryAddToFavoriteCartApi(productId: int.parse(productId!), isFavorite: !selectFav.value)
        .then((value) {
      if (value != null) {
        selectFav.value = !selectFav.value;
        final favController = Get.put(FavoriteScreenController());
        favController.getFavList();
        printData("fav response--->$value");
        accessoryProductDetailApiModal.value.data!.isFavorite = selectFav.value;
        favData.value = value;
      }
    });
    //isLoading.value = false;
  }

  ///Favourite delete Dialog
  Future<bool?> removeFav(String productId) async {
    await Get.dialog(AlertDialog(
      scrollable: true,
      backgroundColor: appColors.lightBlackColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.sp)),
      content: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: appColors.lightBlackColor),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                'Warning',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: appColors.whiteColor,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Poppins",
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              'Are you sure',
              style: TextStyle(
                fontSize: 11.sp,
                color: appColors.whiteColor,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(
              height: 0.5.h,
            ),
            Text(
              'Remove your favourite product!',
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
                    padding: const EdgeInsets.only(left: 0, top: 10, right: 0),
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
                    addToFavAccessoryData(productId: productId);
                    Get.back(result: true);
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
    return null;
  }
}



/*accessoryAddToCartData({String? productId, String? price}) async {
    isLoading.value = true;
    var deviceId = SharePreferencesHelper.getString(SharedPrefKeys.DEVICE_ID);
    var total = double.parse(price.toString()) * double.parse(quantityController.text.toString());
    await ApiClient.accessoryAddToCartModal(
            deviceId: deviceId.toString(),
            productId: productId!,
            price: price.toString(),
            totalPrice: price.toString(),
            size: 'L',
            quantity: '1')
        .then((value) {
      if (value != null) {
        accessoryAddToCartModal.value = value;
        shopScreenController.counter.value = shopScreenController.counter.value + 1;
        homeScreenController.counter.value = homeScreenController.counter.value + 1;
        //Get.toNamed(Routes.CHECK_OUT_SCREEN);
      }
    });
    isLoading.value = false;
  }*/
