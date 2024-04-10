import 'dart:io';
import 'package:akalsahae/app/apiCollection/api_client.dart';
import 'package:akalsahae/app/modules/home_screen_module/GetCategoryApiModal.dart';
import 'package:akalsahae/app/modules/shop_screen_module/shop_screen_controller.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../../helper_widget/colors.dart';

import '../../../helper_widget/hexcolor.dart';
import '../../utils/common_methods.dart';

class HomeScreenController extends GetxController {
  ClothType selectedCloth = ClothType();

  AppColors appColors = AppColors();
  Rx<GetCategoryApiModal> getCategoryApiModal = GetCategoryApiModal().obs;
  RxBool isLoading = false.obs;
  RxInt counter = 0.obs;

  var colors = [
    HexColor("B9770A"),
    HexColor("973362"),
    HexColor("1394AE"),
    HexColor("1F51B7"),
    HexColor("FFA601"),
    HexColor("D50002")
  ];

  getHomeCategory({bool fromHomeScreen = true}) async {
    if (fromHomeScreen) {
      isLoading.value = true;
    }
    var resultColor = await ApiClient.getHomeData();
    if (resultColor == true) {}
    isLoading.value = false;
  }

  late bool permissionStatus;

  @override
  void onInit() {
    getHomeCategory();
    super.onInit();
  }

  @override
  void dispose() {
    ShopScreenController().dispose();
    super.dispose();
  }

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
                    color: appColors.darkYellowColor,
                    child: Text(
                      "Akal Sahae",
                      style: TextStyle(
                          color: appColors.whiteColor,
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
                          color: appColors.grayColor,
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
                          color: appColors.grayColor,
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
                                color: appColors.darkYellowColor,
                              ),
                              child: Text(
                                "Ok",
                                style: TextStyle(
                                    color: appColors.whiteColor,
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
                                color: appColors.greenColor,
                              ),
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: appColors.whiteColor,
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
                                color: appColors.grayColor,
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
                                color: appColors.darkYellowColor,
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
                                  color: appColors.darkYellowColor,
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
                          color: appColors.grayColor,
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
    }));
  }
}

/*  void showOptionDialog() {
    Get.dialog(StatefulBuilder(builder: (context, StateSetter setState) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      color: appColors.darkYellowColor,
                      child: Text(
                        "Akal Sahae",
                        style: TextStyle(
                            color: appColors.whiteColor,
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
                            color: appColors.grayColor,
                            fontFamily: "Poppins",
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18, top: 10),
                      child: Text(
                        "-Media and Storage permission to access photos and media on your device to fetch and save photos.",
                        style: TextStyle(
                            color:appColors.grayColor,
                            fontFamily: "Poppins",
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18, top: 10, bottom: 10),
                      child: Text(
                        "-By tapping OK, you are agree to provide Akal Sahae the above mentioned permissions for the normal use of the app.",
                        style: TextStyle(
                            color: appColors.grayColor,
                            fontFamily: "Poppins",
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
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
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: MediaQuery.of(context).size.width / 4,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: appColors.darkYellowColor,
                              ),
                              child: Text(
                                "Ok",
                                style: TextStyle(
                                    color: appColors.whiteColor,
                                    fontFamily: "Poppins",
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: MediaQuery.of(context).size.width / 4,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color:appColors.greenColor,
                              ),
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: appColors.whiteColor,
                                    fontFamily: "Poppins",
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(18, 10, 18, 0),
                      child: RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: appColors.grayColor,
                                  fontFamily: "Poppins",
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w500),
                              children: [
                                TextSpan(
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
                                      color: appColors.darkYellowColor,
                                      fontFamily: "Poppins",
                                      fontSize: 11.sp,
                                      decoration: TextDecoration.underline),
                                ),
                                TextSpan(
                                  text: ".",
                                ),
                                TextSpan(
                                  text: "".tr,
                                  recognizer: TapGestureRecognizer(),
                                ),
                              ])),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(18, 10, 18, 0),
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color:appColors.grayColor,
                                fontFamily: "Poppins",
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500),
                            children: [
                              TextSpan(
                                text: "By Continuing, you are agree to Akal Sahae's ",
                              ),
                              TextSpan(
                                text: "".tr,
                                recognizer: TapGestureRecognizer(),
                              ),
                              TextSpan(
                                  text: "privacy_policy".tr,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Uri openUrl = Uri.parse('https://nexever.tech/AkalSahae/privacy-policy');
                                      CommonMethods().openUrl(openUrl);
                                    },
                                  style: TextStyle(
                                      color: appColors.darkYellowColor,
                                      fontFamily: "Poppins",
                                      fontSize: 11.sp,
                                      decoration: TextDecoration.underline)),
                              TextSpan(
                                text: ".",
                              ),
                            ]),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }));
  }*/
