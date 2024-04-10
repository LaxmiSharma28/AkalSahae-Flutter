import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:akalsahae/app/modules/Accessory_Product_detail/product_controller.dart';
import 'package:akalsahae/app/modules/accessories/accessories_controller.dart';
import 'package:akalsahae/app/modules/home_screen_module/home_screen_controller.dart';
import 'package:akalsahae/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart' as badges;

import '../../../main.dart';

class AccessoriesScreen extends StatelessWidget {
  AccessoriesScreen({super.key});

  final accessoriesController =
      Get.put<AccessoriesController>(AccessoriesController());
  final productController = Get.put<ProductController>(ProductController());
  final homeController = Get.find<HomeScreenController>();
  late Function(GlobalKey) runAddToCartAnimation;

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
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            toolbarHeight: 0.h,
            bottom: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black,
              title: Text(
                  "${accessoriesController.homeScreenController.selectedCloth.productName}"
                      .tr,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      fontFamily: "Poppins")),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 15.sp,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              actions: [
                Column(
                  children: [
                    SizedBox(
                      height: 1.5.h,
                    ),
                    homeController.counter.value == 0
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
                            // key: cartKey,
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Get.toNamed(Routes.CHECK_OUT_SCREEN);
                            },
                            child: badges.Badge(
                                badgeStyle: badges.BadgeStyle(
                                    badgeColor: accessoriesController
                                        .appColors.darkYellowColor,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5)),
                                position:
                                    badges.BadgePosition.topEnd(end: -8, top: -8),
                                badgeAnimation:
                                    const badges.BadgeAnimation.scale(),
                                badgeContent: Obx(
                                  () => Text(
                                    homeController.counter.toString(),
                                    style: TextStyle(
                                        color: accessoriesController
                                            .appColors.blackColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 8.sp),
                                  ),
                                ),
                                child: InkWell(
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
                SizedBox(
                  width: 6.5.w,
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              Obx(
                () => accessoriesController.isLoading.value
                    ? Container(
                        height: Get.height,
                        width: Get.width,
                        color: Colors.black.withOpacity(.4),
                        child: Center(
                          child: CircularProgressIndicator(
                            color:
                                accessoriesController.appColors.darkYellowColor,
                          ),
                        ),
                      )
                    : accessoriesController.getAccessoryApiModal.value.data ==
                            null
                        ? const Center(
                            child: Text("No Data Found",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    fontFamily: "Poppins",
                                    color: Colors.white)),
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 3.4 / 4,
                                            crossAxisSpacing: 2.3.w,
                                            mainAxisSpacing: 0.8.h),
                                    itemCount: accessoriesController
                                        .getAccessoryApiModal.value.data!.length,
                                    itemBuilder: (BuildContext ctx, index) {
                                      // final details = MainImage.favorite[index];
                                      return GestureDetector(
                                        onTap: () {
                                          accessoriesController.itemSelect = index;
                                          print(
                                              "Product name: ${accessoriesController.getAccessoryApiModal.value.data![index].productName.toString()}");
                                          print(
                                              "Product id: ${accessoriesController.getAccessoryApiModal.value.data![index].id.toString()}");
                                          // Get.toNamed(Routes.FULLVOILE_TURBAN_SCREEN, arguments: {
                                          //   "color_name":
                                          //   "",
                                          //   "product_id":
                                          //       accessoriesController.getAccessoryApiModal.value.data![index].id.toString() ??
                                          //           "",
                                          //   'name': accessoriesController
                                          //           .getAccessoryApiModal.value.data![index].productName
                                          //           .toString() ??
                                          //       ""
                                          // });
                                          Get.toNamed(Routes.ACCESSORY_PRODUCT,
                                              parameters: {
                                                "productId": accessoriesController
                                                        .getAccessoryApiModal
                                                        .value
                                                        .data![index]
                                                        .id
                                                        .toString() ??
                                                    "",
                                                'productName': accessoriesController
                                                    .getAccessoryApiModal
                                                    .value
                                                    .data![index]
                                                    .productName
                                                    .toString()
                                              });
                                        },
                                        child: Container(
                                          clipBehavior: Clip.hardEdge,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: accessoriesController
                                                  .appColors.blackColor,
                                              borderRadius:
                                                  BorderRadius.circular(4.sp)),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                top: 0.1.h,
                                                right: 0.1.w,
                                                left: 0.1.w,
                                                child: Container(
                                                  clipBehavior: Clip.hardEdge,
                                                  height: 21.h,
                                                  width: 14.w,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(4.sp),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              accessoriesController
                                                                      .getAccessoryApiModal
                                                                      .value
                                                                      .data![index]
                                                                      .image
                                                                      .toString() ??
                                                                  ""),
                                                          fit: BoxFit.cover)),
                                                  child: FadeInImage.assetNetwork(
                                                      imageErrorBuilder:
                                                          (context, error, stackTrace) {
                                                        return Image.asset(
                                                            "assets/images/placeholder.jpg",
                                                            fit: BoxFit.cover);
                                                      },
                                                      placeholder:
                                                          "assets/images/placeholder.jpg",
                                                      placeholderFit: BoxFit.cover,
                                                      image: accessoriesController
                                                              .getAccessoryApiModal
                                                              .value
                                                              .data![index]
                                                              .image
                                                              .toString() ??
                                                          "",
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0.5.h,
                                                right: 2.w,
                                                /* child: AppListData(
                                                    onClick: listClick,
                                                    index: index,
                                                    color: accessoriesController.appColors.darkYellowColor)*/
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.toNamed(
                                                        Routes.ACCESSORY_PRODUCT,
                                                        parameters: {
                                                          "productId":
                                                              accessoriesController
                                                                  .getAccessoryApiModal
                                                                  .value
                                                                  .data![index]
                                                                  .id
                                                                  .toString(),
                                                          'productName':
                                                              accessoriesController
                                                                  .getAccessoryApiModal
                                                                  .value
                                                                  .data![index]
                                                                  .productName
                                                                  .toString()
                                                        });
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 20.sp,
                                                    backgroundColor:
                                                        accessoriesController
                                                            .appColors.blackColor,
                                                    child: CircleAvatar(
                                                      radius: 17.sp,
                                                      backgroundColor:
                                                          accessoriesController
                                                              .appColors
                                                              .darkYellowColor,
                                                      child: Image.asset(
                                                        "assets/images/CartIcon.png",
                                                        fit: BoxFit.cover,
                                                        width: 5.5.w,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: -2,
                                                left: 0.3.w,
                                                child: accessoriesController
                                                            .getAccessoryApiModal
                                                            .value
                                                            .data![index]
                                                            .productName!
                                                            .length >
                                                        20
                                                    ? Text(
                                                        "${accessoriesController.getAccessoryApiModal.value.data![index].productName.toString().substring(0, 12)}....",
                                                        style: TextStyle(
                                                            color: accessoriesController
                                                                .appColors.whiteColor,
                                                            fontFamily: "Poppins",
                                                            fontSize: 12.sp),
                                                      )
                                                    : Text(
                                                        accessoriesController
                                                                .getAccessoryApiModal
                                                                .value
                                                                .data![index]
                                                                .productName
                                                                .toString() ??
                                                            "",
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            color: accessoriesController
                                                                .appColors.whiteColor,
                                                            fontFamily: "Poppins",
                                                            fontSize: 12.sp),
                                                      ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                const SizedBox(
                                  height: 15,
                                ),
                                ],
                              ),
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  listClick(GlobalKey widgetKey, int index) async {
    await productController
        .checkOut(
            productId: accessoriesController
                .getAccessoryApiModal.value.data![index].id
                .toString(),
            price: "100")
        .then((value) {
      if (!value) {
        return;
      }

      runAddToCartAnimation(widgetKey);
      if (cartKey.currentState != null)
        cartKey.currentState!
            .runCartAnimation((homeController.counter.toString()).toString());
    });
  }
}

class AppListData extends StatelessWidget {
  final GlobalKey widgetKey = GlobalKey();
  final int index;
  final void Function(GlobalKey, int) onClick;
  final Color color;

  AppListData(
      {super.key,
      required this.onClick,
      required this.index,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(widgetKey, index),
      child: CircleAvatar(
        radius: 20.sp,
        backgroundColor: Colors.black,
        child: Container(
          key: widgetKey,
          child: CircleAvatar(
            radius: 17.sp,
            backgroundColor: color,
            child: Image.asset(
              "assets/images/CartIcon.png",
              fit: BoxFit.cover,
              width: 5.5.w,
            ),
          ),
        ),
      ),
    );
  }
}
