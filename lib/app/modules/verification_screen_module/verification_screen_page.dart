import 'package:akalsahae/app/apiCollection/api_client.dart';
import 'package:akalsahae/app/modules/verification_screen_module/verification_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sms_autofill/sms_autofill.dart';

class VerificationScreenPage extends GetView<VerificationScreenController> {
  final verificationScreenController = Get.find<VerificationScreenController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: verificationScreenController,
        builder: (_) {
          return WillPopScope(
            onWillPop: () {
              verificationScreenController.stopLoadingDialog();
              verificationScreenController.update();
              // ignore: null_check_always_fails
              return null!;
            },
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: Scaffold(
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Image.asset(
                          "assets/images/logo 1.png",
                          width: 60.w,
                        ),
                        SizedBox(
                          height: 7.7.h,
                        ),
                        Text(
                          'otp_verification'.tr,
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: verificationScreenController.appColors.whiteColor,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins"),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'we_have_sent_code_verification_to_your_mobile_number'.tr,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: verificationScreenController.appColors.lightgrayColor,
                              fontFamily: "Poppins"),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 2.4.h,
                        ),
                        Text(
                          '${verificationScreenController.loginArguments['countryCode'] + "\t" + verificationScreenController.loginArguments['phoneNumber']}',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: verificationScreenController.appColors.whiteColor,
                              fontFamily: "Poppins"),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'please_enter_your_code_here'.tr,
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 12.sp,
                              color: verificationScreenController.appColors.lightgrayColor),
                        ),
                        SizedBox(
                          height: 3.3.h,
                        ),
                        SizedBox(
                          height: 14.5.w,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: PinFieldAutoFill(
                              autoFocus: true,
                              controller: verificationScreenController.otpController,
                              cursor: Cursor(
                                  color: verificationScreenController.appColors.whiteColor,
                                  width: 0.5.w,
                                  enabled: true),
                              currentCode: verificationScreenController.enteredOtpCode,
                              decoration: BoxLooseDecoration(
                                  textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      color: verificationScreenController.appColors.whiteColor,
                                      fontWeight: FontWeight.w500),
                                  gapSpace: 1.9.w,
                                  bgColorBuilder:
                                      FixedColorBuilder(verificationScreenController.appColors.textfieldBoxColor),
                                  radius: Radius.circular(3.sp),
                                  strokeColorBuilder:
                                      FixedColorBuilder(verificationScreenController.appColors.textfieldBoxColor)),
                              codeLength: 6,
                              onCodeChanged: (code) {
                                print("OnCodeChanged : $code");
                                verificationScreenController.enteredOtpCode = code.toString();
                                verificationScreenController.update();
                                if (code!.length == 6) {
                                  //FocusManager.instance.primaryFocus?.unfocus();
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
                          "i_didn't_recive_a_code".tr,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: verificationScreenController.appColors.lightgrayColor,
                              fontFamily: "Poppins"),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: verificationScreenController.remainingSeconds == 0
                                  ? () {
                                      FocusManager.instance.primaryFocus!.unfocus();
                                      if (verificationScreenController.remainingSeconds == 0) {
                                        verificationScreenController.remainingSeconds = 59;
                                        verificationScreenController.update();
                                        verificationScreenController.startTimer();
                                        verificationScreenController.clearOtpController();
                                        verificationScreenController.resendOtp();
                                      }
                                    }
                                  : () {},
                              child: Text(
                                'resend_code'.tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11.5.sp,
                                    color: verificationScreenController.remainingSeconds == 0
                                        ? verificationScreenController.appColors.darkYellowColor
                                        : verificationScreenController.appColors.whiteColor,
                                    fontFamily: "Poppins",
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                            if(verificationScreenController.remainingSeconds>0)
                            Text(
                              "  00:${verificationScreenController.remainingSeconds.toString().padLeft(2, "0")}",
                              style: TextStyle(
                                  fontSize: 11.5.sp, color: verificationScreenController.appColors.darkYellowColor),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        SizedBox(
                          width: 88.w,
                          height: 7.h,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: verificationScreenController.appColors.darkYellowColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.sp))),
                              onPressed: () async {
                                FocusManager.instance.primaryFocus!.unfocus();
                                if (verificationScreenController.otpController.value.text.trim().isNotEmpty) {
                                  verificationScreenController.verifyOTP();
                                } else {
                                  ApiClient.toAst("Please enter your OTP code");
                                }
                              },
                              child: Text(
                                'verify_now'.tr,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: verificationScreenController.appColors.blackColor,
                                    fontFamily: "Poppins"),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
