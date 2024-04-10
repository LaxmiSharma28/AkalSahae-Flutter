import 'package:akalsahae/app/apiCollection/api_client.dart';
import 'package:akalsahae/app/modules/save_address_screen_module/get_address_api_modal.dart';
import 'package:akalsahae/helper_widget/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../routes/app_pages.dart';
import 'DefaultResponseModal.dart';
import 'RemoveAddressApiModal.dart';

class SaveAddressScreenController extends GetxController {
  AppColors appColors = AppColors();
  RxBool fromCheckOutScreen = false.obs;
  RxString selectedRadio = ''.obs;
  String selectedGender = 'yes';
  RxMap<String, String> selectedAddress = <String, String>{}.obs;
  Rx<GetAddressApiModal> getAddressApiModal = GetAddressApiModal().obs;
  var defaultAddress = AddressData().obs;
  RxBool isLoading = false.obs;
  Rx<AddressData> selectAddress = AddressData().obs;

  Rx<DefaultResponseModal> defaultAddressApiModal = DefaultResponseModal().obs;
  Rx<RemoveResponseModal> removeAddressApiModal = RemoveResponseModal().obs;

  setAddressValue() async {
    selectAddress.value = getAddressApiModal.value.data![int.parse(selectedIndex.toString())];
    //selectedAddress.value=Address.user[value];
    update();
  }

  setSelectedRadio(String value) {
    selectedRadio.value = value;
    update();
  }

  /// this condition use for routing to one common screen from two different screens.
  // RxBool isCheck = false.obs;

  final RxBool isEditing = false.obs;
  final RxString buttonText = ''.obs;

  var selectedIndex = "-1".obs;

  void selectDefaultAddress(int index) async {
    selectedIndex.value = index.toString();
    showLoadingDialog();
    String addressID = '';
    if (index.toString() == "-1") {
      addressID = defaultAddress.value.id.toString();
    } else {
      addressID = "${getAddressApiModal.value.data![index].id}";
    }

    print("sdfsadfsdfsdf $addressID");
    await ApiClient.defualtAddressApi(address_id: addressID).then((value) {
      printData("Value $value");
      if (value != null) {
        getAddressData();
        // if (defaultAddress.value.address == null) {
        //   defaultAddress.value = getAddressApiModal.value.data![index];
        //   defaultAddress.value.isDefault = 1;
        //   getAddressApiModal.value.data!.removeAt(index);
        //   update();
        // } else {
        //   var data = getAddressApiModal.value.data![index];
        //   if (getAddressApiModal.value.data!.isNotEmpty) {
        //     getAddressApiModal.value.data![index] = defaultAddress.value;
        //   } else {
        //     getAddressApiModal.value.data!.removeAt(index);
        //   }
        //   defaultAddress.value = data;
        //   update();
        // }
      }
    }).whenComplete(() {
      Get.back();
    });
  }

  getAddressData() async {
    isLoading.value = true;
    defaultAddress = AddressData().obs;
    await ApiClient.getAddressApiModal().then((value) {
      if (value != null) {
        getAddressApiModal.value = value;

        if (getAddressApiModal.value.data != null) {
          if (getAddressApiModal.value.data!.isNotEmpty) {
            for (var i = 0; i < getAddressApiModal.value.data!.length; i++) {
              if (getAddressApiModal.value.data![i].isDefault.toString() == "1") {
                defaultAddress.value = getAddressApiModal.value.data![i];
                getAddressApiModal.value.data!.removeAt(i);
                break;
              }
            }
          }
        }
      }
      isLoading.value = false;
      update();
    });
  }

  updateAddressValue(json) async {
    isEditing.value = true;
    buttonText.value = 'Update Address';
    await Get.toNamed(Routes.ADD_ADDRESS_SCREEN, arguments: json, parameters: {
      'isEnabled': 'true',
    })!
        .then((value) {
      printData("$value");
      if (value != null) {
        getAddressData();
      }
    });
    isEditing.value = false;
  }

  void removeAddress(int index) async {
    showLoadingDialog();
    String addressID = "";
    if (index == -1) {
      addressID = "${defaultAddress.value.id}";
    } else {
      addressID = "${getAddressApiModal.value.data![index].id} ";
    }

    await ApiClient.removeAddressApi(address_id: addressID).then((response) {
      if (response == true) {
        defaultAddress.value = AddressData();
        Get.back();
        getAddressData();
        update();
      }
    }).whenComplete(() {});
  }

  showLoadingDialog() {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(
          color: appColors.darkYellowColor,
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future<dynamic> showAlertDialog(BuildContext context) {
    return Get.dialog(AlertDialog(
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
                'Remove Address',
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
              'you want to remove address?',
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
  }
}
