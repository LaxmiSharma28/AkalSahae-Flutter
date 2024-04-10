import 'dart:io';
import 'package:akalsahae/app/modules/favorite_screen_module/favorite_screen_controller.dart';
import 'package:akalsahae/app/modules/home_screen_module/drag_image.dart';
import 'package:akalsahae/app/modules/home_screen_module/home_screen_controller.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../utils/common_methods.dart';
import '../../utils/shared_preferences_helper.dart';
import '../../utils/shared_prefs_keys.dart';
import '../favorite_screen_module/favorite_screen_page.dart';
import '../home_screen_module/home_screen_page.dart';
import '../more_screen_module/more_screen_page.dart';
import '../my_account_screen_module/my_account_screen_page.dart';
import 'bottom_screen_controller.dart';
import 'package:badges/badges.dart' as badges;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class BottomScreenPage extends GetView<BottomScreenController> {
  final homeScreenController = Get.put(HomeScreenController());
  final favContoller = Get.put(FavoriteScreenController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {

        if(controller.index.value==0){
          _showExitConfirmation();
        }else{
          controller.index.value=0;
        }
        return false;
        // return await _showExitConfirmation().then((value) {
        //   if (value == true) {
        //     return exit(0);
        //   } else {
        //     return false;
        //   }
        // });
      },
      child: GetBuilder(
          init: homeScreenController,
          builder: (context) {
            return Obx(() => DefaultTabController(
                  length: 4,
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
                    floatingActionButton: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, // circular shape
                          image: DecorationImage(image: AssetImage('assets/images/CircleColor.png'))),
                      height: 17.h,
                      width: 19.w,
                      child: FloatingActionButton(
                        onPressed: () async {
                          if (await SharePreferencesHelper.getString(SharedPrefKeys.IS_FIRST_TIME) == "true") {
                            SharePreferencesHelper.setString(SharedPrefKeys.IS_FIRST_TIME, "false");
                            showOptionDialog();
                          } else {
                            //getImageFromCamera();
                            controller.onWillPop();
                          }
                        },
                        elevation: 0,
                        child: Container(
                          width: 20.w,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, // circular shape
                              image: DecorationImage(image: AssetImage('assets/images/CircleColor.png'))),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5.5.h,
                              ),
                              Image.asset(
                                "assets/images/Trynow.png",
                                height: 4.2.h,
                              ),
                              Text('try_now'.tr,
                                  style: TextStyle(
                                      fontSize: 9.sp,
                                      color: homeScreenController.appColors.whiteColor,
                                      fontFamily: "Arial",
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    bottomNavigationBar: BottomAppBar(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        height: 9.5.h,
                        notchMargin: 5.sp,
                        shape: const CircularNotchedRectangle(),
                        color: homeScreenController.appColors.grayColor,
                        child: Container(
                          alignment: Alignment.center,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    controller.selectedTab(0);
                                    homeScreenController.getHomeCategory();
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/images/ShopIcon.svg",
                                        width: 27,
                                        height: 27,
                                        color: controller.getTabIconColor(0),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text('shop'.tr,
                                          style: TextStyle(
                                              color: controller.getTabIconColor(0),
                                              fontSize: 13,
                                              fontFamily: "Arial",
                                              fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    controller.selectedTab(1);
                                    favContoller.getFavList();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        (favContoller.favList.value.favorites ?? []).isNotEmpty
                                            ? badges.Badge(
                                                badgeStyle: const badges.BadgeStyle(
                                                    badgeColor: Colors.red, padding: EdgeInsets.fromLTRB(8, 5, 8, 5)),
                                                position: badges.BadgePosition.topEnd(end: -6),
                                                badgeAnimation: const badges.BadgeAnimation.scale(),
                                                badgeContent: Obx(
                                                  () => Text(
                                                    (favContoller.favList.value.favorites ?? []).length.toString(),
                                                    style: TextStyle(
                                                        color: homeScreenController.appColors.whiteColor,
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                                child: SvgPicture.asset(
                                                  "assets/images/FavIcon.svg",
                                                  width: 25,
                                                  height: 25,
                                                  color: controller.getTabIconColor(1),
                                                ))
                                            : SvgPicture.asset(
                                                "assets/images/FavIcon.svg",
                                                width: 25,
                                                height: 25,
                                                color: controller.getTabIconColor(1),
                                              ),
                                        SizedBox(
                                          height: 0.9.h,
                                        ),
                                        Text(
                                          'favorite_'.tr,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontFamily: "Arial",
                                              color: controller.getTabIconColor(1),
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(),
                                const SizedBox(),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    controller.selectedTab(2);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 14.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/images/PersonIcon.svg",
                                          width: 27,
                                          height: 27,
                                          color: controller.getTabIconColor(2),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        Text(
                                          'my_account'.tr,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: controller.getTabIconColor(2),
                                              fontSize: 12,
                                              fontFamily: "Arial",
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    controller.selectedTab(3);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/images/MoreIcon.svg",
                                        width: 25,
                                        height: 25,
                                        color: controller.getTabIconColor(3),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        'more'.tr,
                                        style: TextStyle(
                                            color: controller.getTabIconColor(3),
                                            fontSize: 12,
                                            fontFamily: "Arial",
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                    body: Obx(() => Column(
                          children: [
                            if (controller.index.value == 0) Expanded(child: HomeScreenPage()),
                            if (controller.index.value == 1) const Expanded(child: FavoriteScreenPage()),
                            if (controller.index.value == 2) const Expanded(child: MyAccountScreenPage()),
                            if (controller.index.value == 3) Expanded(child: MoreScreenPage()),
                          ],
                        )),
                  ),
                ));
          }),
    );
  }

  Future<bool?> _showExitConfirmation() async {
    await Get.dialog(AlertDialog(
      scrollable: true,
      backgroundColor: homeScreenController.appColors.lightBlackColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.sp)),
      content: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: homeScreenController.appColors.lightBlackColor),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                'Warning',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: homeScreenController.appColors.whiteColor,
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
                color: homeScreenController.appColors.whiteColor,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(
              height: 0.5.h,
            ),
            Text(
              'You want to exit the App?',
              style: TextStyle(
                fontSize: 11.sp,
                color: homeScreenController.appColors.whiteColor,
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
                        border: Border.all(color: homeScreenController.appColors.darkYellowColor, width: 1),
                      ),
                      child: Text(
                        "NO",
                        style: TextStyle(
                            letterSpacing: 1.5,
                            color: homeScreenController.appColors.whiteColor,
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
                    if (Platform.isAndroid) {
                      SystemNavigator.pop();
                    } else if (Platform.isIOS) {
                      exit(0);
                    }
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
                        color: homeScreenController.appColors.darkYellowColor,
                      ),
                      child: Text(
                        "YES",
                        style: TextStyle(
                            letterSpacing: 1.5,
                            color: homeScreenController.appColors.whiteColor,
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
                    color: homeScreenController.appColors.darkYellowColor,
                    child: Text(
                      "Akal Sahae",
                      style: TextStyle(
                          color: homeScreenController.appColors.whiteColor,
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
                          color: homeScreenController.appColors.grayColor,
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
                          color: homeScreenController.appColors.grayColor,
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
                              controller.getImageFromCamera();
                              Get.back();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: homeScreenController.appColors.darkYellowColor,
                              ),
                              child: Text(
                                "Ok",
                                style: TextStyle(
                                    color: homeScreenController.appColors.whiteColor,
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
                                color: homeScreenController.appColors.greenColor,
                              ),
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: homeScreenController.appColors.whiteColor,
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
                                color: homeScreenController.appColors.grayColor,
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
                                color: homeScreenController.appColors.darkYellowColor,
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
                                  color: homeScreenController.appColors.darkYellowColor,
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
                          color: homeScreenController.appColors.grayColor,
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

  File? imageFile;

  /// Get from Camera
  getImageFromCamera() async {
    XFile? pickedFile;

    await Permission.camera.request();
    if (!await Permission.camera.isGranted) {
      openAppSettings();
    } else {
      pickedFile = await pickImage(fromCamera: true);
    }
    /* if (Platform.isIOS) {
      await Permission.camera.request();
      if (!await Permission.camera.isGranted) {
        openAppSettings();
      }
    } else {
      if (!await Permission.camera.isGranted) {
        openAppSettings();
      } else {
        pickedFile = await pickImage(fromCamera: true);
      }
    }*/

    
    /*  if (await Permission.photos.isPermanentlyDenied) {
      openAppSettings();
      return;
    } else if (await Permission.photos.isDenied) {
      var result = await Permission.photos.request();
      if (result.isGranted) {
        pickedFile = await pickImage(fromCamera: true);
      } else {
        openAppSettings();
      }
    } else {
      pickedFile = await pickImage(fromCamera: true);
    }*/
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      Get.to(() => DragImage(image: imageFile!.path));
    }
  }

  Future<XFile?> pickImage({bool fromCamera = true}) async {
    return await ImagePicker().pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
  }
}
