import 'package:akalsahae/app/modules/shop_screen_module/shop_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../routes/app_pages.dart';

class ShopScreenPage extends StatefulWidget {
  String? id;
  String? name;

  ShopScreenPage({super.key, this.name, this.id});

  @override
  State<ShopScreenPage> createState() => _ShopScreenPageState();
}

class _ShopScreenPageState extends State<ShopScreenPage> {
  final controller = Get.put<ShopScreenController>(ShopScreenController());

  @override
  void initState() {
    controller.getColor(widget.id ?? "");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //controller.id.value=int.parse(id??"0");

    return Obx(() => NotificationListener<OverscrollIndicatorNotification>(
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
                title: Text("${controller.homeScreenController.selectedCloth.productName}".tr,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, fontFamily: "Poppins")),
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
                      controller.counter.value == 0
                          ? GestureDetector(
                              onTap: () async {
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
                                      badgeColor: controller.appColors.darkYellowColor,
                                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5)),
                                  position: badges.BadgePosition.topEnd(end: -8, top: -8),
                                  badgeAnimation: const badges.BadgeAnimation.scale(),
                                  badgeContent: Obx(
                                    () => Text(
                                      controller.counter.toString(),
                                      style: TextStyle(
                                          color: controller.appColors.blackColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 8.sp),
                                    ),
                                  ),
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.translucent,
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
                    width: 7.w,
                  ),
                ],
              ),
            ),
            body: controller.isLoading.isTrue
                ? Center(
                    child: CircularProgressIndicator(
                      color: controller.appColors.darkYellowColor,
                    ),
                  )
                : controller.getColorApiModal.value.colors == null || controller.getColorApiModal.value.colors!.isEmpty
                    ? const Center(
                        child: Text("No Colors Available",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17, fontFamily: "Poppins", color: Colors.white)),
                      )
                    : Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        child: GridView.builder(
                          physics:const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 3.5 / 4,
                                crossAxisSpacing: 2.3.w,
                                mainAxisSpacing: 0.8.h),
                            itemCount: controller.getColorApiModal.value.colors!.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return GestureDetector(
                                onTap: () {
                                  controller.itemForDetails.value = index;
                                  print(
                                      "color_name: ${controller.getColorApiModal.value.colors![index].slug.toString()}");
                                  print("product_id: ${widget.id.toString()}");
                                  print("name: ${widget.name.toString()}");
                                  Get.toNamed(Routes.FULLVOILE_TURBAN_SCREEN, arguments: {
                                    "color_name": controller.getColorApiModal.value.colors![index].slug.toString(),
                                    "product_id": widget.id.toString(),
                                    "name": widget.name
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: controller.appColors.blackColor,
                                      borderRadius: BorderRadius.circular(4.sp)),
                                  child: Stack(
                                    alignment: Alignment.bottomLeft,
                                    children: [
                                      Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          Container(
                                            alignment: Alignment.topCenter,
                                            height: 23.h,
                                            child: Container(
                                              clipBehavior: Clip.hardEdge,
                                              height: 19.5.h,
                                              width: Get.width,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4.sp),
                                              ),
                                              child: FadeInImage.assetNetwork(
                                                imageErrorBuilder: (context, error, stackTrace) {
                                                  return Image.asset(
                                                    "assets/images/placeholder.jpg",
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                                placeholder: "assets/images/placeholder.jpg",
                                                placeholderFit: BoxFit.cover,
                                                image:
                                                    controller.getColorApiModal.value.colors![index].image.toString(),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              controller.itemForDetails.value = index;
                                              print(
                                                  "Color Name:${controller.getColorApiModal.value.colors![index].slug.toString()}");
                                              print("product id:${widget.id.toString()}");
                                              print("Name :${widget.name.toString()}");
                                              Get.toNamed(Routes.FULLVOILE_TURBAN_SCREEN, arguments: {
                                                "color_name":
                                                    controller.getColorApiModal.value.colors![index].slug.toString(),
                                                "product_id": widget.id.toString(),
                                                "name": widget.name.toString()
                                              });
                                              //controller.counter++;
                                              //controller.update();
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 5.0),
                                              child: CircleAvatar(
                                                radius: 24,
                                                backgroundColor: controller.appColors.blackColor,
                                                child: CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor: controller.appColors.darkYellowColor,
                                                  child: Image.asset(
                                                    "assets/images/CartIcon.png",
                                                    fit: BoxFit.cover,
                                                    width: 5.6.w,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: controller.getColorApiModal.value.colors![index].colorName!.length > 12
                                            ? Text(
                                                "${controller.getColorApiModal.value.colors![index].colorName.toString().substring(0, 11)}....",
                                                style: TextStyle(
                                                    color: controller.appColors.whiteColor,
                                                    fontFamily: "Poppins",
                                                    fontSize: 12.sp),
                                              )
                                            : Text(
                                                controller.getColorApiModal.value.colors![index].colorName.toString(),
                                                style: TextStyle(
                                                    color: controller.appColors.whiteColor,
                                                    fontFamily: "Poppins",
                                                    fontSize: 12.sp),
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })),
          ),
        ));
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
