import 'package:akalsahae/app/modules/home_screen_module/home_screen_controller.dart';
import 'package:akalsahae/helper_widget/colors.dart';
import 'package:get/get.dart';

import '../../apiCollection/api_client.dart';
import 'GetColorApiModal.dart';

/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class ShopScreenController extends GetxController {
  HomeScreenController homeScreenController = Get.find<HomeScreenController>();
  TurbanColors colors = TurbanColors();
  AppColors appColors = AppColors();
  RxInt counter = 0.obs;
  RxBool isLoading = false.obs;
  RxInt itemForDetails = (-1).obs;
  TurbanColors turbanColors = TurbanColors();

  Rx<GetColorApiModal> getColorApiModal = GetColorApiModal().obs;

  getColor(String id) async {
    isLoading.value = true;
    ApiClient.getColorData(clothId: id).then((value) {
      getColorApiModal.value = GetColorApiModal();
      if (value != null) {
        getColorApiModal.value = value;
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
    });
  }

  @override
  void onInit() {
    //print("Cloth type id: ${homeScreenController.selectedCloth.id.toString()}");
    super.onInit();
  }
}
