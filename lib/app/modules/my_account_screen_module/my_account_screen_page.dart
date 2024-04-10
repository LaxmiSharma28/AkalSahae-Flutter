import 'dart:io';
import 'package:akalsahae/app/modules/save_address_screen_module/save_address_screen_controller.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:akalsahae/app/modules/my_account_screen_module/my_account_screen_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import '../../routes/app_pages.dart';
import '../../utils/common_methods.dart';
import '../../utils/shared_preferences_helper.dart';
import '../../utils/shared_prefs_keys.dart';

class MyAccountScreenPage extends StatefulWidget {
  const MyAccountScreenPage({super.key});

  @override
  State<MyAccountScreenPage> createState() => _MyAccountScreenPageState();
}

class _MyAccountScreenPageState extends State<MyAccountScreenPage> {
  final myaccountController = Get.put<MyAccountScreenController>(MyAccountScreenController());
  SaveAddressScreenController saveAddressScreenController = Get.put(SaveAddressScreenController());

  @override
  void initState() {
    var phone = SharePreferencesHelper.getString(SharedPrefKeys.PHONE);
    var email = SharePreferencesHelper.getString(SharedPrefKeys.EMAIL);
    var token = SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    print(phone.toString());
    print(email.toString());
    print(token.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: myaccountController,
        builder: (_) {
          return NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.black,
                toolbarHeight: 0.h,
                bottom: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.black,
                  title: Text('my_account'.tr, style: TextStyle(fontSize: 12.sp, fontFamily: "Poppins")),
                  centerTitle: true,
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 2.h),
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (await SharePreferencesHelper.getString(SharedPrefKeys.IS_FIRST_TIME) == "true") {
                          SharePreferencesHelper.setString(SharedPrefKeys.IS_FIRST_TIME, "false");
                          showOptionDialog();
                        } else {
                          Get.toNamed(Routes.PROFILE_SCREEN);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 2.w, right: 3.w),
                        width: 88.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.sp),
                          color: myaccountController.appColors.lightBlackColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 4.w),
                                SvgPicture.asset(
                                  'assets/images/profile.svg',
                                  width: 7.w,
                                ),
                                SizedBox(width: 4.w),
                                Text('my_profile'.tr,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: "Arial",
                                        color: myaccountController.appColors.greenColor)),
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios_outlined,
                                color: myaccountController.appColors.whiteColor, size: 12.sp),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.MY_ORDER_SCREEN);
                      },
                      child: Container(
                          padding: EdgeInsets.only(left: 2.w, right: 3.w),
                          width: 88.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.sp),
                            color: myaccountController.appColors.lightBlackColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 4.w),
                                  SvgPicture.asset(
                                    'assets/images/policyIcon.svg',
                                    width: 7.w,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text('my_order'.tr,
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontFamily: "Arail",
                                          color: myaccountController.appColors.lightYellowColor)),
                                ],
                              ),
                              Icon(Icons.arrow_forward_ios_outlined, color: Colors.white, size: 12.sp),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        // saveAddressScreenController.isCheck.value = false;
                        Get.toNamed(Routes.SAVE_ADDRESS_SCREEN);
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 2.w, right: 3.w),
                        width: 88.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.sp),
                          color: myaccountController.appColors.lightBlackColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 4.w),
                                SvgPicture.asset(
                                  'assets/images/supportIcon.svg',
                                  width: 7.w,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  'my_address'.tr,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily: "Arial",
                                      color: myaccountController.appColors.purpleColor),
                                ),
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios_outlined,
                                color: myaccountController.appColors.whiteColor, size: 12.sp),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        myaccountController.showAlertDialog();
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 2.w, right: 3.w),
                        width: 88.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.sp),
                          color: myaccountController.appColors.lightBlackColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 4.w),
                                SvgPicture.asset(
                                  'assets/images/logoutIcon.svg',
                                  width: 7.w,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  'logout'.tr,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily: "Arial",
                                      color: myaccountController.appColors.skyColor),
                                ),
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios_outlined,
                                color: myaccountController.appColors.whiteColor, size: 12.sp),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  late bool permissionStatus;

  void showOptionDialog() {
    Get.dialog(StatefulBuilder(builder: (context, StateSetter setState) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        scrollable: true,
        contentPadding: EdgeInsets.zero,
        content: Column(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    color: myaccountController.appColors.darkYellowColor,
                    child: Text(
                      "Akal Sahae",
                      style: TextStyle(
                          color: myaccountController.appColors.whiteColor,
                          fontFamily: "Poppins",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18, top: 10),
                    child: Text(
                      "-Camera permission to access your camera to upload profile picture.",
                      style: TextStyle(
                          color: myaccountController.appColors.grayColor,
                          fontFamily: "Poppins",
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18, top: 10, bottom: 10),
                    child: Text(
                      "-Media and Storage permission to access photos and media on your device to fetch and save photos.",
                      style: TextStyle(
                          color: myaccountController.appColors.grayColor,
                          fontFamily: "Poppins",
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 45,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: () async {
                              Get.back();
                              final deviceInfo = await DeviceInfoPlugin().androidInfo;
                              await Permission.camera.request();
                              if (Platform.isIOS) {
                                await Permission.camera.request();
                                if (!await Permission.camera.isGranted) {
                                  openAppSettings();
                                }
                              } else {
                                if (!await Permission.camera.isGranted) {
                                  openAppSettings();
                                }
                              }
                              if (Platform.isIOS) {
                                await Permission.photos.request();
                                if (!await Permission.photos.isGranted) {
                                  Future.delayed(const Duration(seconds: 1), () {
                                    openAppSettings();
                                  });
                                }
                              } else {
                                if (deviceInfo.version.sdkInt > 32) {
                                  permissionStatus = await Permission.photos.request().isGranted;
                                } else {
                                  permissionStatus = await Permission.storage.request().isGranted;
                                }

                                if (deviceInfo.version.sdkInt > 32
                                    ? !await Permission.photos.isGranted
                                    : !await Permission.storage.isGranted) {
                                  openAppSettings();
                                }
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: myaccountController.appColors.darkYellowColor,
                              ),
                              child: Text(
                                "Ok",
                                style: TextStyle(
                                    color: myaccountController.appColors.whiteColor,
                                    fontFamily: "Poppins",
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: myaccountController.appColors.greenColor,
                              ),
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: myaccountController.appColors.whiteColor,
                                    fontFamily: "Poppins",
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
                    child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: myaccountController.appColors.grayColor,
                                fontFamily: "Poppins",
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500),
                            children: [
                          const TextSpan(
                            text: "By Continuing, you are agree to Akal Sahae's ",
                          ),
                          TextSpan(
                            text: "term_&_conditon".tr,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Uri openUrl = Uri.parse('https://nexever.tech/AkalSahae/terms_condition');
                                CommonMethods().openUrl(openUrl);
                              },
                            style: TextStyle(
                                color: myaccountController.appColors.darkYellowColor,
                                fontFamily: "Poppins",
                                fontSize: 11.sp,
                                decoration: TextDecoration.underline),
                          ),
                          const TextSpan(
                            text: "and",
                          ),
                          TextSpan(
                              text: "privacy_policy".tr,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Uri openUrl = Uri.parse('https://nexever.tech/AkalSahae/privacy-policy');
                                  CommonMethods().openUrl(openUrl);
                                },
                              style: TextStyle(
                                  color: myaccountController.appColors.darkYellowColor,
                                  fontFamily: "Poppins",
                                  fontSize: 11.sp,
                                  decoration: TextDecoration.underline)),
                          const TextSpan(
                            text: ".",
                          ),
                          TextSpan(
                            text: "".tr,
                            recognizer: TapGestureRecognizer(),
                          ),
                        ])),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18, top: 10, bottom: 10),
                    child: Text(
                      "-By tapping OK, you are agree to provide Akal Sahae the above mentioned permissions for the normal use of the app.",
                      style: TextStyle(
                          color: myaccountController.appColors.grayColor,
                          fontFamily: "Poppins",
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    })).then((value) {
      Get.toNamed(Routes.PROFILE_SCREEN);
    });
  }
}
