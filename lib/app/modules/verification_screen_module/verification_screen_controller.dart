import 'dart:async';
import 'package:akalsahae/app/modules/login_screen_module/login_screen_page.dart';
import 'package:akalsahae/app/modules/verification_screen_module/verification_modal.dart';
import 'package:akalsahae/app/utils/shared_prefs_keys.dart';
import 'package:akalsahae/helper_widget/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../helper_widget/colors.dart';
import '../../apiCollection/api_client.dart';
import '../../routes/app_pages.dart';
import '../../utils/shared_preferences_helper.dart';

class VerificationScreenController extends GetxController {
  AppColors appColors = AppColors();
  final Map<String, dynamic> loginArguments = Get.arguments;
  var otpFromApi = "";
  String enteredOtpCode = "";
  String otpType = "local";
  Timer? timer;
  int remainingSeconds = 59;
  bool isTimerClosed = false;
  String errorMessage = '';
  DeviceInfo deviceInfo = DeviceInfo();
  TextEditingController otpController = TextEditingController();
  String? verificationId;
  int resendToken = 0;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    otpType = loginArguments["otpType"] ?? "local";
    otpFromApi = loginArguments["otp"].toString();
    startTimer();
    _listenOtp();
    super.onInit();
  }

  @override
  void onClose() {
    SmsAutoFill().unregisterListener();
    super.onClose();
  }

  void _listenOtp() async {
    await SmsAutoFill().listenForCode();
    update();
  }

  void clearOtpController() {
    otpController.clear();
    update();
  }

  startTimer() {
    remainingSeconds = 59;
    const duration = Duration(seconds: 1);
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
    timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSeconds == 0) {
        print("Timer Out");
        isTimerClosed = true;
        timer.cancel();
      } else {
        isTimerClosed = false;
        remainingSeconds--;
      }
      update();
    });
  }

  void verifyOTP() {
    if (otpType == "firebase") {
      otpVerifyUsingFirebase();
    } else if (otpType == "local") {
      loginVerify();
    }
  }

  void otpVerifyUsingFirebase() async {
    try {
      AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: loginArguments['verificationId'],
        smsCode: enteredOtpCode,
      );
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(authCredential);
      if (userCredential.user != null) {
        showLoadingDialog();
        otpVerifyUsingAPI();
      } else {}
    } catch (e) {
      if (otpController.text.isEmpty) {
        ApiClient.toAst('Please enter your OTP code');
      } else {
        ApiClient.toAst('Invalid Verification Code');
      }
    }
  }

  Future resendOtp() async {
    print("Resending OTP...");
    try {
      /// Rajwinder
      await ApiClient.resendOTP(
              phoneNumber: loginArguments['countryCode'] + loginArguments['phoneNumber'], type: "phone")
          .then((value) {
        otpType = "local";
        otpFromApi = value["data"].toString();
        ApiClient.toAst('OTP Resend to Your Number ${loginArguments['phoneNumber']}');
      });
      update();
    } catch (e, st) {
      print("Dio Error: $e");
      print("Dio Stack: $st");
      // ApiClient.toAst('An error occurred while resending OTP');
      //update();
    }
  }

  void loginVerify() {
    if (isTimerClosed == true) {
      ApiClient.toAst('OTP has expired');
    } else {
      if (otpFromApi == enteredOtpCode) {
        showLoadingDialog();
        otpVerifyUsingAPI();
      } else {
        if (otpController.text.isEmpty) {
          ApiClient.toAst('Please enter your OTP code');
        } else {
          ApiClient.toAst('Invalid Verification Code');
        }
      }
    }
  }

  otpVerifyUsingAPI() async {
    LoginRequest request = LoginRequest(
        deviceId: await deviceInfo.getDeviceID(),
        fcmToken: await deviceInfo.getFcmToken(),
        token: await getToken(),
        phone: loginArguments['phoneNumber'],
        buildNo: await deviceInfo.getBuildNumber(),
        buildVersion: await deviceInfo.getBuildVersion(),
        countryCode: loginArguments['countryCode'],
        deviceModel: await deviceInfo.getDeviceModel(),
        deviceName: await deviceInfo.getDeviceName(),
        deviceType: deviceInfo.getDeviceType(),
        osVersion: await deviceInfo.getOSVersion());
    printData("otpVerifyUsingAPI ${request.toJson()}");
    await ApiClient.loginApi(request.toJson()).then((response) async {
      print("loginApi loginApi $response");
      if (response != null) {
        printData("response is not null");
        if (response["success"] == true) {
          ApiClient.toAst("User login successfully");
          SharePreferencesHelper.setString(SharedPrefKeys.IS_FIRST_TIME, "true");
          SharePreferencesHelper.setString(SharedPrefKeys.FCM_TOKEN, response["data"]['fcm_token']);
          SharePreferencesHelper.setString(SharedPrefKeys.DEVICE_ID, response["data"]['device_id']);
          SharePreferencesHelper.setString(SharedPrefKeys.TOKEN, response["data"]['token']);
          SharePreferencesHelper.setString(SharedPrefKeys.PHONE, response["data"]['phone']);
          Get.offAllNamed(Routes.BOTTOM_SCREEN);
        }
      }
    });
  }

  getFCMToken() async {
    SharePreferencesHelper.getString(SharedPrefKeys.FCM_TOKEN);
  }

  getToken() async {
    SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
  }

  void showLoadingDialog() {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(
          color: appColors.darkYellowColor,
        ),
      ),
      barrierDismissible: false,
    );
  }

  void stopLoadingDialog() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
    Get.off(LoginScreenPage());
  }
}
