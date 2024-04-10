import 'dart:io';

import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/globalkeyext.dart';
import 'package:akalsahae/helper_widget/hexcolor.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:akalsahae/app/modules/fullvoile_turban_screen_module/fullvoile_turban_screen_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import '../../../main.dart';
import '../../routes/app_pages.dart';
import 'package:badges/badges.dart' as badges;
import '../../utils/common_methods.dart';
import '../../utils/shared_preferences_helper.dart';
import '../../utils/shared_prefs_keys.dart';
import '../home_screen_module/drag_image.dart';
import 'TurbanProductDetailApiModal.dart' as modal;

class FullvoileTurbanScreenPage extends StatefulWidget {
  const FullvoileTurbanScreenPage({super.key});

  @override
  State<FullvoileTurbanScreenPage> createState() => _FullvoileTurbanScreenPageState();
}

class _FullvoileTurbanScreenPageState extends State<FullvoileTurbanScreenPage> {
  final fullVoileScreenController = Get.find<FullvoileTurbanScreenController>();
  CarouselController controller = CarouselController();

  late Function(GlobalKey) runAddToCartAnimation;
  int currentIndex = 0;

  @override
  void initState() {

    fullVoileScreenController.selectedLengthItems.value = "";
    fullVoileScreenController.selectedTurbanLength.value = modal.Length();
    fullVoileScreenController.brandData.value = modal.BrandData();
    fullVoileScreenController.turbanProductDetailApiModal = modal.TurbanProductDetailApiModal().obs;
    fullVoileScreenController.turbanProductDetailApiModal!.value = modal.TurbanProductDetailApiModal();
    if (Get.arguments != null) {
      fullVoileScreenController.colorName.value = Get.arguments["color_name"];
      fullVoileScreenController.productId.value = Get.arguments["product_id"];
      fullVoileScreenController.homeScreenController.selectedCloth.productName = Get.arguments["name"];
    }

    fullVoileScreenController.getTurbanProductDetailData(
        productId: fullVoileScreenController.productId.value, colorName: fullVoileScreenController.colorName.value);
    // ignore: invalid_use_of_protected_member
    fullVoileScreenController.refresh();
    fullVoileScreenController.update();
    // fullVoileScreenController.startAutoPageChange();
    super.initState();
  }

