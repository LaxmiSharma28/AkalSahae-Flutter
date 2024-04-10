import 'package:akalsahae/app/apiCollection/api_client.dart';
import 'package:akalsahae/app/modules/accessories/accessories_screen.dart';
import 'package:akalsahae/app/modules/check_out_screen_module/check_out_screen_controller.dart';
import 'package:akalsahae/app/modules/save_address_screen_module/save_address_screen_controller.dart';
import 'package:akalsahae/app/modules/shop_screen_module/shop_screen_page.dart';
import 'package:badges/badges.dart' as badges;
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:akalsahae/app/modules/home_screen_module/home_screen_controller.dart';
import 'package:sizer/sizer.dart';
import '../../routes/app_pages.dart';
import '../../utils/common_methods.dart';

class HomeScreenPage extends GetView<HomeScreenController> {
  final homeScreenControler = Get.put<HomeScreenController>(HomeScreenController());
  final checkOutController = Get.put(CheckOutScreenController());
  final saveAddressController = Get.put(SaveAddressScreenController());
  CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    /// call back function
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getFcmToken();
      controller.getHomeCategory(fromHomeScreen: false);
      checkOutController.getCart();
      saveAddressController.getAddressData();
    });

    return Obx(
      () => NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            toolbarHeight: 0.h,
            bottom: AppBar(
              automaticallyImplyLeading: false,
              title: Image.asset(
                "assets/images/logo 1.png",
                color: homeScreenControler.appColors.whiteColor,
                width: 27.w,
              ),
              backgroundColor: Colors.black,
              centerTitle: true,
              actions: [
                Column(
                  children: [
                    SizedBox(
                      height: 1.8.h,
                    ),
                    homeScreenControler.counter.value == 0
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
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Get.toNamed(Routes.CHECK_OUT_SCREEN);
                            },
                            child: badges.Badge(
                                badgeStyle: badges.BadgeStyle(
                                    badgeColor: homeScreenControler.appColors.darkYellowColor,
                                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5)),
                                position: badges.BadgePosition.topEnd(end: -8, top: -8),
                                badgeAnimation: const badges.BadgeAnimation.scale(),
                                badgeContent: Obx(
                                  () => GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      Get.toNamed(Routes.CHECK_OUT_SCREEN);
                                    },
                                    child: Text(
                                      homeScreenControler.counter.toString(),
                                      style: TextStyle(
                                          color: homeScreenControler.appColors.blackColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 8.sp),
                                    ),
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
                SizedBox(
                  width: 8.w,
                ),
                // Image.asset(
                //   'assets/images/CartIcon.png',
                //   width: 5.w,
                // ),
                // SizedBox(
                //   width: 5.w,
                // ),
              ],
            ),
          ),
          body: homeScreenControler.isLoading.isTrue
              ? Center(
                  child: CircularProgressIndicator(
                  color: homeScreenControler.appColors.darkYellowColor,
                ))
              : homeScreenControler.getCategoryApiModal.value.data == null
                  ? const Center(
                      child: Text("No Data Found",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17, fontFamily: "Poppins", color: Colors.white)),
                    )
                  : ListView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.5.h,
                        vertical: 0.2.h,
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 3.9 / 4,
                                crossAxisSpacing: 2.2.w,
                                mainAxisSpacing: 0.7.h),
                            itemCount: homeScreenControler.getCategoryApiModal.value.data!.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return GestureDetector(
                                onTap: () {
                                  homeScreenControler.selectedCloth =
                                      homeScreenControler.getCategoryApiModal.value.data![index];

                                  print("IDD: ${homeScreenControler.getCategoryApiModal.value.data![index].isProduct}");
                                  if (homeScreenControler.getCategoryApiModal.value.data![index].isProduct == 0) {
                                    Get.to(() => AccessoriesScreen());
                                  } else {
                                    print("ID:${homeScreenControler.selectedCloth.id}");
                                    print(
                                        "Name:${homeScreenControler.getCategoryApiModal.value.data![index].productName.toString()}");
                                    Get.to(
                                      () => ShopScreenPage(
                                        id: homeScreenControler.getCategoryApiModal.value.data![index].id.toString(),
                                        name: homeScreenControler.getCategoryApiModal.value.data![index].productName
                                            .toString(),
                                      ),
                                    );
                                  }

                                  /* if (homeScreenControler.selectedCloth.id != null) {
                                        Get.to(() => AccessoriesScreen());
                                      } else {
                                        Get.to(
                                          () => ShopScreenPage(
                                            id: homeScreenControler.getCategoryApiModal.value.data![index].id.toString(),
                                            name: homeScreenControler.getCategoryApiModal.value.data![index].productName
                                                .toString(),
                                          ),
                                        );
                                      }*/
                                },
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.sp),
                                    // image: DecorationImage(
                                    //   image: NetworkImage(homeScreenControler
                                    //           .getCategoryApiModal.value.data!.clothType![index].image
                                    //           .toString() ??
                                    //       ""),
                                    // )
                                  ),
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      ClipRRect(
                                        clipBehavior: Clip.hardEdge,
                                        borderRadius: BorderRadius.circular(4.sp),
                                        child: Image.network(
                                            homeScreenControler.getCategoryApiModal.value.data![index].image
                                                    .toString() ??
                                                "", loadingBuilder: (context, child, event) {
                                          if (event == null) {
                                            return child;
                                          }
                                          return Image.asset(
                                            "assets/images/placeholder.jpg",
                                            fit: BoxFit.cover,
                                          );
                                        }),
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 15.h),
                                          child: Container(
                                            height: 3.3.h,
                                            width: 35.w,
                                            padding: const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12.sp),
                                              color: homeScreenControler.colors[index].withOpacity(0.8),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              homeScreenControler.getCategoryApiModal.value.data![index].productName
                                                  .toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 3.4.w,
                                                  color: homeScreenControler.appColors.whiteColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Poppins"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Uri openUrl = Uri.parse(
                                homeScreenControler.getCategoryApiModal.value.banner!.first.bannerUrl.toString());

                            try {
                              CommonMethods().openUrl(openUrl);
                            } catch (e, st) {
                              ApiClient.toAst(e.toString());
                            }
                          },
                          child: Container(
                            height: 25.h,
                            width: Get.width,
                            child: CarouselSlider(
                                carouselController: carouselController,
                                items: homeScreenControler.getCategoryApiModal.value.banner!
                                    .map(
                                      (item) => Container(
                                        clipBehavior: Clip.hardEdge,
                                        margin: EdgeInsets.only(bottom: 5.h),
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4.sp),
                                          color: homeScreenControler.appColors.skinColor,
                                        ),
                                        child: FadeInImage.assetNetwork(
                                          imageErrorBuilder: (context, error, stackTrace) {
                                            return Image.asset(
                                              "assets/images/placeholder.jpg",
                                              fit: BoxFit.fill,
                                            );
                                          },
                                          placeholder: "assets/images/placeholder.jpg",
                                          placeholderFit: BoxFit.fill,
                                          image: item.bannerImages.toString(),
                                          fit: BoxFit.cover,
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
                                    onPageChanged: (index, val) {
                                      currentIndex = index;
                                    })),
                          ),
                        )
                      ],
                    ),
        ),
      ),
    );
  }

  void _getFcmToken() async {
    var fcmToken = await FirebaseMessaging.instance.getToken();
    print("FCM============>$fcmToken");
  }
}

