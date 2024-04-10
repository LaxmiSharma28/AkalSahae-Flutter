import 'package:akalsahae/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'edit_profile_controller.dart';

class VerifyEmailOtpScreen extends StatelessWidget {
  VerifyEmailOtpScreen({super.key});

  EditProfileController editProfileController = Get.find();
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        toolbarHeight: 3.h,
        bottom: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Text('Verify OTP'.tr,
              style:
              TextStyle(color: editProfileController.appColors.whiteColor, fontSize: 14.sp, fontFamily: "Poppins")),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              size: 12.sp,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.5.w, vertical: 1.5.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 2.h,
              ),
              Text(
                "You will get an OTP via Email",
                style:
                TextStyle(color: editProfileController.appColors.whiteColor, fontSize: 14.sp, fontFamily: "Poppins"),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "Enter the OTP sent to",
                style:
                TextStyle(color: editProfileController.appColors.whiteColor, fontSize: 12.sp, fontFamily: "Poppins"),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "raj@yopmail.com",
                style: TextStyle(
                    color: editProfileController.appColors.darkYellowColor, fontSize: 12.sp, fontFamily: "Poppins"),
              ),
              SizedBox(
                height: 4.h,
              ),
              SizedBox(
                height: 14.5.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: PinFieldAutoFill(
                    autoFocus: true,
                    controller: otpController,
                    cursor: Cursor(color: editProfileController.appColors.whiteColor, width: 0.5.w, enabled: true),
                    //currentCode: verificationScreenController.enteredOtpCode,
                    decoration: BoxLooseDecoration(
                        textStyle: TextStyle(
                            fontSize: 14.sp,
                            color: editProfileController.appColors.whiteColor,
                            fontWeight: FontWeight.w500),
                        gapSpace: 1.9.w,
                        bgColorBuilder: FixedColorBuilder(editProfileController.appColors.textfieldBoxColor),
                        radius: Radius.circular(3.sp),
                        strokeColorBuilder: FixedColorBuilder(editProfileController.appColors.textfieldBoxColor)),
                    codeLength: 6,
                    onCodeChanged: (code) {
                      print("OnCodeChanged : $code");
                      // verificationScreenController.enteredOtpCode = code.toString();
                      // verificationScreenController.update();
                      if (code!.length == 6) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      }
                    },
                    onCodeSubmitted: (val) {
                      print("OnCodeSubmitted : $val");
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 3.3.h,
              ),
              Text(
                "Didn't get the OTP ?".tr,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: editProfileController.appColors.lightgrayColor,
                    fontFamily: "Poppins"),
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                'resend_code'.tr,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.5.sp,
                    color: editProfileController.appColors.darkYellowColor,
                    fontFamily: "Poppins",
                    decoration: TextDecoration.underline),
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.offNamed(Routes.PROFILE_SCREEN);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 7.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.sp), color: editProfileController.appColors.lightgreenColor),
                  child: Padding(
                    padding: EdgeInsets.only(top: 0.3.h),
                    child: Text(
                      'Done'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13.sp,
                          color: editProfileController.appColors.whiteColor,
                          fontFamily: "Arial"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