  @override
  void dispose() {
    fullVoileScreenController.stopAutoPageChange();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      cartKey: cartKey,
      height: 30,
      width: 30,
      opacity: 0.85,
      dragAnimation: const DragToCartAnimationOptions(
        rotation: true,
      ),
      jumpAnimation: const JumpAnimationOptions(),
      createAddToCartAnimation: (runAddToCartAnimation) {
        this.runAddToCartAnimation = runAddToCartAnimation;
      },
      child: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 0.h,
              backgroundColor: Colors.black,
              automaticallyImplyLeading: false,
              bottom: AppBar(
                automaticallyImplyLeading: false,
                titleSpacing: 0.5.sp,
                backgroundColor: Colors.black,
                title: Padding(
                  padding: const EdgeInsets.only(right: 12.0, left: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios_new_outlined,
                              size: 15.sp,
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          Text("${fullVoileScreenController.homeScreenController.selectedCloth.productName}".tr,
                              style: TextStyle(fontSize: 14.sp, fontFamily: "Poppins")),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if (await SharePreferencesHelper.getString(SharedPrefKeys.IS_FIRST_TIME) == "true") {
                                  SharePreferencesHelper.setString(SharedPrefKeys.IS_FIRST_TIME, "false");
                                  showOptionDialog();
                                } else {
                                  fullVoileScreenController.onWillPop();
                                }

                                //Get.toNamed(Routes.TRY_NOW_SCREEN);
                              },
                              child: Container(
                                width: 23.w,
                                height: 3.5.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.sp),
                                  color: fullVoileScreenController.appColors.darkYellowColor,
                                ),
                                child: Center(
                                    child: Image.asset(
                                  "assets/images/tryNowPic.png",
                                  width: 19.w,
                                )),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            fullVoileScreenController.homeScreenController.counter.value == 0
                                ? GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.CHECK_OUT_SCREEN);
                                    },
                                    child: Image.asset(
                                      'assets/images/CartIcon.png',
                                      width: 6.w,
                                    ),
                                  )
                                : GestureDetector(
                                    key: cartKey,
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      Get.toNamed(Routes.CHECK_OUT_SCREEN);
                                    },
                                    child: badges.Badge(
                                        badgeStyle: badges.BadgeStyle(
                                            badgeColor: fullVoileScreenController
                                                .homeScreenController.appColors.darkYellowColor,
                                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5)),
                                        position: badges.BadgePosition.topEnd(end: -8, top: -8),
                                        badgeAnimation: const badges.BadgeAnimation.scale(),
                                        badgeContent: Obx(
                                          () => Text(
                                            fullVoileScreenController.homeScreenController.counter.toString(),
                                            style: TextStyle(
                                                color:
                                                    fullVoileScreenController.homeScreenController.appColors.blackColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 8.sp),
                                          ),
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.toNamed(Routes.CHECK_OUT_SCREEN);
                                          },
                                          child: Image.asset(
                                            'assets/images/CartIcon.png',
                                            width: 7.w,
                                          ),
                                        )),
                                  ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            body: Stack(
              children: [
                Obx(
                  () => fullVoileScreenController.isDetailsLoading.value
                      ? const IgnorePointer()
                      : fullVoileScreenController.turbanProductDetailApiModal!.value.data == null
                          ? const Center(
                              child: Text("No Product Found",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                      fontFamily: "Poppins",
                                      color: Colors.white)))
                          : fullVoileScreenController.turbanProductDetailApiModal!.value.data!.productVariations == null
                              ? const Center(
                                  child: Text(
                                    "No Product Found",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17,
                                        fontFamily: "Poppins",
                                        color: Colors.white),
                                  ),
                                )
                              : Column(
                                  children: [
                                    Expanded(
                                      child: ListView(
                                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                        children: [
                                          SizedBox(
                                            height: 24.h,
                                            width: 90.w,
                                            child: CarouselSlider(
                                                carouselController: controller,
                                                items: fullVoileScreenController.turbanProductDetailApiModal!.value
                                                    .data!.productVariations!.data![0].images!
                                                    .map(
                                                      (item) => GestureDetector(
                                                        behavior: HitTestBehavior.translucent,
                                                        onTap: () {
                                                          fullVoileScreenController.isSelected.value =
                                                              fullVoileScreenController.turbanProductDetailApiModal!
                                                                  .value.data!.productVariations!.data![0].images!
                                                                  .indexOf(item);
                                                          showAlertDialog(context);
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(4.sp),
                                                              color: HexColor("#FDF0DD")),
                                                          child: Center(
                                                            child: Container(
                                                              clipBehavior: Clip.hardEdge,
                                                              height: 30.h,
                                                              width: Get.width,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(4.sp)),
                                                              child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(4.sp),
                                                                child: FadeInImage.assetNetwork(
                                                                  imageErrorBuilder: (context, error, stackTrace) {
                                                                    return Image.asset(
                                                                      "assets/images/placeholder.jpg",
                                                                      fit: BoxFit.fill,
                                                                    );
                                                                  },
                                                                  placeholder: "assets/images/placeholder.jpg",
                                                                  placeholderFit: BoxFit.fill,
                                                                  image: item.url.toString(),
                                                                  fit: BoxFit.cover,
                                                                ),
                                                                /*Image.network(
                                                                  item.url.toString(),
                                                                  fit: BoxFit.cover,
                                                                  width: Get.width,
                                                                  errorBuilder: (context, error, stack) {
                                                                    return Image.asset(
                                                                        "assets/images/placeholder.jpg",
                                                                        fit: BoxFit.cover);
                                                                  },
                                                                ),*/
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                options: CarouselOptions(
                                                    enableInfiniteScroll: false,
                                                    viewportFraction: 1,
                                                    autoPlay: true,
                                                    pageSnapping: true,
                                                    enlargeCenterPage: true,
                                                    height: 30.h,
                                                    onPageChanged: (index, val) {
                                                      setState(() {
                                                        print("new index $val");
                                                        currentIndex = index;
                                                      });
                                                    })),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Obx(
                                            () => fullVoileScreenController.turbanProductDetailApiModal!.value.data!
                                                        .productVariations!.data![0].images!.length ==
                                                    1
                                                ? const SizedBox()
                                                : Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: fullVoileScreenController.turbanProductDetailApiModal!
                                                        .value.data!.productVariations!.data![0].images!
                                                        .map((image) {
                                                      int index = fullVoileScreenController.turbanProductDetailApiModal!
                                                          .value.data!.productVariations!.data![0].images!
                                                          .indexOf(image);
                                                      return Container(
                                                        width: 10.0,
                                                        height: 10.0,
                                                        margin:
                                                            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: currentIndex == index
                                                              ? fullVoileScreenController.appColors.darkYellowColor
                                                              : Colors.grey,
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                          ),
                                          SizedBox(
                                            height: 0.h,
                                          ),
                                          Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 1.w),
                                              child: Html(
                                                data: fullVoileScreenController.turbanProductDetailApiModal!.value.data!
                                                    .productVariations!.data![0].description
                                                    .toString(),
                                                shrinkWrap: true,
                                                style: {
                                                  "body": Style(
                                                      textAlign: TextAlign.start,
                                                      color: fullVoileScreenController.appColors.whiteColor,
                                                      fontFamily: "Arial",
                                                      fontSize: FontSize.medium),
                                                  "p": Style(
                                                      color: fullVoileScreenController.appColors.whiteColor,
                                                      fontFamily: "Arial",
                                                      textAlign: TextAlign.start,
                                                      fontSize: FontSize.medium),
                                                  "h1": Style(
                                                      textAlign: TextAlign.start,
                                                      color: fullVoileScreenController.appColors.whiteColor,
                                                      fontFamily: "Arial",
                                                      fontSize: FontSize.medium),
                                                  "ul": Style(
                                                      textAlign: TextAlign.start,
                                                      color: fullVoileScreenController.appColors.whiteColor,
                                                      fontFamily: "Arial",
                                                      fontSize: FontSize.medium),
                                                },
                                              )),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                                            child: Text(
                                              'length_in_meter'.tr,
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: fullVoileScreenController.appColors.whiteColor,
                                                  fontFamily: "Arial"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              fullVoileScreenController.toggleVisibility();
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                                                  width: 88.w,
                                                  height: 6.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius: fullVoileScreenController.isVisible.value
                                                        ? BorderRadius.only(
                                                            topLeft: Radius.circular(3.sp),
                                                            topRight: Radius.circular(3.sp))
                                                        : BorderRadius.circular(3.sp),
                                                    color: fullVoileScreenController.appColors.textfieldBoxColor,
                                                  ),
                                                  child: DropdownButtonHideUnderline(
                                                    child: DropdownButton(
                                                      hint: GetBuilder(
                                                        id: "itemLength",
                                                        init: fullVoileScreenController,
                                                        builder: (controller) {
                                                          return Text(
                                                            controller.selectedTurbanLength.value.key ??
                                                                controller.turbanProductDetailApiModal!.value.data!
                                                                    .length![0].key
                                                                    .toString(),
                                                            style: const TextStyle(color: Colors.white),
                                                          );
                                                        },
                                                        // Text(
                                                        //     fullVoileScreenController.selectedTurbanLength.value.key ??
                                                        //         fullVoileScreenController.turbanProductDetailApiModal.value.data!
                                                        //             .productVariations![0].variation!.data![0].key
                                                        //             .toString(),
                                                        //
                                                        //     // fullVoileScreenController.selectedLengthItems.value.isNotEmpty
                                                        //     //     ? fullVoileScreenController.selectedLengthItems.value
                                                        //     //     : "Select Length",
                                                        //     style: const TextStyle(color: Colors.white),
                                                        //   ),
                                                      ),

                                                      dropdownColor:
                                                          fullVoileScreenController.appColors.textfieldBoxColor,
                                                      // Down Arrow Icon
                                                      icon: const Icon(
                                                        Icons.keyboard_arrow_down,
                                                        color: Colors.white,
                                                      ),
                                                      // Array list of items
                                                      items: fullVoileScreenController
                                                          .turbanProductDetailApiModal!.value.data!.length!
                                                          .map((modal.Length items) {
                                                        //items: fullVoileScreenController.selectLength.map((items) {
                                                        return DropdownMenuItem(
                                                          value: items.key,
                                                          child: Text(
                                                            items.key ?? "",
                                                            style: const TextStyle(color: Colors.white),
                                                          ),
                                                        );
                                                      }).toList(),
                                                      // After selecting the desired option,it will
                                                      // change button value to selected value
                                                      onChanged: (newValue) {
                                                        fullVoileScreenController.selectedTurbanLength.value.key =
                                                            newValue!;
                                                        fullVoileScreenController.update(['itemLength']);
                                                        fullVoileScreenController.totalPrice();
                                                      },
                                                    ),
                                                  )),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                                            child: Text(
                                              fullVoileScreenController
                                                      .turbanProductDetailApiModal!.value.data!.productVariations!.key
                                                      .toString() ??
                                                  "",
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: fullVoileScreenController.appColors.whiteColor,
                                                  fontFamily: "Arial"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              fullVoileScreenController.toggleVisibility1();
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 3.w),
                                                width: 88.w,
                                                height: 6.h,
                                                decoration: BoxDecoration(
                                                  borderRadius: fullVoileScreenController.isVisible1.value
                                                      ? BorderRadius.only(
                                                          topLeft: Radius.circular(3.sp),
                                                          topRight: Radius.circular(3.sp))
                                                      : BorderRadius.circular(3.sp),
                                                  color: fullVoileScreenController.appColors.textfieldBoxColor,
                                                ),
                                                child: DropdownButtonHideUnderline(
                                                  child: DropdownButton(
                                                    hint: Text(
                                                      fullVoileScreenController.brandData.value.brandName ??
                                                          fullVoileScreenController.turbanProductDetailApiModal!.value
                                                              .data!.productVariations!.data![0].brandName
                                                              .toString(),
                                                      style: const TextStyle(color: Colors.white),
                                                    ),
                                                    dropdownColor:
                                                        fullVoileScreenController.appColors.textfieldBoxColor,
                                                    // Down Arrow Icon
                                                    icon: const Icon(
                                                      Icons.keyboard_arrow_down,
                                                      color: Colors.white,
                                                    ),
                                                    // Array list of items
                                                    items: fullVoileScreenController.turbanProductDetailApiModal!.value
                                                        .data!.productVariations!.data!
                                                        .map((items) {
                                                      return DropdownMenuItem(
                                                        value: items,
                                                        child: Text(
                                                          items.brandName ?? "",
                                                          style: const TextStyle(color: Colors.white),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    // After selecting the desired option,it will
                                                    // change button value to selected value
                                                    onChanged: (newValue) {
                                                      fullVoileScreenController.selectedBrand(newValue!);
                                                      fullVoileScreenController
                                                          .selectPrice(int.parse(newValue.price ?? ""));
                                                      fullVoileScreenController.toggleVisibility1();
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          fullVoileScreenController
                                                      .turbanProductDetailApiModal!.value.data!.stichingPrice ==
                                                  null
                                              ? const SizedBox.shrink()
                                              : Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'piko_/_stitch'.tr,
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: fullVoileScreenController.appColors.whiteColor,
                                                            fontFamily: "Arial"),
                                                      ),
                                                      Text(
                                                        " ₹${fullVoileScreenController.turbanProductDetailApiModal!.value.data!.stichingPrice.toString()}",
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: fullVoileScreenController.appColors.whiteColor,
                                                            fontFamily: "Arial"),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                          SizedBox(
                                            height: 1.5.h,
                                          ),
                                          fullVoileScreenController
                                                      .turbanProductDetailApiModal!.value.data!.stichingPrice ==
                                                  null
                                              ? const SizedBox.shrink()
                                              : Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                  child: Obx(
                                                    () => Row(
                                                      children: [
                                                        fullVoileScreenController.CustomRadioButton(1),
                                                        Text(
                                                          'yes'.tr,
                                                          style: TextStyle(
                                                              fontSize: 12.sp,
                                                              color: fullVoileScreenController.appColors.whiteColor,
                                                              fontFamily: "Arial"),
                                                        ),
                                                        SizedBox(
                                                          width: 2.w,
                                                        ),
                                                        fullVoileScreenController.CustomRadioButton(2),
                                                        Text(
                                                          'no'.tr,
                                                          style: TextStyle(
                                                              fontSize: 12.sp,
                                                              color: fullVoileScreenController.appColors.whiteColor,
                                                              fontFamily: "Arial"),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                          SizedBox(
                                            height: 2.0.h,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8),
                                            child: Text(
                                              'Price:'.tr,
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: fullVoileScreenController.appColors.whiteColor,
                                                  fontFamily: "Arial"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 1.5.h,
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(left: 8),
                                              child: Obx(() => Text(
                                                    fullVoileScreenController.totalAmount.value,
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        color: fullVoileScreenController.appColors.whiteColor,
                                                        fontFamily: "Arial"),
                                                  ))),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.h),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                if (fullVoileScreenController.selectFav.isTrue) {
                                                  removeFav();
                                                } else {
                                                  fullVoileScreenController.favCheckOut(isFav: true);
                                                }
                                              },
                                              child: Container(
                                                height: 5.h,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5.sp),
                                                    color: fullVoileScreenController.appColors.blackColor,
                                                    border: Border.all(
                                                      color: fullVoileScreenController.appColors.borderColor,
                                                      width: 1,
                                                    )),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    fullVoileScreenController.selectFav.value
                                                        ? SvgPicture.asset(
                                                            "assets/images/FavIcon.svg",
                                                            color: Colors.red,
                                                          )
                                                        : SvgPicture.asset(
                                                            "assets/images/FavIcon.svg",
                                                            color: Colors.grey,
                                                          ),
                                                    SizedBox(
                                                      width: 1.w,
                                                    ),
                                                    Text(
                                                      'favorite'.tr,
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color: fullVoileScreenController.appColors.whiteColor,
                                                        fontFamily: "Arial",
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          Expanded(
                                            child: AppListItem(
                                              onClick: listClick,
                                              index: 2,
                                              color: fullVoileScreenController.appColors.lightgreenColor,
                                              fullvoileTurbanScreenController: fullVoileScreenController,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                ),
                Obx(
                  () => fullVoileScreenController.isLoading.value
                      ? Container(
                          height: Get.height,
                          width: Get.width,
                          color: Colors.black.withOpacity(.4),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: fullVoileScreenController.appColors.darkYellowColor,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                /*Positioned(
                  bottom: 10,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (fullVoileScreenController.selectFav.isTrue) {
                              removeFav();
                            } else {
                              fullVoileScreenController.favCheckOut(isFav: true);
                            }
                          },
                          child: Container(
                            height: 5.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.sp),
                                color: fullVoileScreenController.appColors.blackColor,
                                border: Border.all(
                                  color: fullVoileScreenController.appColors.borderColor,
                                  width: 1,
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                fullVoileScreenController.selectFav.value
                                    ? SvgPicture.asset(
                                        "assets/images/FavIcon.svg",
                                        color: Colors.red,
                                      )
                                    : SvgPicture.asset(
                                        "assets/images/FavIcon.svg",
                                        color: Colors.grey,
                                      ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Text(
                                  'favorite'.tr,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: fullVoileScreenController.appColors.whiteColor,
                                    fontFamily: "Arial",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        AppListItem(
                          onClick: listClick,
                          index: 2,
                          color: fullVoileScreenController.appColors.lightgreenColor,
                        )
                      ],
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    Get.dialog(StatefulBuilder(
      builder: (context, StateSetter setState) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  InteractiveViewer(
                    child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 1.1,
                        color: Colors.black54,
                        child: Image.network(fullVoileScreenController.turbanProductDetailApiModal!.value.data!
                            .productVariations!.data![0].images![fullVoileScreenController.isSelected.value].url
                            .toString())),
                  ),
                  Positioned(
                    top: 5.6.h,
                    right: 0,
                    width: 10.w,
                    child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset('assets/images/cancelIcon.svg')),
                  ),
                  Positioned(
                    bottom: 0.h,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: fullVoileScreenController
                                .turbanProductDetailApiModal!.value.data!.productVariations!.data![0].images!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: fullVoileScreenController.isSelected.value == index
                                            ? Border.all(
                                                color: Colors.red,
                                                width: 2,
                                              )
                                            : null,
                                        borderRadius: BorderRadius.circular(5.sp),
                                        color: HexColor("#FDF0DD")),
                                    clipBehavior: Clip.hardEdge,
                                    height: 85,
                                    width: 85,
                                    child: Image.network(fullVoileScreenController.turbanProductDetailApiModal!.value
                                        .data!.productVariations!.data![0].images![index].url
                                        .toString()),
                                  ),
                                  onTap: () {
                                    setState(() {});
                                    fullVoileScreenController.isSelected.value = index;
                                  },
                                ),
                              );
                            }),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    ));
  }

  late bool permissionStatus;

  void showOptionDialog() {
    Get.dialog(StatefulBuilder(builder: (context, StateSetter setState) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        scrollable: true,
        contentPadding: EdgeInsets.zero,
        content: Column(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    color: fullVoileScreenController.appColors.darkYellowColor,
                    child: Text(
                      "Akal Sahae",
                      style: TextStyle(
                          color: fullVoileScreenController.appColors.whiteColor,
                          fontFamily: "Poppins",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18, top: 10),
                    child: Text(
                      "-Camera permission to access your camera to upload profile picture.",
                      style: TextStyle(
                          color: fullVoileScreenController.appColors.grayColor,
                          fontFamily: "Poppins",
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18, top: 10, bottom: 10),
                    child: Text(
                      "-Media and Storage permission to access photos and media on your device to fetch and save photos.",
                      style: TextStyle(
                          color: fullVoileScreenController.appColors.grayColor,
                          fontFamily: "Poppins",
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 45,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: () async {
                              getImageFromCamera();
                              Get.back();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: fullVoileScreenController.appColors.darkYellowColor,
                              ),
                              child: Text(
                                "Ok",
                                style: TextStyle(
                                    color: fullVoileScreenController.appColors.whiteColor,
                                    fontFamily: "Poppins",
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: fullVoileScreenController.appColors.greenColor,
                              ),
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: fullVoileScreenController.appColors.whiteColor,
                                    fontFamily: "Poppins",
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
                    child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: fullVoileScreenController.appColors.grayColor,
                                fontFamily: "Poppins",
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500),
                            children: [
                          const TextSpan(
                            text: "By Continuing, you are agree to Akal Sahae's ",
                          ),
                          TextSpan(
                            text: "term_&_conditon".tr,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Uri openUrl = Uri.parse('https://nexever.tech/AkalSahae/terms_condition');
                                CommonMethods().openUrl(openUrl);
                              },
                            style: TextStyle(
                                color: fullVoileScreenController.appColors.darkYellowColor,
                                fontFamily: "Poppins",
                                fontSize: 11.sp,
                                decoration: TextDecoration.underline),
                          ),
                          const TextSpan(
                            text: "and",
                          ),
                          TextSpan(
                              text: "privacy_policy".tr,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Uri openUrl = Uri.parse('https://nexever.tech/AkalSahae/privacy-policy');
                                  CommonMethods().openUrl(openUrl);
                                },
                              style: TextStyle(
                                  color: fullVoileScreenController.appColors.darkYellowColor,
                                  fontFamily: "Poppins",
                                  fontSize: 11.sp,
                                  decoration: TextDecoration.underline)),
                          const TextSpan(
                            text: ".",
                          ),
                          TextSpan(
                            text: "".tr,
                            recognizer: TapGestureRecognizer(),
                          ),
                        ])),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18, top: 10, bottom: 10),
                    child: Text(
                      "-By tapping OK, you are agree to provide Akal Sahae the above mentioned permissions for the normal use of the app.",
                      style: TextStyle(
                          color: fullVoileScreenController.appColors.grayColor,
                          fontFamily: "Poppins",
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }));
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

  ///Favourite delete Dialog
  Future<bool?> removeFav() async {
    await Get.dialog(AlertDialog(
      scrollable: true,
      backgroundColor: fullVoileScreenController.appColors.lightBlackColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.sp)),
      content: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: fullVoileScreenController.appColors.lightBlackColor),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                'Warning',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: fullVoileScreenController.appColors.whiteColor,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Poppins",
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              'Are you sure',
              style: TextStyle(
                fontSize: 11.sp,
                color: fullVoileScreenController.appColors.whiteColor,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(
              height: 0.5.h,
            ),
            Text(
              'Remove your favourite product!',
              style: TextStyle(
                fontSize: 11.sp,
                color: fullVoileScreenController.appColors.whiteColor,
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
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10, right: 0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 100,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: fullVoileScreenController.appColors.darkYellowColor, width: 1),
                      ),
                      child: Text(
                        "NO",
                        style: TextStyle(
                            letterSpacing: 1.5,
                            color: fullVoileScreenController.appColors.whiteColor,
                            fontFamily: "Poppins",
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    fullVoileScreenController.favCheckOut(isFav: false);
                    Get.back(result: true);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10, right: 0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 100,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: fullVoileScreenController.appColors.darkYellowColor,
                      ),
                      child: Text(
                        "YES",
                        style: TextStyle(
                            letterSpacing: 1.5,
                            color: fullVoileScreenController.appColors.whiteColor,
                            fontFamily: "Poppins",
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
    return null;
  }

  listClick(GlobalKey widgetKey) async {
    // print(widgetKey.globalPaintBounds!.top);
    // print(widgetKey.currentContext!.size!.width);
    // print(widgetKey.currentContext!.size!.height);
    // print(widgetKey.currentContext!.size!.width);
    // print(widgetKey.currentContext!.size!.height);

    if (fullVoileScreenController.turbanProductDetailApiModal!.value.data!.productVariations!.data!.first.outOfStock
            .toString() ==
        "1") {
      await fullVoileScreenController.checkOut().then((value) {
        if (!value) {
          return;
        }

        runAddToCartAnimation(widgetKey);
        if (cartKey.currentState != null) {
          cartKey.currentState!
              .runCartAnimation((fullVoileScreenController.homeScreenController.counter.value).toString());
        }
      });
    }
    setState(() {});
  }
}

class AppListItem extends StatelessWidget {
  final GlobalKey widgetKey = GlobalKey();
  final int index;
  final void Function(GlobalKey) onClick;
  final Color color;
  final FullvoileTurbanScreenController fullvoileTurbanScreenController;

  AppListItem(
      {super.key,
      required this.onClick,
      required this.index,
      required this.color,
      required this.fullvoileTurbanScreenController});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(widgetKey),
      child: Container(
        height: 5.h,
        width: 43.w,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.sp), color: color),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (fullvoileTurbanScreenController
                    .turbanProductDetailApiModal!.value.data!.productVariations!.data!.first.outOfStock
                    .toString() !=
                "0")
              Container(
                key: widgetKey,
                height: 22,
                width: 22,
                child: Image.asset(
                  'assets/images/CartIcon.png',
                  width: 5.8.w,
                ),
              ),
            if (fullvoileTurbanScreenController
                    .turbanProductDetailApiModal!.value.data!.productVariations!.data!.first.outOfStock
                    .toString() !=
                "0")
              SizedBox(
                width: 1.w,
              ),
            Padding(
              padding: EdgeInsets.only(top: 0.3.h),
              child: fullvoileTurbanScreenController
                          .turbanProductDetailApiModal!.value.data!.productVariations!.data!.first.outOfStock
                          .toString() ==
                      "0"
                  ? Text("OUT OF STOCK", style: TextStyle(fontSize: 10.sp, color: Colors.white, fontFamily: "Arial"))
                  : Text(
                      'add_to_cart'.tr,
                      style: TextStyle(fontSize: 10.sp, color: Colors.white, fontFamily: "Arial"),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/*GestureDetector(
                              onTap: () {
                                fullVoileScreenController.checkOut();
                              },
                              child: Container(
                                height: 5.h,
                                width: 43.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.sp),
                                    color: fullVoileScreenController.appColors.lightgreenColor),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/CartIcon.png', width: 5.8.w),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 0.3.h),
                                      child: Text(
                                        'add_to_cart'.tr,
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            color: fullVoileScreenController.appColors.whiteColor,
                                            fontFamily: "Arial"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),*/

/*Obx(() => Text(
                                fullVoileScreenController.brandId.value == (-1)
                                    ? "₹ 0.00"
                                    : fullVoileScreenController.selectedTurbanLength.value.key!.isNotEmpty
                                        ? "₹ 0.00"
                                        : fullVoileScreenController.value.value == 1 &&
                                                fullVoileScreenController
                                                    .turbanProductDetailApiModal.value.data!.stichingPrice!.isNotEmpty
                                            ? '₹ ${(double.parse(fullVoileScreenController.brandData.value.price.toString()) * double.parse(fullVoileScreenController.selectedTurbanLength.value.key.toString())) + double.parse(fullVoileScreenController.turbanProductDetailApiModal.value.data!.stichingPrice.toString())}'
                                            : '₹ ${(double.parse(fullVoileScreenController.brandData.value.price.toString()) * double.parse(fullVoileScreenController.selectedTurbanLength.value.key.toString())) ?? ""}',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: fullVoileScreenController.appColors.whiteColor,
                                    fontFamily: "Arial"),
                              )),*/