// Container(
//   clipBehavior: Clip.hardEdge,
//   margin: EdgeInsets.only(bottom: 5.h),
//   height: 18.h,
//   width: 45.w,
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(3.sp),
//     color: homeScreenControler.appColors.skinColor,
//   ),
//   child: FadeInImage.assetNetwork(
//     imageErrorBuilder: (context, error, stackTrace) {
//       return Image.asset(
//         "assets/images/placeholder.jpg",
//         fit: BoxFit.fill,
//       );
//     },
//     placeholder: "assets/images/placeholder.jpg",
//     placeholderFit: BoxFit.fill,
//     image:
//         homeScreenControler.getCategoryApiModal.value.banner!.first.bannerImages.toString(),
//     fit: BoxFit.cover,
//   ),
//   /*Image.network(
//     homeScreenControler.getCategoryApiModal.value.banner!.first.bannerImages.toString(),
//     fit: BoxFit.cover,
//     errorBuilder: (context, error, stack) {
//       return Image.asset(
//           "assets/images/placeholder.jpg",
//           fit: BoxFit.fill);
//     },
//   ),*/
// ),

/*Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 2.h, left: 3.8.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/images/logo 1.png",
                                        height: 2.7.h,
                                        color: homeScreenControler.appColors.blackColor,
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: "buy".tr,
                                            style: TextStyle(
                                                color: homeScreenControler.appColors.blackColor,
                                                fontSize: 12.sp,
                                                fontFamily: "Arial",
                                                fontWeight: FontWeight.w700)),
                                        TextSpan(
                                            text: "turban_online".tr,
                                            style: TextStyle(
                                                color: const Color(0xff924E14),
                                                // color: HexColor("924E14"),
                                                fontSize: 12.sp,
                                                fontFamily: "Arial",
                                                fontWeight: FontWeight.w700))
                                      ])),
                                      Text(
                                        "with_wide_range".tr,
                                        style: TextStyle(
                                            color: homeScreenControler.appColors.blackColor,
                                            fontFamily: "Arial",
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(height: 12.sp),
                                      Row(
                                        children: [
                                          Text(
                                            "shop_now".tr,
                                            style: TextStyle(
                                                fontSize: 8.sp,
                                                color: homeScreenControler.appColors.blackColor,
                                                fontFamily: "Arial"),
                                          ),
                                          SizedBox(
                                            width: 1.w,
                                          ),
                                          Image.asset(
                                            "assets/images/Vector.png",
                                            height: 0.8.h,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 1.h),
                                  child: Container(
                                    height: 18.h,
                                    width: 38.w,

                                    // decoration: const BoxDecoration(
                                    //     image: DecorationImage(
                                    //         image: AssetImage('assets/images/Groupimage.png'), fit: BoxFit.cover)),
                                    child: Image.network(
                                        height: 18.h,
                                        width: 38.w,
                                        fit: BoxFit.cover,
                                        homeScreenControler.getCategoryApiModal.value.banner!.first.bannerImages
                                                .toString() ??
                                            "", loadingBuilder: (context, child, event) {
                                      if (event == null) {
                                        return child;
                                      }
                                      return Image.asset(
                                        'assets/images/Groupimage.png',
                                        fit: BoxFit.cover,
                                      );
                                    }),
                                  ),
                                )
                              ],
                            ),*/
