import 'package:akalsahae/app/modules/favorite_screen_module/FavApiModal.dart';
import 'package:akalsahae/helper_widget/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:akalsahae/app/modules/favorite_screen_module/favorite_screen_controller.dart';
import 'package:sizer/sizer.dart';
import '../../routes/app_pages.dart';
import '../home_screen_module/home_screen_controller.dart';

class FavoriteScreenPage extends StatefulWidget {
  const FavoriteScreenPage({Key? key}) : super(key: key);

  @override
  State<FavoriteScreenPage> createState() => _FavoriteScreenPageState();
}

class _FavoriteScreenPageState extends State<FavoriteScreenPage> {
  final favoriteScreenController = Get.put<FavoriteScreenController>(FavoriteScreenController());
  final homeScreenController = Get.put(HomeScreenController());
  AppColors appColors = AppColors();

  @override
  void initState() {
    favoriteScreenController.getFavList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: favoriteScreenController,
      builder: (context) {
        return NotificationListener<OverscrollIndicatorNotification>(
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
                title: Text('favorite_color'.tr,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, fontFamily: "Poppins")),
                centerTitle: true,
                actions: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      homeScreenController.counter.value == 0
                          ? GestureDetector(
                              behavior: HitTestBehavior.translucent,
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
                                      badgeColor: homeScreenController.appColors.darkYellowColor,
                                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5)),
                                  badgeAnimation: const badges.BadgeAnimation.scale(),
                                  badgeContent: Obx(
                                    () => Text(
                                      homeScreenController.counter.toString(),
                                      style: TextStyle(
                                          color: homeScreenController.appColors.blackColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10.sp),
                                    ),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.CHECK_OUT_SCREEN);
                                    },
                                    child: Image.asset(
                                      'assets/images/CartIcon.png',
                                      width: 6.w,
                                    ),
                                  )),
                            ),
                    ],
                  ),
                  SizedBox(
                    width: 9.w,
                  ),
                ],
              ),
            ),
            body: favoriteScreenController.loader.isTrue
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors().darkYellowColor,
                    ),
                  )
                : favoriteScreenController.favList.value.favorites == null ||
                        favoriteScreenController.favList.value.favorites!.isEmpty
                    ? const Center(
                        child: Text("No item add to favourite yet..",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17, fontFamily: "Poppins", color: Colors.white)),
                      )
                    : Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3.3 / 4,
                              crossAxisSpacing: 2.3.w,
                              mainAxisSpacing: 0.8.h),
                          itemCount: favoriteScreenController.favList.value.favorites!.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                if (favoriteScreenController.favList.value.favorites![index].colorSlug != null) {
                                  Get.toNamed(Routes.FULLVOILE_TURBAN_SCREEN, arguments: {
                                    "product_id":
                                        favoriteScreenController.favList.value.favorites![index].product!.id.toString(),
                                    "color_name": favoriteScreenController.favList.value.favorites![index].colorSlug,
                                    "name": favoriteScreenController.favList.value.favorites![index].product!.productName
                                        .toString()
                                  })?.then((value) {
                                    favoriteScreenController.getFavList();
                                  });
                                } else {
                                  Get.toNamed(Routes.ACCESSORY_PRODUCT, parameters: {
                                    "productId":
                                        favoriteScreenController.favList.value.favorites![index].product!.id.toString(),
                                    'productName': favoriteScreenController
                                        .favList.value.favorites![index].product!.productName
                                        .toString()
                                  })?.then((value) async {
                                    await favoriteScreenController.getFavList();
                                  });
                                }
                              },
                              child: Container(
                                height: 20.h,
                                width: 10.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: favoriteScreenController.appColors.blackColor,
                                  borderRadius: BorderRadius.circular(4.sp),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 0.1.h,
                                      right: 0.4.w,
                                      left: 0.4.w,
                                      bottom: 5.h,
                                      child: Container(
                                        height: 20.h,
                                        width: 10.w,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4.sp),
                                        ),
                                        child: Image.network(
                                          favoriteScreenController.favList.value.favorites![index].product!.image
                                              .toString(),
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child, event) {
                                            if (event == null) {
                                              return child;
                                            }
                                            return Image.asset(
                                              "assets/images/placeholder.jpg",
                                              fit: BoxFit.cover,
                                            );
                                          },
                                          errorBuilder: (context, error, stack) {
                                            return Image.asset("assets/images/placeholder.jpg", fit: BoxFit.cover);
                                          },
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => Positioned(
                                        bottom: 0.7.h,
                                        right: 2.w,
                                        child: GestureDetector(
                                          onTap: () async {
                                            showFavAlertDialog(favoriteScreenController.favList.value.favorites![index])
                                                .then((value) {
                                              if (value == true) {}
                                            });
                                          },
                                          child: CircleAvatar(
                                            radius: 19.sp,
                                            backgroundColor: favoriteScreenController.appColors.blackColor,
                                            child: CircleAvatar(
                                              radius: 16.sp,
                                              backgroundColor: favoriteScreenController.appColors.darkYellowColor,
                                              child: favoriteScreenController.favList.value.favorites != null &&
                                                      favoriteScreenController
                                                              .favList.value.favorites![index].isFavorite ==
                                                          //["is_favorite"] ==
                                                          1
                                                  ? const Icon(
                                                      Icons.favorite,
                                                      color: Colors.white,
                                                    )
                                                  : const Icon(
                                                      Icons.favorite,
                                                      color: Colors.red,
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 1.5.h,
                                      left: 1.5.w,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            child: Text(
                                              "${favoriteScreenController.favList.value.favorites![index].product!.productName}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: favoriteScreenController.appColors.whiteColor,
                                                  fontFamily: "Poppins",
                                                  fontSize: 12.sp),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ),
        );
      },
    );
  }

  String _shoImage(favorit) {
    if (favorit["product_variation_id"] != null) {
      return favorit["data"]["images"][0]["url"];
    } else {
      return favorit["data"]["image"];
    }
  }

  ///Favourite delete Dialog
  Future<bool?> showFavAlertDialog(Favorite param0) async {
    await Get.dialog(AlertDialog(
      scrollable: true,
      backgroundColor: appColors.lightBlackColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.sp)),
      content: Container(
        //height: 20.h,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: appColors.lightBlackColor),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                'Warning',
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
              'Are you sure',
              style: TextStyle(
                fontSize: 11.sp,
                color: appColors.whiteColor,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(
              height: 0.5.h,
            ),
            Text(
              "you want to remove favourite product?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.sp,
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
                        border: Border.all(color: appColors.darkYellowColor, width: 1),
                      ),
                      child: Text(
                        "NO",
                        style: TextStyle(
                            letterSpacing: 1.5,
                            color: appColors.whiteColor,
                            fontFamily: "Poppins",
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    // favoriteScreenController.removeFromFav(param0);

                    print("sdfksdjfkdsfj ${param0.toJson()}");
                    if (param0.colorSlug != null) {
                      favoriteScreenController.removeFromFav(param0);
                    } else {
                      favoriteScreenController.removeAccessoryFromFav(param0);
                    }

                    // if (param0["product_variation_id"] != null) {
                    //   favoriteScreenController.removeFromFav(param0);
                    // } else {
                    //   favoriteScreenController.removeAccessoryFromFav(param0);
                    // }
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
                        color: appColors.darkYellowColor,
                      ),
                      child: Text(
                        "YES",
                        style: TextStyle(
                            letterSpacing: 1.5,
                            color: appColors.whiteColor,
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
  }

  _showProductName(param0) {
    if (param0["product_variation_id"] != null) {
      if (param0["data"]["cloth_name"].length > 12) {
        return Text("${param0["data"]["cloth_name"].toString().substring(0, 12)}....",
            style: TextStyle(
                color: favoriteScreenController.appColors.whiteColor, fontFamily: "Poppins", fontSize: 12.sp));
      } else {
        return Text(param0["data"]["cloth_name"].toString(),
            style: TextStyle(
                color: favoriteScreenController.appColors.whiteColor, fontFamily: "Poppins", fontSize: 12.sp));
      }
    } else {
      if (param0["data"]["product_name"].length > 10) {
        return Text("${param0["data"]["product_name"].toString().substring(0, 10)}....",
            style: TextStyle(
                color: favoriteScreenController.appColors.whiteColor, fontFamily: "Poppins", fontSize: 12.sp));
      } else {
        return Text(param0["data"]["product_name"],
            style: TextStyle(
                color: favoriteScreenController.appColors.whiteColor, fontFamily: "Poppins", fontSize: 12.sp));
      }
    }
  }
}

/*
import 'package:akalsahae/helper_widget/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:akalsahae/app/modules/favorite_screen_module/favorite_screen_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../images.dart';
import '../../routes/app_pages.dart';



class FavoriteScreenPage extends StatefulWidget {
  const FavoriteScreenPage({Key? key}) : super(key: key);

  @override
  State<FavoriteScreenPage> createState() => _FavoriteScreenPageState();
}

class _FavoriteScreenPageState extends State<FavoriteScreenPage> {
  final favoriteScreenController =
  Get.put<FavoriteScreenController>(FavoriteScreenController());

  @override
  void initState() {
    favoriteScreenController.getFavList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: favoriteScreenController,
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black,
              toolbarHeight: 3.h,
              bottom: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.black,
                title: Text('favorite_color'.tr,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        fontFamily: "Poppins")),
                centerTitle: true,
                // leading: IconButton(
                //   icon: Icon(Icons.arrow_back_ios_new_outlined,size: 12.sp,),
                //   onPressed: () {
                //     Get.offNamed(Routes.BOTTOM_SCREEN);
                //   },
                // ),
                actions: [
                  Column(
                    children: [
                      SizedBox(
                        height: 2.2.h,
                      ),
                      badges.Badge(
                          badgeStyle: badges.BadgeStyle(
                              badgeColor: favoriteScreenController
                                  .appColors.darkYellowColor,
                              padding: EdgeInsets.symmetric(
                                  vertical: 0.2.h, horizontal: 0.8.w)),
                          position: badges.BadgePosition.topStart(start: 2.6.w),
                          badgeAnimation: const badges.BadgeAnimation.scale(),
                          badgeContent: Obx(
                                () => Text(
                              favoriteScreenController.counter.toString(),
                              style: TextStyle(
                                  color: favoriteScreenController
                                      .appColors.blackColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.sp),
                            ),
                          ),
                          child: Image.asset(
                            'assets/images/CartIcon.png',
                            width: 5.5.w,
                          )),
                    ],
                  ),
                  SizedBox(
                    width: 7.w,
                  ),
                ],
              ),
            ),
            body: favoriteScreenController.loader.isTrue
                ? Center(
                child: CircularProgressIndicator(
                  color: AppColors().darkYellowColor,
                ))
                : favoriteScreenController.favList.value.favorites!.isEmpty
                ? Center(
              child: Text("No Data Found",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17.sp,
                      fontFamily: "Poppins",
                      color: Colors.white)),
            )
                : Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 6.w, vertical: 2.h),
              child: GridView.builder(
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3.4 / 4,
                      crossAxisSpacing: 2.3.w,
                      mainAxisSpacing: 0.8.h),
                  itemCount: favoriteScreenController
                      .favList.value.favorites!.length,
                  itemBuilder: (BuildContext ctx, index) {
                    final details = MainImage.favorite[index];
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: favoriteScreenController
                              .appColors.blackColor,
                          borderRadius: BorderRadius.circular(3.sp)),
                      child: Stack(
                        children: [
                          Positioned(
                              bottom: 1.h,
                              left: 1.5.w,
                              child: Text(
                                "${details["name"]}",
                                style: TextStyle(
                                    color: favoriteScreenController
                                        .appColors.whiteColor,
                                    fontFamily: "Poppins",
                                    fontSize: 10.sp),
                              )),
                          Positioned(
                            top: 0.1.h,
                            right: 0.4.w,
                            left: 0.4.w,
                            child: Container(
                              height: 20.h,
                              width: 10.w,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(3.sp),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "${details["image"]}"),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          Obx(() => Positioned(
                              bottom: 0.7.h,
                              right: 2.w,
                              child: GestureDetector(
                                onTap: () {
                                  favoriteScreenController
                                      .removeFromFav(
                                      favoriteScreenController
                                          .favList
                                          .value
                                          .favorites![index]);
                                  */
/*  favoriteScreenController.counter++;
                                        favoriteScreenController.update();*/ /*

                                },
                                child: CircleAvatar(
                                  radius: 19.sp,
                                  backgroundColor:
                                  favoriteScreenController
                                      .appColors.blackColor,
                                  child: CircleAvatar(
                                    radius: 16.sp,
                                    backgroundColor:
                                    favoriteScreenController
                                        .appColors
                                        .darkYellowColor,
                                    child: favoriteScreenController
                                        .favList
                                        .value
                                        .favorites![index]
                                    ["is_favorite"] ==
                                        1
                                        ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                        : Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )))
                        ],
                      ),
                    );
                  }),
            ),
          );
        });
  }
}
*/
