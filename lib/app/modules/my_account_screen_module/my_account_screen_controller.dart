import 'package:akalsahae/app/apiCollection/api_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../helper_widget/colors.dart';
import '../../routes/app_pages.dart';
import '../../utils/shared_preferences_helper.dart';
import 'Log_Out_Api_modal.dart';

class MyAccountScreenController extends GetxController {
  AppColors appColors = AppColors();
  Rx<LogOutApiModal> logOutApiModal = LogOutApiModal().obs;
  RxBool isLoading = false.obs;

  logOutData() async {
    try {
      isLoading.value = true;
      await ApiClient.logOutApi().then((response) {
        if (response != null) {
          logOutApiModal.value = response;
          if (logOutApiModal.value.success == true) {
            SharePreferencesHelper.clear();
            ApiClient.toAst("Logged Out Successfully");
            Get.offAllNamed(Routes.LOGIN_SCREEN);
          }
        }
      });
      isLoading.value = false;
    } catch (err) {
      print("Error: $err");
    }
  }

  void showAlertDialog() {
    Get.dialog(AlertDialog(
      scrollable: true,
      backgroundColor: appColors.lightBlackColor,
      /*actions: [
        ElevatedButton(
            onPressed: () {
              logOutData();
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, elevation: 0),
            child: Text('yes'.tr, style: TextStyle(fontSize: 14.sp, color: appColors.blackColor))),
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, elevation: 0),
            child: Text('no'.tr, style: TextStyle(fontSize: 14.sp, color: appColors.darkYellowColor))),
      ],*/
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.sp)),
      // title: Center(
      //   child: Text(
      //     'Akal Sahae',
      //     style: TextStyle(fontSize: 15.sp, color: appColors.whiteColor),
      //   ),
      // ),
      content: Container(
        //height: 20.h,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: appColors.lightBlackColor),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                'Log Out',
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
              'you want to logout?',
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
                    logOutData();
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
