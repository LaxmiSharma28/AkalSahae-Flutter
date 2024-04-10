import 'package:akalsahae/app/apiCollection/api_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../helper_widget/colors.dart';
import '../shop_screen_module/shop_screen_controller.dart';
import 'FavApiModal.dart';

class FavoriteScreenController extends GetxController {
  Rx<GetFavListModel> favList = GetFavListModel().obs;
  RxBool loader = false.obs;
  ShopScreenController shopScreenController =
      Get.isRegistered<ShopScreenController>()
          ? Get.find<ShopScreenController>()
          : Get.put(ShopScreenController());

  @override
  void onInit() {
    getFavList();
    super.onInit();
  }

  AppColors appColors = AppColors();
  RxInt counter = 0.obs;

  getFavList() async {
    loader.value = true;
    ApiClient.getFavList().then((value) {
      if (value != null) {
        favList.value = GetFavListModel();
        favList.value = value;
        update();
        loader.value = false;
      } else {
        loader.value = false;
      }
    });
    loader.value = false;
  }

  Future<void> removeFromFav(data) async {
    debugPrint("removeFromFav ==> ${data.colorSlug}  ${data.productId}");

    await ApiClient.addToFavoriteCartApi(
            productId: data.productId,
            colorSlug: data.colorSlug.toString(),
            isFavorite: false)
        .then((value) {
      if (value != null) {
        getFavList();
      }
    });
  }

/*  Future<void> removeFromFav(data) async {
    debugPrint("removeFromFav ==> ${data["color_slug"]}  ${data["product_id"]}");

    await ApiClient.addToFavoriteCartApi(
            productId: data["product_id"], colorSlug: data["color_slug"].toString(), isFavorite: false)
        .then((value) {
      printData("fav--->$value");
      if (value != null) {
        getFavList();
      }
    });
  }*/

  Future<void> removeAccessoryFromFav(Favorite param0) async {
    debugPrint("removeAccessoryFromFav ==> ");
    await ApiClient.accessoryAddToFavoriteCartApi(
            productId: int.parse(param0.productId.toString()),
            isFavorite: false)
        .then((value) {
      if (value != null) {
        getFavList();
      }
    });
  }
}

/*import 'package:akalsahae/app/apiCollection/api_client.dart';
import 'package:get/get.dart';

import '../../../helper_widget/colors.dart';
import 'FavApiModal.dart';


class FavoriteScreenController extends GetxController{

  var favList=GetFavListModel().obs;
  var loader=false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getFavList();
    super.onInit();
  }

  AppColors appColors=AppColors();
  RxInt counter = 0.obs;


  getFavList()async{
    loader.value=true;
    ApiClient.getFavList().then((value){
      favList.value=GetFavListModel();
      if(value!=null){
        favList.value=value;
        update();
      }
      loader.value=false;
    });
  }

  Future<void> removeFromFav(data) async {

    await ApiClient.addToFavoriteCartApi(
        productId:data["product_id"],
        productVariation: data["product_variation_id"].toString(),
        isFavorite: false)
        .then((value) {
      printData("fav--->$value");
      if (value != null) {
        getFavList();
      }
    });
  }

  Future<void> removeAccessoryFromFav(param0) async {
    await ApiClient.accessoryAddToFavoriteCartApi(
        productId: int.parse(param0["product_id"]), isFavorite: false)
        .then((value) {
      if (value != null) {
        favList.value = GetFavListModel();
        if (value != null) {
          favList.value = value;
          update();
        }
      }
    });
  }

}*/
