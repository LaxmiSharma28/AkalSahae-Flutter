import 'dart:io';

import 'package:akalsahae/app/apiCollection/api_client.dart';
import 'package:akalsahae/app/modules/login_screen_module/social_login_modal.dart';
import 'package:akalsahae/app/utils/shared_prefs_keys.dart';
import 'package:country_list_pick/support/code_country.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

import '../../../helper_widget/colors.dart';
import '../../../helper_widget/device_info.dart';
import '../../routes/app_pages.dart';

import '../../utils/shared_preferences_helper.dart';

class LoginScreenController extends GetxController {
  Map<String, dynamic>? fbUserData;
  AccessToken? tokenAccess;
  String phone = '';
  User? user;
  String otpType = "local";
  AppColors appColors = AppColors();
  String selectedCountryCode = 'IN';
  CountryCode selectedCountry = CountryCode(name: "IN", dialCode: "+91");
  TextEditingController textController = TextEditingController();
  DeviceInfo deviceInfo = DeviceInfo();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  RxBool isChecked = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onCountryChange(CountryCode countryCode) {
    selectedCountry = countryCode;
    update();
  }

  void toggleCheckbox() {
    isChecked.value = !isChecked.value;
    update();
  }

  void checkValue() {
    if (isChecked.value) {
      if (textController.text.trim().isEmpty) {
        ApiClient.toAst("Please enter mobile number");
      }
      if (textController.text.trim().isNotEmpty) {
        if (textController.text.trim().length == 10 || textController.text.trim().isEmpty) {
          verifyAuth();
          showLoadingDialog();
        } else {
          ApiClient.toAst("Please enter a valid mobile number ");
        }
      }
    } else {
      if (textController.text.trim().isEmpty) {
        ApiClient.toAst("Please enter a valid mobile number ");
      } else {
        ApiClient.toAst('Please agree to our terms & conditions and privacy policy ');
      }
    }
    update();
  }

  RxBool isSelect = false.obs;

  void checkGoogle() {
    if (isChecked.value == false) {
      ApiClient.toAst('Please agree to our terms & conditions and privacy policy.');
      update();
    } else {
      showLoadingDialog();
      signInWithGoogle();
    }
    update();
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);
      final result = await _auth.signInWithCredential(authCredential);

      if (result.user != null) {
        user = result.user;
        await socialLogin(result.user!);
      } else {
        stopLoadingDialog();
      }
    } catch (e, st) {
      stopLoadingDialog();
      print(e);
      print(st);
      print("Error ");
    }
    update();
  }

  Future signInWithApple() async {
    // 1. perform the sign-in request
    final result = await TheAppleSignIn.performRequests([
      const AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);
    // 2. check the result
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential!;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken!),
          accessToken: String.fromCharCodes(appleIdCredential.authorizationCode!),
        );
        final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        final firebaseUser = userCredential.user!;
        if (userCredential.user != null) {
          SharePreferencesHelper.setString(SharedPrefKeys.EMAIL, userCredential.user?.email ?? "");
          await socialLogin(userCredential.user!);
        }
        return firebaseUser;
      case AuthorizationStatus.error:
        stopLoadingDialog();
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );

      case AuthorizationStatus.cancelled:
        stopLoadingDialog();
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      default:
        stopLoadingDialog();
        throw UnimplementedError();
    }

    /* final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.status == LoginStatus.success) {
      tokenAccess = loginResult.accessToken;
      fbUserData = await FacebookAuth.instance.getUserData();
    } else {
      print('ResultStatus: ${loginResult.status}');
      print('Message: ${loginResult.message}');
    }*/
  }

  void checkApple() {
    if (isChecked.value == false) {
      ApiClient.toAst('Please agree to our terms & conditions and privacy policy.');
      update();
    } else {
      showLoadingDialog();
      signInWithApple();
    }
    update();
  }

  Future verifyAuth() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: '${selectedCountry.dialCode}$phone',
      timeout: const Duration(minutes: 1),
      verificationCompleted: (PhoneAuthCredential credential) async {
        print(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        sendOtp();
        stopLoadingDialog();
        print("Verification Failed---> ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        print("Code has been sent");
        var args = {
          "verificationId": verificationId,
          "otp": "",
          "otpType": 'firebase',
          "countryCode": '${selectedCountry.dialCode}',
          "phoneNumber": textController.text,
        };
        ApiClient.toAst("OTP sent to your mobile number");
        if (Platform.isIOS) ApiClient.toAst("OTP sent to your mobile number");
        Get.toNamed(Routes.VERIFICATION_SCREEN, arguments: args);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
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
  }

  sendOtp() async {
    try {
      ApiClient.resendOTP(phoneNumber: '${selectedCountry.dialCode} ${textController.text}', type: "phone")
          .then((value) {
        if (value != null) {
          if (value["error"] == false) {
            var args = {
              "verificationId": "",
              "otp": value['data'].toString().trim(),
              "otpType": otpType,
              "phoneNumber": '${textController.text}',
              "countryCode": '${selectedCountry.dialCode}'
            };
            ApiClient.toAst("${value['message'].toString()}");
            Get.toNamed(Routes.VERIFICATION_SCREEN, arguments: args);
          }
        }
      });
    } catch (e) {
      print("Dio Error$e");
    }
    update();
  }

  Future socialLogin(User user) async {
    SocialRequest request = SocialRequest(
      email: user.email,
      socialId: user.uid,
      fcmToken: await deviceInfo.getFcmToken(),
      buildNo: await deviceInfo.getBuildNumber(),
      buildVersion: await deviceInfo.getBuildVersion(),
      osVersion: await deviceInfo.getOSVersion(),
      deviceModel: await deviceInfo.getDeviceModel(),
      deviceType: deviceInfo.getDeviceType(),
      deviceName: await deviceInfo.getDeviceName(),
      socialLoginType: "Apple",
      deviceId: await deviceInfo.getDeviceID(),
    );

    try {
      await ApiClient.socialLoginApi(request.toJson()).then((response) {
        if (response != null) {
          if (response["success"] == true) {
            ApiClient.toAst("Login Successfully");
            SharePreferencesHelper.setString(SharedPrefKeys.IS_FIRST_TIME, "true");
            stopLoadingDialog();
            Get.offAllNamed(Routes.BOTTOM_SCREEN);
          } else {
            ApiClient.toAst('"Error", ${response["message"]}??"Something went wrong"');
          }
        }
        SharePreferencesHelper.setString(SharedPrefKeys.TOKEN, response["data"]["token"]);
        SharePreferencesHelper.setString(SharedPrefKeys.FCM_TOKEN, response["data"]['fcm_token']);
        SharePreferencesHelper.setString(SharedPrefKeys.DEVICE_ID, response["data"]['device_id']);
      });
    } catch (e) {
      print("Dio Error: $e");
    }
    update();
  }

  getFCMToken() async {
    SharePreferencesHelper.getString(SharedPrefKeys.FCM_TOKEN);
  }
}
