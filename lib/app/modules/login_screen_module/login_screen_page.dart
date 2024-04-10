import 'dart:io';
import 'package:akalsahae/app/modules/login_screen_module/login_screen_controller.dart';
import 'package:akalsahae/app/utils/common_methods.dart';
import 'package:country_list_pick/country_selection_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../helper_widget/country_Code.dart';

class LoginScreenPage extends GetView<LoginScreenController> {
  final loginScreenController = Get.find<LoginScreenController>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black));
    return GetBuilder(
        init: loginScreenController,
        builder: (context) {
          return Scaffold(
              body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 6.w,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 17.h,
                  ),
                  Image.asset('assets/images/logo 1.png', width: 60.w),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    "login_account".tr,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: loginScreenController.appColors.whiteColor,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "welcome_to_akal_sahae".tr,
                    style: TextStyle(
                        color: loginScreenController.appColors.lightgrayColor,
                        fontFamily: "Poppins",
                        fontSize: 12.5.sp),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "phone_number".tr,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: loginScreenController.appColors.whiteColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.sp),
                        color: loginScreenController.appColors.textfieldBoxColor),
                    height: 7.1.h,
                    width: 90.w,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.only(bottomLeft: Radius.circular(4.sp), topLeft: Radius.circular(4.sp)),
                              color: loginScreenController.appColors.textfieldBoxColor),
                          height: 7.1.h,
                          width: 30.w,
                          child: CountryListPick(
                            appBar: AppBar(
                                backgroundColor: Colors.grey[900],
                                elevation: 0,
                                centerTitle: true,
                                actions: [
                                  Padding(
                                      padding: EdgeInsets.only(top: 2.h, right: 4.w),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.back();
                                          // Get.offNamed(Routes.LOGIN_SCREEN);
                                        },
                                        child: Text(
                                          'Done',
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w700,
                                              color: loginScreenController.appColors.whiteColor),
                                        ),
                                      )),
                                ],
                                title: Text(
                                  'Country Code',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                      color: loginScreenController.appColors.whiteColor),
                                )),
                            theme: CountryTheme(
                              alphabetTextColor: Colors.white,
                              // containerColor: loginScreenController.appColors.textfieldBoxColor,
                              // backgroundColor: Colors.black,
                              labelColor: loginScreenController.appColors.whiteColor,
                              alphabetSelectedBackgroundColor: loginScreenController.appColors.darkYellowColor,
                              isShowFlag: true,
                              isShowTitle: false,
                              isShowCode: true,
                              isDownIcon: true,
                              showEnglishName: true,
                            ),
                            initialSelection: loginScreenController.selectedCountryCode.toString(),
                            onChanged: (ct) {
                              loginScreenController.onCountryChange(ct!);
                            },
                          ),
                        ),
                        VerticalDivider(
                          color: loginScreenController.appColors.dividerColor,
                          width: 1,
                          thickness: 1,
                          //indent: 0.3.h,
                        ),
                        SizedBox(
                          height: 7.1.h,
                          width: 55.w,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextFormField(
                              //keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(15),
                                FilteringTextInputFormatter.deny("."),
                                FilteringTextInputFormatter.deny("-")
                              ],
                              cursorColor: loginScreenController.appColors.darkYellowColor,
                              onChanged: (value) {
                                //  loginScreenController.validatePhoneNumber(value);
                                loginScreenController.phone = value;
                                loginScreenController.update();
                              },
                              style: TextStyle(
                                  color: loginScreenController.appColors.whiteColor,
                                  fontFamily: "Poppins",
                                  fontSize: 11.sp),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              controller: loginScreenController.textController,
                              decoration: InputDecoration(
                                filled: true,
                                contentPadding: EdgeInsets.only(left: 5.w),
                                isDense: true,
                                fillColor: loginScreenController.appColors.textfieldBoxColor,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(5.sp), bottomRight: Radius.circular(5.sp)),
                                    borderSide: BorderSide.none),
                                hintText: 'Phone',
                                hintStyle: TextStyle(
                                  fontSize: 12.sp,
                                  color: loginScreenController.appColors.whiteColor.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  /*  SizedBox(width:2.5.w), // Add spacing between TextFormField and error message
    Obx(() => Visibility(
    visible: loginScreenController.showError.value,
    child: Padding(
    padding:  EdgeInsets.only(top:2.h),
    child: Text(
    'Please enter a valid phone number',
    style: TextStyle(
    color: Colors.red,
    fontSize: 10.sp,
    ),
    ),
    ),
    ),
    ),*/
                  Row(
                    children: [
                      SizedBox(
                        width: 4.5.w,
                      ),
                      GestureDetector(
                        onTap: loginScreenController.toggleCheckbox,
                        child: Container(
                          width: 5.4.w,
                          height: 2.7.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.sp),
                            border: Border.all(
                              color: loginScreenController.isChecked.value
                                  ? loginScreenController.appColors.darkYellowColor
                                  : loginScreenController.appColors.whiteColor,
                              width: 0.5.w,
                            ),
                            color: loginScreenController.isChecked.value
                                ? loginScreenController.appColors.darkYellowColor
                                : Colors.transparent,
                          ),
                          child: loginScreenController.isChecked.value
                              ? Center(
                                  child: Icon(
                                    Icons.check_outlined,
                                    color: loginScreenController.appColors.blackColor,
                                    size: 11.5.sp,
                                  ),
                                )
                              : null,
                        ),
                      ),
                      SizedBox(
                        width: 1.5.w,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2.2.h),
                        child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: loginScreenController.appColors.whiteColor,
                                    fontFamily: "Poppins",
                                    fontSize: 9.5.sp,
                                    fontWeight: FontWeight.w500),
                                children: [
                              TextSpan(
                                text: "i_agree_to_the".tr,
                              ),
                              TextSpan(
                                text: "term_&_conditon".tr,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Uri openUrl = Uri.parse('https://nexever.tech/AkalSahae/terms_condition');
                                    CommonMethods().openUrl(openUrl);
                                  },
                                style: TextStyle(
                                    color: loginScreenController.appColors.darkYellowColor,
                                    fontFamily: "Poppins",
                                    fontSize: 9.5.sp,
                                    decoration: TextDecoration.underline),
                              ),
                              TextSpan(
                                text: "and_".tr,
                              ),
                              TextSpan(
                                  text: "privacy_policy".tr,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Uri openUrl = Uri.parse('https://nexever.tech/AkalSahae/privacy-policy');
                                      CommonMethods().openUrl(openUrl);
                                    },
                                  style: TextStyle(
                                      color: loginScreenController.appColors.darkYellowColor,
                                      fontFamily: "Poppins",
                                      fontSize: 9.5.sp,
                                      decoration: TextDecoration.underline)),
                              TextSpan(
                                text: ".",
                              ),
                            ])),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2.5.h,
                  ),
                  SizedBox(
                    width: 90.w,
                    height: 7.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: loginScreenController.appColors.darkYellowColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.sp))),
                      onPressed: () async {
                        FocusManager.instance.primaryFocus!.unfocus();
                        //loginScreenController.validateAndShowError();
                        loginScreenController.checkValue();
                      },
                      child: Text(
                        "login".tr,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: loginScreenController.appColors.blackColor,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(children: [
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.only(left: 27.w, right: 4.w),
                          child: Divider(
                            color: loginScreenController.appColors.whiteColor,
                          )),
                    ),
                    Text("or_".tr,
                        style: TextStyle(color: loginScreenController.appColors.whiteColor, fontSize: 12.sp)),
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.only(left: 4.w, right: 27.w),
                          child: Divider(
                            color: loginScreenController.appColors.whiteColor,
                          )),
                    ),
                  ]),
                  SizedBox(
                    height: 5.h,
                  ),
                  (Platform.isIOS)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                loginScreenController.checkGoogle();
                              },
                              child: Center(
                                child: CircleAvatar(
                                  radius: 22.sp,
                                  backgroundColor: loginScreenController.appColors.grayColor,
                                  child: Image.asset(
                                    "assets/images/Google_icon.png",
                                    height: 4.h,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15.sp,
                            ),
                            if (Platform.isIOS)
                              GestureDetector(
                                onTap: () {
                                  loginScreenController.checkApple();
                                  loginScreenController.update();
                                },
                                child: CircleAvatar(
                                  radius: 22.sp,
                                  backgroundColor: loginScreenController.appColors.grayColor,
                                  child: Image.asset(
                                    "assets/images/apple.png",
                                    height: 12.h,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                          ],
                        )
                      : GestureDetector(
                          onTap: () {
                            loginScreenController.checkGoogle();
                            // loginScreenController.signInWithGoogle();
                            // loginScreenController.socialLogin();
                            // loginScreenController.update();
                          },
                          child: Center(
                            child: CircleAvatar(
                              radius: 22.sp,
                              backgroundColor: loginScreenController.appColors.grayColor,
                              child: Image.asset(
                                "assets/images/Google_icon.png",
                                height: 4.h,
                              ),
                            ),
                          ),
                        ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     GestureDetector(
                  //       onTap: () {
                  //         loginScreenController.checkGoogle();
                  //         // loginScreenController.signInWithGoogle();
                  //         // loginScreenController.socialLogin();
                  //         // loginScreenController.update();
                  //       },
                  //       child: CircleAvatar(
                  //         radius: 22.sp,
                  //         backgroundColor: loginScreenController.appColors.grayColor,
                  //         child: Image.asset(
                  //           "assets/images/Google_icon.png",
                  //           height: 4.h,
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 15.sp,
                  //     ),
                  //     if(Platform.isIOS)
                  //     GestureDetector(
                  //       onTap: () {
                  //         loginScreenController.checkApple();
                  //         loginScreenController.update();
                  //       },
                  //       child: CircleAvatar(
                  //         radius: 22.sp,
                  //         backgroundColor: loginScreenController.appColors.grayColor,
                  //         child: Image.asset(
                  //           "assets/images/apple.png",
                  //           height: 12.h,
                  //           fit: BoxFit.fill,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          ));
        });
  }
}
