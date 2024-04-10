import 'package:akalsahae/app/modules/FAQ/faq_screen.dart';
import 'package:akalsahae/app/routes/app_pages.dart';
import 'package:akalsahae/app/utils/common_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:akalsahae/app/modules/more_screen_module/more_screen_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreScreenPage extends GetView<MoreScreenController> {
  final moreController = Get.put<MoreScreenController>(MoreScreenController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: moreController,
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black,
              toolbarHeight: 0.h,
              bottom: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.black,
                title: Text('more'.tr,
                    style: TextStyle(
                        color: moreController.appColors.whiteColor,
                        fontSize: 14.sp,
                        fontFamily: "Poppins")),
                centerTitle: true,
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.5.w, vertical: 1.5.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Uri openUrl = Uri.parse(
                              'https://nexever.tech/AkalSahae/terms_condition');
                          CommonMethods().openUrl(openUrl);
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 2.w, right: 3.w),
                          width: 87.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.sp),
                            color: moreController.appColors.lightBlackColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 3.w),
                                  SvgPicture.asset(
                                    'assets/images/profile.svg',
                                    width: 6.5.w,
                                  ),
                                  SizedBox(width: 2.w),
                                  Text(
                                    'term_and_condition'.tr,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: "Arial",
                                        color: moreController
                                            .appColors.greenColor),
                                  ),
                                ],
                              ),
                              Icon(Icons.arrow_forward_ios_outlined,
                                  color: moreController.appColors.whiteColor,
                                  size: 12.sp),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Uri openUrl = Uri.parse(
                              'https://nexever.tech/AkalSahae/privacy-policy');
                          CommonMethods().openUrl(openUrl);
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 2.w, right: 3.w),
                          width: 87.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.sp),
                            color: moreController.appColors.lightBlackColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 3.w),
                                  SvgPicture.asset(
                                    'assets/images/policyIcon.svg',
                                    width: 7.w,
                                  ),
                                  SizedBox(width: 3.w),
                                  Text(
                                    'privacy_policy'.tr,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: "Arial",
                                        color: moreController
                                            .appColors.lightYellowColor),
                                  ),
                                ],
                              ),
                              Icon(Icons.arrow_forward_ios_outlined,
                                  color: moreController.appColors.whiteColor,
                                  size: 12.sp),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Uri openUrl = Uri.parse(
                              'https://nexever.tech/AkalSahae/SupportService');
                          CommonMethods().openUrl(openUrl);
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 2.w, right: 3.w),
                          width: 87.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.sp),
                            color: moreController.appColors.lightBlackColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 3.w),
                                  SvgPicture.asset(
                                    'assets/images/supportIcon.svg',
                                    width: 7.w,
                                  ),
                                  SizedBox(width: 3.w),
                                  Text(
                                    '24/7_support'.tr,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: "Arial",
                                        color: moreController
                                            .appColors.purpleColor),
                                  ),
                                ],
                              ),
                              Icon(Icons.arrow_forward_ios_outlined,
                                  color: moreController.appColors.whiteColor,
                                  size: 12.sp),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          Uri openUrl = Uri.parse(
                              'https://nexever.tech/AkalSahae/AboutUs');
                          CommonMethods().openUrl(openUrl);
                          // final Uri url = Uri.parse('https://nexever.tech/AkalSahae/AboutUs');
                          // if (!await launchUrl(url)) {
                          //   throw Exception('Could not launch $url');
                          // }
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 1.w, right: 3.w),
                          width: 87.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.sp),
                            color: moreController.appColors.lightBlackColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 3.w),
                                  SvgPicture.asset(
                                    'assets/images/AboutUs.svg',
                                    width: 7.w,
                                  ),
                                  SizedBox(width: 3.w),
                                  Text(
                                    'about_us'.tr,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: "Arial",
                                        color: moreController
                                            .appColors.orangeColor),
                                  ),
                                ],
                              ),
                              Icon(Icons.arrow_forward_ios_outlined,
                                  color: moreController.appColors.whiteColor,
                                  size: 12.sp),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          Uri openUrl =
                              Uri.parse('https://nexever.tech/AkalSahae/faqs');
                          CommonMethods().openUrl(openUrl);
                          // final Uri url = Uri.parse('https://nexever.tech/AkalSahae/faqs');
                          // if (!await launchUrl(url)) {
                          // throw Exception('Could not launch $url');
                          // }
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 2.5.w, right: 3.w),
                          width: 87.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.sp),
                            color: moreController.appColors.lightBlackColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 2.w),
                                  SvgPicture.asset(
                                    'assets/images/FAQIcon.svg',
                                    width: 7.w,
                                  ),
                                  SizedBox(width: 3.w),
                                  Text(
                                    'faq'.tr,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: "Arial",
                                        color:
                                            moreController.appColors.blueColor),
                                  ),
                                ],
                              ),
                              Icon(Icons.arrow_forward_ios_outlined,
                                  color: moreController.appColors.whiteColor,
                                  size: 12.sp),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Uri openUrl = Uri.parse(
                              'https://nexever.tech/AkalSahae/RefundPolicy');
                          CommonMethods().openUrl(openUrl);
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 2.5.w, right: 3.w),
                          width: 87.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.sp),
                            color: moreController.appColors.lightBlackColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 1.5.w),
                                  SvgPicture.asset(
                                      'assets/images/logoutIcon.svg',
                                      width: 7.w),
                                  SizedBox(width: 3.w),
                                  Text(
                                    'refund_policy'.tr,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: "Arial",
                                        color:
                                            moreController.appColors.skyColor),
                                  ),
                                ],
                              ),
                              Icon(Icons.arrow_forward_ios_outlined,
                                  color: moreController.appColors.whiteColor,
                                  size: 12.sp),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Text(
                    "Akal Sahae",
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: moreController.appColors.grayColor),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "v${moreController.appversion}",
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: moreController.appColors.grayColor),
                      ),
                      Text(
                        " (${moreController.appbuildNumber})",
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: moreController.appColors.grayColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
