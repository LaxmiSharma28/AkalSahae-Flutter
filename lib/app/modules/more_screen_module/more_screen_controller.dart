import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../helper_widget/colors.dart';
import '../../utils/shared_preferences_helper.dart';
import '../../utils/shared_prefs_keys.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class MoreScreenController extends GetxController {
  AppColors appColors = AppColors();
  RxString appversion = ''.obs;
  RxString appbuildNumber = ''.obs;
  RxString aPPName = ''.obs;
  RxString apppackageName = ''.obs;

  @override
  void onInit() {
    getAppVersion();
    super.onInit();
  }

  void getAppVersion() async {
    await PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      aPPName.value = packageInfo.appName;
      apppackageName.value = packageInfo.packageName;
      appversion.value = packageInfo.version;
      appbuildNumber.value = packageInfo.buildNumber;
      print('appversion.value---${appversion.value}');
      print('appversion.value---${appbuildNumber.value}');
      update();
    });
  }
}
