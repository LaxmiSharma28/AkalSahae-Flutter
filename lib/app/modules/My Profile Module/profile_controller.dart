import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../helper_widget/colors.dart';
import '../../apiCollection/api_client.dart';
import '../../routes/app_pages.dart';
import '../../utils/shared_preferences_helper.dart';
import '../../utils/shared_prefs_keys.dart';
import '../Edit Profile Module/edit_profile_controller.dart';

class ProfileController extends GetxController {
  AppColors appColors = AppColors();

  var nameController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  EditProfileController editProfileController = Get.put(EditProfileController());
  var isLoading = false.obs;

  var email = ''.obs;
  var countryCode = ''.obs;

  var phone = ''.obs;

  getPhone() async {
    phone.value = await SharePreferencesHelper.getString(SharedPrefKeys.PHONE);
    print("Phone: ${phone.value}");
  }

  getEmail() async {
    email.value = await SharePreferencesHelper.getString(SharedPrefKeys.EMAIL);
    print("Email: ${email.value}");
  }

  @override
  void onInit() {
    getEmail();
    getPhone();
  }

  Future<void> getProfileData() async {
    isLoading.value = true;
    await ApiClient.getProfileData().then((value) {
      if (value != null && value["data"]["name"].trim() == "") {
        isLoading.value = false;
        Get.offNamed(Routes.EDIT_PROFILE_SCREEN, arguments: {
          "email": value["data"]["email"] ?? "",
          "phone": value["data"]["phone"] ?? "",
          "image": value["data"]["profile_image"] ?? "",
        });
      } else {
        debugPrint("Profile Data: ${value["data"]}");
        nameController.value.text = value["data"]["name"] ?? "";
        phoneController.value.text = value["data"]["phone"] ?? "";
        emailController.value.text = value["data"]["email"] ?? "";
        countryCode.value = value["data"]["country_code"] ?? "";
        editProfileController.fileName.value = value["data"]["profile_image"] ?? "";

        isLoading.value = false;
      }
    });
    isLoading.value = false;
  }
}
