import 'dart:io';
import 'package:akalsahae/app/routes/app_pages.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import '../../utils/common_methods.dart';
import 'profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = Get.put(ProfileController());

  late bool permissionStatus;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.getProfileData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          toolbarHeight: 0.h,
          bottom: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            title: Text('Profile'.tr,
                style: TextStyle(
                    color: profileController.appColors.whiteColor,
                    fontSize: 14.sp,
                    fontFamily: "Poppins")),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 15.sp,
              ),
              onPressed: () {
                Get.toNamed(Routes.BOTTOM_SCREEN);
                //Get.back();
              },
            ),
          ),
        ),
        body: profileController.isLoading.isTrue
            ? Center(
                child: CircularProgressIndicator(
                  color: profileController.appColors.darkYellowColor,
                ),
              )
            : Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 6.5.w, vertical: 1.5.h),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: 14),
                          Center(
                            child: GestureDetector(
                              onTap: () {},
                              child: CircleAvatar(
                                radius: 57,
                                backgroundColor:
                                    profileController.appColors.lightgrayColor,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 110,
                                  width: 110,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(70),
                                      color: profileController
                                          .appColors.textfieldBoxColor),
                                  padding: EdgeInsets.all(0.sp),
                                  child: Obx(
                                    () {
                                      return profileController
                                              .editProfileController
                                              .fileName
                                              .value
                                              .isNotEmpty
                                          ? Image.network(
                                              profileController
                                                  .editProfileController
                                                  .fileName
                                                  .value,
                                              fit: BoxFit.cover,
                                              height: Get.height,
                                              width: Get.width,
                                            )
                                          : Icon(
                                              Icons.person,
                                              size: 50,
                                              color: profileController
                                                  .editProfileController
                                                  .appColors
                                                  .grayColor,
                                            );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Name",
                            style: TextStyle(
                                color: profileController.appColors.whiteColor,
                                fontSize: 12.sp,
                                fontFamily: "Poppins"),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            profileController.nameController.value.text,
                            style: TextStyle(
                                color: profileController.appColors.whiteColor,
                                fontFamily: "Poppins",
                                fontSize: 13.sp),
                          ),
                          Divider(
                            color: profileController.appColors.lightgrayColor,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            "Phone Number",
                            style: TextStyle(
                                color: profileController.appColors.whiteColor,
                                fontSize: 12.sp,
                                fontFamily: "Poppins"),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Obx(
                            () => Text(
                              "${profileController.countryCode.value}\t${profileController.phoneController.value.text}",
                              style: TextStyle(
                                  color: profileController.appColors.whiteColor,
                                  fontFamily: "Poppins",
                                  fontSize: 13.sp),
                            ),
                          ),
                          Divider(
                            color: profileController.appColors.lightgrayColor,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          if(profileController.emailController.value.text.isNotEmpty)
                            Text(
                            "Email",
                            style: TextStyle(
                                color: profileController.appColors.whiteColor,
                                fontSize: 12.sp,
                                fontFamily: "Poppins"),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          if(profileController.emailController.value.text.isNotEmpty)
                            Obx(
                            () => Text(
                              profileController.emailController.value.text,
                              style: TextStyle(
                                  color: profileController.appColors.whiteColor,
                                  fontFamily: "Poppins",
                                  fontSize: 13.sp),
                            ),
                          ),
                          if(profileController.emailController.value.text.isNotEmpty)
                            Divider(
                            color: profileController.appColors.lightgrayColor,
                          ),
                          if(profileController.emailController.value.text.isNotEmpty)
                            SizedBox(
                            height: 10.h,
                          ),
                          GestureDetector(
                            onTap: () async {
                              Get.toNamed(
                                Routes.EDIT_PROFILE_SCREEN,
                                arguments: {
                                  "email": profileController
                                      .emailController.value.text
                                      .trim(),
                                  "phone": profileController
                                      .phoneController.value.text
                                      .trim(),
                                  "name": profileController
                                      .nameController.value.text
                                      .trim(),
                                  "profile_image": profileController
                                      .editProfileController.fileName.value,
                                  "code": profileController.countryCode.value
                                },
                              )!.then((value){
                                if(value!=null){
                                profileController.getProfileData();
                                }
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 7.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.sp),
                                  color: profileController
                                      .appColors.lightgreenColor),
                              child: Padding(
                                padding: EdgeInsets.only(top: 0.3.h),
                                child: Text(
                                  'Edit Profile'.tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13.sp,
                                      color: profileController
                                          .appColors.whiteColor,
                                      fontFamily: "Arial"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
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
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    color: profileController.appColors.darkYellowColor,
                    child: Text(
                      "Akal Sahae",
                      style: TextStyle(
                          color: profileController.appColors.whiteColor,
                          fontFamily: "Poppins",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 18, right: 18, top: 10),
                    child: Text(
                      "-Camera permission to access your camera to upload profile picture.",
                      style: TextStyle(
                          color: profileController.appColors.grayColor,
                          fontFamily: "Poppins",
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18, right: 18, top: 10, bottom: 10),
                    child: Text(
                      "-Media and Storage permission to access photos and media on your device to fetch and save photos.",
                      style: TextStyle(
                          color: profileController.appColors.grayColor,
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
                              final deviceInfo =
                                  await DeviceInfoPlugin().androidInfo;
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
                                  Future.delayed(const Duration(seconds: 1),
                                      () {
                                    openAppSettings();
                                  });
                                }
                              } else {
                                if (deviceInfo.version.sdkInt > 32) {
                                  permissionStatus = await Permission.photos
                                      .request()
                                      .isGranted;
                                } else {
                                  permissionStatus = await Permission.storage
                                      .request()
                                      .isGranted;
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
                                color:
                                    profileController.appColors.darkYellowColor,
                              ),
                              child: Text(
                                "Ok",
                                style: TextStyle(
                                    color:
                                        profileController.appColors.whiteColor,
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
                                color: profileController.appColors.greenColor,
                              ),
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color:
                                        profileController.appColors.whiteColor,
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
                                color: profileController.appColors.grayColor,
                                fontFamily: "Poppins",
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500),
                            children: [
                          const TextSpan(
                            text:
                                "By Continuing, you are agree to Akal Sahae's ",
                          ),
                          TextSpan(
                            text: "term_&_conditon".tr,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Uri openUrl = Uri.parse(
                                    'https://nexever.tech/AkalSahae/terms_condition');
                                CommonMethods().openUrl(openUrl);
                              },
                            style: TextStyle(
                                color:
                                    profileController.appColors.darkYellowColor,
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
                                  Uri openUrl = Uri.parse(
                                      'https://nexever.tech/AkalSahae/privacy-policy');
                                  CommonMethods().openUrl(openUrl);
                                },
                              style: TextStyle(
                                  color: profileController
                                      .appColors.darkYellowColor,
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
                    padding: const EdgeInsets.only(
                        left: 18, right: 18, top: 10, bottom: 10),
                    child: Text(
                      "-By tapping OK, you are agree to provide Akal Sahae the above mentioned permissions for the normal use of the app.",
                      style: TextStyle(
                          color: profileController.appColors.grayColor,
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
      Get.toNamed(Routes.EDIT_PROFILE_SCREEN);
    });
  }
}
