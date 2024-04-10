import 'package:akalsahae/app/utils/shared_preferences_helper.dart';
import 'package:akalsahae/app/utils/shared_prefs_keys.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
/// GetX Template Generator - fb.com/htngu.99


class SplashScreenController extends GetxController {
  navigatetohome() async {
    await Future.delayed(const Duration(seconds: 4), () {});
    Get.offAllNamed(Routes.LOGIN_SCREEN);
  }

  void navigateToHome() async {
    var getPref = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    print("PREF:::$getPref");
    await Future.delayed(const Duration(seconds: 4), () {
      if(getPref!=null){
        if(getPref.isNotEmpty){
          Get.offNamed(Routes.BOTTOM_SCREEN);
        }else{
          Get.offNamed(Routes.LOGIN_SCREEN);
        }

      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    navigateToHome();
    //navigatetohome();
  }
}
