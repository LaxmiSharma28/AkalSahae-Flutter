import 'dart:async';
import 'package:akalsahae/app/apiCollection/api_client.dart';
import 'package:akalsahae/app/modules/Edit%20Profile%20Module/verify_phone_otp_screen.dart';
import 'package:akalsahae/app/modules/My%20Profile%20Module/profile_controller.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helper_widget/colors.dart';

class EditProfileController extends GetxController {
  AppColors appColors = AppColors();
  var nameController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  String selectedCountryCode = 'IN';
  CountryCode selectedCountry = CountryCode(name: "IN", dialCode: "+91");
  String phone = '';
  RxString fileName = "".obs;
  RxString selectedFile = "".obs;
  var otpCode = "".obs;
  var countryCode = "".obs;
  var isLoading = false.obs;
  var isEditPhone = false.obs;
  var isLoad = false.obs;

  var email = TextEditingController(text: "").obs;
  var mobile = TextEditingController(text: "").obs;

  void onCountryChange(CountryCode countryCode) {
    selectedCountry = countryCode;
    update();
  }

  void resetData() {
    isLoading.value = false;
    nameController.value.clear();
    phoneController.value.clear();
    emailController.value.clear();
    selectedFile.value = "";
  }

  Future<void> updateProfile({String? name, String? email, String? image, String? phoneNo, String? code}) async {
    isLoading.value = true;

    isLoading.value = false;
  }

  Timer? timer;
  RxInt remainingSeconds = 60.obs;
  bool isTimerClosed = false;
  TextEditingController otpController = TextEditingController();

  startTimer() {
    remainingSeconds.value = 60;
    const duration = Duration(seconds: 1);
    if(timer!=null){
      timer!.cancel();
      timer = null;
    }
    timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSeconds.value == 0) {
        print("Timer Out");
        isTimerClosed = true;
        timer.cancel();
      } else {
        isTimerClosed = false;
        //remainingSeconds.value == remainingSeconds.value--;
        remainingSeconds.value--;
      }
      update();
    });
  }



  void clearOtpController() {
    otpController.clear();
    update();
  }

  void editPhoneEmail({String? type}) async {
    isEditPhone.value = true;
    await ApiClient.checkPhoneNumber(
            countryCode: selectedCountry.dialCode,
            phoneNo: phoneController.value.text.trim(),
            type: type,
            email: emailController.value.text.trim())
        .then((value) {
      isEditPhone.value = false;
      if (value != null && value == true) {
        if (type == "phone") {
          Get.to(() => VerifyPhoneOtpScreen(
                phone: phoneController.value.text,
                type: "phone",
              ));
        } else {
          Get.to(() => VerifyPhoneOtpScreen(
                email: emailController.value.text,
                type: "email",
              ));
        }
      }
    });
    isEditPhone.value = false;
  }

  Future updatePhoneNumber({String? phone, String? code, String? email, String? type}) async {
    isLoad.value = true;
    await ApiClient.updatePhoneNumber(countryCode: code, phoneNo: phone!.trim(), email: email, type: type)
        .then((value) {
      if (value != null && value == true) {
        final profileController = Get.put(ProfileController());
        profileController.getProfileData();
        Get.back();
        Get.back();
        Get.back();
      }
    });
    isLoad.value = false;
  }

  sendPhoneOtp({String? phoneNo, String? email, String? type}) async {
    if (type == "phone") {
      if (phoneNo!.isNotEmpty) {
        await ApiClient.resendOTP(phoneNumber: phoneNo, type: "phone").then((value) {
          if (value != null) {
            if (value["error"] == false) {
              otpCode.value = value["data"].toString();
              ApiClient.toAst("OTP has been sent to this number");
            }
            isEditPhone.value = false;
          }
        });
      } else {
        isEditPhone.value = false;
        ApiClient.toAst("Please enter phone number");
      }
    } else {
      if (email!.isNotEmpty) {
        await ApiClient.resendOTP(email: email, type: "email").then((value) {
          if (value != null) {
            if (value["error"] == false) {
              otpCode.value = value["data"].toString();
              ApiClient.toAst("OTP has been sent to this email");
            }
            isEditPhone.value = false;
          }
        });
      } else {
        isEditPhone.value = false;
        ApiClient.toAst("Please enter email");
      }
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }
}
