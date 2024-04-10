// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:akalsahae/app/apiCollection/api_client.dart';
import 'package:akalsahae/app/modules/check_out_screen_module/check_out_screen_controller.dart';
import 'package:akalsahae/app/modules/fullvoile_turban_screen_module/Add_To_Cart_Api_Modal.dart';
import 'package:akalsahae/app/modules/fullvoile_turban_screen_module/TurbanProductDetailApiModal.dart';
import 'package:akalsahae/app/modules/home_screen_module/home_screen_controller.dart';
import 'package:akalsahae/app/modules/shop_screen_module/GetColorApiModal.dart';
import 'package:akalsahae/app/modules/shop_screen_module/shop_screen_controller.dart';
import 'package:akalsahae/helper_widget/colors.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import '../../../ar_view/face_detection_screen.dart';
import '../favorite_screen_module/favorite_screen_controller.dart';
import '../home_screen_module/drag_image.dart';
import 'Add_to_favourite_Api_Modal.dart';

class FullvoileTurbanScreenController extends GetxController {
  CheckOutScreenController checkOutScreenController = Get.put(
      CheckOutScreenController());
  Rx<TurbanProductDetailApiModal>? turbanProductDetailApiModal;
  RxBool isDetailsLoading = true.obs;
  HomeScreenController homeScreenController = Get.find<HomeScreenController>();
  var productId = "".obs;
  var colorName = "".obs;
  ShopScreenController shopScreenController =
  Get.isRegistered<ShopScreenController>()
      ? Get.find<ShopScreenController>()
      : Get.put(ShopScreenController());
  Rx<AddToCartApiModal> addToCartApiModal = AddToCartApiModal().obs;
  Rx<AddToFavoriteApiModal> addToFavoriteApiModal = AddToFavoriteApiModal().obs;
  TurbanData turbanData = TurbanData();
  Rx<BrandData> brandData = BrandData().obs;
  Rx<Length> selectedTurbanLength = Length(key: '5').obs;
  RxInt isSelected = (-1).obs;
  Rx<TextEditingController> quantityController = TextEditingController(
      text: "1").obs;

  RxInt currentView = 0.obs;
  AppColors appColors = AppColors();
  RxBool isLoading = false.obs;
  RxString selectBrands = "".obs;
  final controller = PageController();
  RxBool isVisible = false.obs;
  RxBool isVisible1 = false.obs;
  var price = ''.obs;
  RxInt brandId = (-1).obs;
  RxBool selectFav = false.obs;
  RxString totalAmount = "".obs;

  void toggleVisibility() {
    isVisible.value = !isVisible.value;
    update();
  }

  void toggleVisibility1() {
    isVisible1.value = !isVisible1.value;
    update();
  }

  void changeView(index) {
    currentView.value = index;
    update();
  }

  void changeLength() {
    update();
  }

  RxInt value = 1.obs;

