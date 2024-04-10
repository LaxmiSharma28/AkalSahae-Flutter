import 'package:akalsahae/app/apiCollection/api_client.dart';
import 'package:akalsahae/app/modules/accessories/GetAccessoryApiModal.dart';
import 'package:akalsahae/app/modules/home_screen_module/home_screen_controller.dart';
import 'package:akalsahae/helper_widget/colors.dart';
import 'package:get/get.dart';

class AccessoriesController extends GetxController {
  AppColors appColors = AppColors();
  RxInt counter = 0.obs;
  RxBool isLoading = false.obs;
  Rx<GetAccessoryApiModal> getAccessoryApiModal = GetAccessoryApiModal().obs;
  AccessoryData accessoryData = AccessoryData();
  HomeScreenController homeScreenController = Get.find<HomeScreenController>();
  int itemSelect = -1;

  getAccessories(String catId, String page) async {
    isLoading.value = true;
    var resultAccessory = await ApiClient.getAccessoriesData(CategoryId: catId, page: "");
    if (resultAccessory == true) {}
    print(getAccessoryApiModal.toString());
    isLoading.value = false;
  }

  @override
  void onInit() {
    getAccessories(homeScreenController.selectedCloth.id.toString(), "1");
    print("CatId ${homeScreenController.selectedCloth.id.toString()}");
    super.onInit();
  }
}