  Widget CustomRadioButton(int index) {
    return GestureDetector(
      onTap: () {
        value.value = index;
        update();
        totalPrice();
      },
      child: Container(
        margin: EdgeInsets.all(1.7.sp),
        padding: EdgeInsets.all(2.5.sp),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (value.value == index)
                ? appColors.textfieldBoxColor
                : appColors.textfieldBoxColor),
        child: Icon(
          Icons.circle,
          size: 10.8.sp,
          color: (value.value == index) ? appColors.darkYellowColor : appColors
              .textfieldBoxColor,
        ),
      ),
    );
  }

  getTurbanProductDetailData({String? colorName, String? productId}) async {
    isDetailsLoading.value = true;
    isLoading.value = true;
    List<TurbanColors> colors = shopScreenController.getColorApiModal.value
        .colors ?? [];
    try {
      await ApiClient.getTurbanProductDetailData(
          productId: productId ?? "", colorName: colorName ?? "").then((value) {
        print("turban data: $value");
        if (value != null) {
          turbanProductDetailApiModal!.value = value;
          brandData.value =
          turbanProductDetailApiModal!.value.data!.productVariations!.data![0];
          selectedTurbanLength.value.key =
              turbanProductDetailApiModal!.value.data!.length![0].key;
          selectFav.value =
              turbanProductDetailApiModal!.value.data!.isFavorite ?? false;
          totalPrice();
        }
      });
      isDetailsLoading.value = false;
      isLoading.value = false;
      update();
    } catch (err) {
      isDetailsLoading.value = false;
      isLoading.value = false;
      update();
      print("ERROR ${err}");
    }
  }

  totalPrice() {
    try {
      // int brandID = brandId.value;
      String brandBAsePrice = brandData.value.brandPrice.toString();
      String turbanKey = selectedTurbanLength.value.key.toString();

      var rate = (double.parse(brandBAsePrice) * double.parse(turbanKey));

      if (turbanProductDetailApiModal!.value.data!.stichingPrice != null) {
        String stichingPrice = turbanProductDetailApiModal!.value.data!
            .stichingPrice.toString();
        rate = rate + double.parse(stichingPrice);
        totalAmount.value = value.value == 1 &&
            turbanProductDetailApiModal!.value.data!.stichingPrice!.isNotEmpty
            ? '₹ $rate'
            : '₹ ${(double.parse(brandBAsePrice) * double.parse(turbanKey))}';
      } else {
        totalAmount.value =
        value.value == 1 ? '₹ $rate' : '₹ ${(double.parse(brandBAsePrice) *
            double.parse(turbanKey))}';
      }
      return;
      // brandId.value == (-1)
      //   ? "₹ ${double.parse(turbanProductDetailApiModal!.value.data!.productVariations!.data![0].brandPrice.toString()) * double.parse(turbanProductDetailApiModal!.value.data!.length![0].key.toString())}"
      //   : selectedTurbanLength.value.key!.isNotEmpty
      //       ? "₹ ${double.parse(brandData.value.brandPrice.toString()) * double.parse(turbanProductDetailApiModal!.value.data!.length![0].key.toString())}"
      //       :
      // value.value == 1 &&
      //         turbanProductDetailApiModal!
      //             .value.data!.stichingPrice!.isNotEmpty
      //     ? '₹ ${rate}'
      //     : '₹ ${(double.parse(brandBAsePrice) * double.parse(turbanKey))}';
    } catch (e) {
      print("dsflksdjfsdkfjsdkf $e");
    }
  }

  var discount;

  Future<bool> addToCartData(BrandData brandData, Length length) async {
    String brandBAsePrice = brandData.brandPrice.toString();
    String brandDiscount = brandData.discountOnMrp.toString();
    String turbanKey = selectedTurbanLength.value.key.toString();
    // String stichingPrice = turbanProductDetailApiModal!.value.data!.stichingPrice.toString() ?? "";
    // var rate = (double.parse(brandBAsePrice) * double.parse(turbanKey)) + double.parse(stichingPrice);
    var rate1 = (double.parse(brandBAsePrice) * double.parse(turbanKey));
    bool result = false;
    isLoading.value = true;
    if (turbanProductDetailApiModal!.value.data!.productVariations == null ||
        turbanProductDetailApiModal!.value.data!.productVariations!.data ==
            null ||
        turbanProductDetailApiModal!.value.data!.productVariations!.data!
            .isEmpty) {
      discount = turbanProductDetailApiModal!.value.data!.discountOnMrp ?? '0';
    } else {
      discount = brandDiscount;
      if (discount == "null") {
        discount = "0";
      }
    }
    print("Discount on turban: $discount");
    // int? colorId =
    //     shopScreenController.getColorApiModal.value.colors![shopScreenController.itemForDetails.value].id ?? null;
    // int? productId = homeScreenController.selectedCloth.id;
    // int? brandId = int.parse(brandData.brandId ?? "");
    //double? price = double.parse(brandData.price ?? "");

    await ApiClient.addToCartApiModal(
        variationId: turbanProductDetailApiModal!.value.data!.productVariations!
            .data!.first.id.toString(),
        priceAfterDiscount: discount,
        priceBeforeDiscount: value.value == 1 ? rate1.toString() : rate1
            .toString(),
        colorId: turbanProductDetailApiModal!.value.data!.productVariations!
            .data!.first.colorId.toString(),
        brandId: turbanProductDetailApiModal!.value.data!.productVariations!
            .data!.first.brandId ?? "",
        productId: turbanProductDetailApiModal!.value.data!.productVariations!
            .data!.first.productId,
        size: "",
        stitch: turbanProductDetailApiModal!.value.data!.stichingPrice == null
            ? ""
            : value.value == 1 ? 'Yes' : 'No',
        turbanLength: selectedTurbanLength.value.key.toString())
        .then((value) {
      debugPrint("Value: $value");
      if (value != null) {
        result = true;
        addToCartApiModal.value = value;
        homeScreenController.counter.value =
            homeScreenController.counter.value + 1;
        shopScreenController.counter.value =
            shopScreenController.counter.value + 1;
        ApiClient.toAst("Items added to cart successfully");
      }
    });
    isLoading.value = false;
    return result;
  }

  checkValidations() {
    if (selectLength.value == null || selectLength.isEmpty) {
      ApiClient.toAst("Please select all details");
      return false;
    }
    if (brandData.value.brandName == null ||
        brandData.value.brandName!.isEmpty) {
      ApiClient.toAst("Please select all details");
      return false;
    }
    // if (quantityController.value.text == null || quantityController.value.text.isEmpty) {
    //   ApiClient.toAst("Please enter quantity");
    //   return false;
    // }
    // if (value.value == 0) {
    //   ApiClient.toAst("Please select piko/stitch option");
    //   return false;
    // }
    return true;
  }

  Future<bool> checkOut() async {
    checkOutScreenController.isAddress.value = true;
    if (checkValidations()) {
      bool value = await addToCartData(
          brandData.value, selectedTurbanLength.value);
      return value;
    }
    return false;
  }

  var selectLength = [
    '4.50',
    '5.00',
    '5.50',
    '6.50',
    '7.00',
    '7.50',
    '8.00',
    '8.50',
    '9.00',
    '9.50',
    '10.00'
  ].obs;

  var selectedLengthItems = "".obs;
  RxList selectedBrandItems = [].obs;

  void selectedBrand(BrandData data) {
    brandData.value = data;
    totalPrice();
  }

  selectPrice(int index) {
    brandId.value = index;
  }

  final Duration autoPageChangeDuration = const Duration(seconds: 3);
  int currentPage = 0;
  Timer? pageChangeTimer;

  void startAutoPageChange() {
    Timer.periodic(autoPageChangeDuration, (timer) {
      if (currentPage >=
          turbanProductDetailApiModal!.value.data!.productVariations!.data![0]
              .images!.length - 1) {
        currentPage = 0;
        controller.animateToPage(
            currentPage, duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOut);
      } else {
        currentPage++;
        controller.animateToPage(
            currentPage, duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOut);
      }
    });
  }

  void stopAutoPageChange() {
    pageChangeTimer = null;
    pageChangeTimer?.cancel();
  }

  addToFavoriteData(BrandData brandData, Length length, bool isFav) async {
    print("Variation Id:${turbanProductDetailApiModal!.value.data!
        .productVariations!.data!.first.id.toString()}");
    print("Color Slug: ${colorName.toString()}");
    await ApiClient.addToFavoriteCartApi(
        colorSlug: colorName.toString(),
        productId:
        int.parse(
            turbanProductDetailApiModal!.value.data!.productVariations!.data!
                .first.productId.toString()),
        isFavorite: isFav)
        .then((value) {
      if (value != null) {
        selectFav.value = !selectFav.value;
        final favController = Get.put(FavoriteScreenController());
        favController.getFavList();

        turbanProductDetailApiModal!.value.data!.isFavorite = selectFav.value;
        addToFavoriteApiModal.value = value;
        // Get.toNamed(Routes.FAVORITE_SCREEN);
      }
    });
  }

  void favCheckOut({bool isFav = false}) async {
    await addToFavoriteData(
      brandData.value,
      selectedTurbanLength.value,
      isFav,
    );
  }

  @override
  void onInit() {
    // var colorName1 = Get.arguments['color_name'] ;

    update();
    selectedLengthItems.value = "";
    brandData.value = BrandData();
    selectedTurbanLength.value = Length();
    print("Cloth id:${homeScreenController.selectedCloth.id}");
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  File? imageFile;

  /// Get from Camera
  getImageFromCamera() async {
    XFile? pickedFile;

    await Permission.camera.request();
    if (!await Permission.camera.isGranted) {
      openAppSettings();
    } else {
      pickedFile = await pickImage(fromCamera: true);
    }
    /* if (Platform.isIOS) {
      await Permission.camera.request();
      if (!await Permission.camera.isGranted) {
        openAppSettings();
      }
    } else {
      if (!await Permission.camera.isGranted) {
        openAppSettings();
      } else {
        pickedFile = await pickImage(fromCamera: true);
      }
    }*/


    /*  if (await Permission.photos.isPermanentlyDenied) {
      openAppSettings();
      return;
    } else if (await Permission.photos.isDenied) {
      var result = await Permission.photos.request();
      if (result.isGranted) {
        pickedFile = await pickImage(fromCamera: true);
      } else {
        openAppSettings();
      }
    } else {
      pickedFile = await pickImage(fromCamera: true);
    }*/
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      Get.to(() => DragImage(image: imageFile!.path));
    }
  }

  Future<XFile?> pickImage({bool fromCamera = true}) async {
    return await ImagePicker().pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
  }

  onWillPop() async {
    Get.dialog(
      AlertDialog(
        backgroundColor: appColors.lightBlackColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.sp),
        ),
        content: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.sp),
              color: appColors.lightBlackColor
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'Try Now ',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: appColors.whiteColor,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                'With',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: appColors.whiteColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      getImageFromCamera();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0, top: 10, right: 0),
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 100,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: appColors.darkYellowColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: appColors.darkYellowColor,
                              width: 1),
                        ),
                        child: Text(
                          "Photo",
                          style: TextStyle(
                            letterSpacing: 1.5,
                            color: appColors.whiteColor,
                            fontFamily: "Poppins",
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Get.back();
                      Get.to(FaceMeshDetectorView());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0, top: 10, right: 0),
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 100,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: appColors.darkYellowColor,
                        ),
                        child: Text(
                          "Live AR",
                          style: TextStyle(
                            letterSpacing: 1.5,
                            color: appColors.whiteColor,
                            fontFamily: "Poppins",
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}








/*  getTurbanProductDetailData() async {
    isLoading.value = true;
    List<TurbanColors> colors = shopScreenController.getColorApiModal.value.colors ?? [];
    try {
      await ApiClient.getTurbanProductDetailData(
              clothId: homeScreenController.selectedCloth.id.toString(),
              colorId: colors[shopScreenController.itemForDetails.value].id.toString())
          .then((value) {
        if (value != null) {
          turbanProductDetailApiModal.value = value;
        }
      });

      isLoading.value = false;
    } catch (err) {
      isLoading.value = false;

      print("ERROR ${err}");
    }
  }*/

/* addToFavoriteData(BrandData brandData, selectLength) async {
    var rate = double.parse(brandData.price.toString()) + double.parse(30.toString());
    int productID = int.parse(turbanProductDetailApiModal.value.data!.first.productId.toString());
    int clothID = int.parse(turbanProductDetailApiModal.value.data!.first.clothId.toString());

    isLoading.value = true;
    await ApiClient.addToFavoriteCartApi(
            productId: productID,
            id: turbanProductDetailApiModal.value.data!.first.id.toString(),
            colorId: turbanProductDetailApiModal.value.data!.first.colorId.toString(),
            brandId: brandData.brandId ?? "",
            clothId: clothID,
            price: brandData.price ?? "",
            size: selectLength.toString(),
            description: turbanProductDetailApiModal.value.data!.first.description.toString(),
            images: turbanProductDetailApiModal.value.data!.first.images!.first.url.toString(),
            isFavorite: selectFav.value)
        .then((value) {
      printData("fav--->$value");
      if (value != null) {
        printData("fav response--->$value");
        addToFavoriteApiModal.value = value;
        // Get.toNamed(Routes.FAVORITE_SCREEN);
      }
    });
    isLoading.value = false;
  }*/

/*
  addToFavoriteData(BrandData brandData, selectLength) async {


  var rate = double.parse(brandData.price.toString()) + double.parse(30.toString());
    int productID = int.parse(turbanProductDetailApiModal.value.data!.first.productId.toString());
    int clothID = int.parse(turbanProductDetailApiModal.value.data!.first.clothId.toString());



    await ApiClient.addToFavoriteCartApi(
            productId: int.parse(turbanProductDetailApiModal.value.data!.first.productId.toString()),
            id: turbanProductDetailApiModal.value.data!.first.id.toString(),
            colorId: turbanProductDetailApiModal.value.data!.first.colorId.toString(),
            brandId: brandData.brandId ?? "",
            clothId: homeScreenController.selectedCloth.id ?? 0,
            price: brandData.price ?? "",
            size: selectLength.toString(),
            description: turbanProductDetailApiModal.value.data!.first.description.toString(),
            images: turbanProductDetailApiModal.value.data!.first.images!.first.url.toString(),
            isFavorite: !selectFav.value)
        .then((value) {
      printData("fav--->$value");
      if (value != null) {
        selectFav.value = !selectFav.value;
        printData("fav response--->$value");
        turbanProductDetailApiModal.value.data!.first.isFavorite = selectFav.value;
        addToFavoriteApiModal.value = value;
        // Get.toNamed(Routes.FAVORITE_SCREEN);
      }
    });
  }*/

// void checkOut() async {
//   checkOutScreenController.isAddress.value = true;
//   if (checkValidations()) {
//     await addToCartData(brandData.value, selectedLengthItems);
//   }
// }
