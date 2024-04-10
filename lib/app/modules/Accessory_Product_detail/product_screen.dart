import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:akalsahae/app/modules/Accessory_Product_detail/product_controller.dart';
import 'package:akalsahae/app/routes/app_pages.dart';
import 'package:akalsahae/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart' as badges;

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductController productController = Get.find<ProductController>();

  late Function(GlobalKey) runAddToCartAnimation;

  @override
  void initState() {
    if (Get.parameters != null && Get.parameters.isNotEmpty) {
      productController.productId.value = Get.parameters["productId"] ?? "";
      productController.productName.value = Get.parameters['productName'] ?? "";
      productController.getProductData(productId: productController.productId.value);
    }
    productController.refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      cartKey: cartKey2,
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
      child: Obx(
        () => SafeArea(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.black,
                appBar: AppBar(
                  toolbarHeight: 0.h,
                  backgroundColor: Colors.black,
                  automaticallyImplyLeading: false,
                  bottom: AppBar(
                    centerTitle: true,
                    automaticallyImplyLeading: false,
                    titleSpacing: 0.5.sp,
                    backgroundColor: Colors.black,
                    title: Padding(
                      padding: const EdgeInsets.only(right: 30.0, left: 6),
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
                              Obx(
                                () => productController.productName.value.length > 20
                                    ? Text("${productController.productName.value.toString().substring(0, 20)}...",
                                        style: TextStyle(fontSize: 14.sp, fontFamily: "Poppins"))
                                    : Text(
                                        productController.productName.value.toString(),
                                        style: TextStyle(fontSize: 14.sp, fontFamily: "Poppins"),
                                      ),
                              ),
                            ],
                          ),
                          productController.homeScreenController.counter.value == 0
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
                                  key: cartKey2,
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    Get.toNamed(Routes.CHECK_OUT_SCREEN);
                                  },
                                  child: badges.Badge(
                                      badgeStyle: badges.BadgeStyle(
                                          badgeColor: productController.homeScreenController.appColors.darkYellowColor,
                                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5)),
                                      position: badges.BadgePosition.topEnd(end: -8, top: -8),
                                      badgeAnimation: const badges.BadgeAnimation.scale(),
                                      badgeContent: Obx(
                                        () => Text(
                                          productController.homeScreenController.counter.toString(),
                                          style: TextStyle(
                                              color: productController.homeScreenController.appColors.blackColor,
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
                    ),
                    // title: Obx(
                    //   () => productController.productName.value.length > 20
                    //       ? Text(
                    //           "${productController.productName.value.toString().substring(0, 20)}...",
                    //           style:
                    //               TextStyle(fontSize: 14.sp, fontFamily: "Poppins"))
                    //       : Text(
                    //           productController.productName.value.toString(),
                    //           style:
                    //               TextStyle(fontSize: 14.sp, fontFamily: "Poppins"),
                    //         ),
                    // ),
                  ),
                ),
                body: productController.isLoading.value == true
                    ? Center(
                        child: CircularProgressIndicator(
                          color: productController.appColors.darkYellowColor,
                        ),
                      )
                    : productController.accessoryProductDetailApiModal.value.data == null
                        ? const Center(
                            child: Text("No Accessory Found",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    fontFamily: "Poppins",
                                    color: Colors.white)),
                          )
                        : Obx(
                            () => Column(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ListView(
                                          padding: EdgeInsets.symmetric(horizontal: 7.3.w, vertical: 0.2.h),
                                          shrinkWrap: true,
                                          physics: const BouncingScrollPhysics(),
                                          children: [
                                            GestureDetector(
                                              child: Container(
                                                clipBehavior: Clip.hardEdge,
                                                height: 28.h,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(4.sp),
                                                    image: DecorationImage(
                                                        image: NetworkImage(productController
                                                                .accessoryProductDetailApiModal.value.data!.image
                                                                .toString() ??
                                                            ""),
                                                        fit: BoxFit.fill)),
                                                child: FadeInImage.assetNetwork(
                                                  imageErrorBuilder: (context, error, stackTrace) {
                                                    return Image.asset("assets/images/placeholder.jpg", fit: BoxFit.fill);
                                                  },
                                                  placeholder: "assets/images/placeholder.jpg",
                                                  placeholderFit: BoxFit.fill,
                                                  image: productController
                                                      .accessoryProductDetailApiModal.value.data!.image
                                                      .toString(),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              onTap: () {
                                                showAlertDialog(context);
                                              },
                                            ),
                                            SizedBox(
                                              height: 3.h,
                                            ),
                                            Text(
                                              productController.accessoryProductDetailApiModal.value.data!.productName ??
                                                  "",
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: productController.appColors.whiteColor,
                                                  fontFamily: "Arial"),
                                            ),
                                            SizedBox(
                                              height: 3.h,
                                            ),
                                            if (productController
                                                    .accessoryProductDetailApiModal.value.data!.description !=
                                                null)
                                              Html(
                                                data: productController
                                                    .accessoryProductDetailApiModal.value.data!.description
                                                    .toString(),
                                                shrinkWrap: true,
                                                style: {
                                                  "body": Style(
                                                      textAlign: TextAlign.start,
                                                      color: productController.appColors.whiteColor,
                                                      fontFamily: "Arial",
                                                      fontSize: FontSize.medium),
                                                  "p": Style(
                                                      color: productController.appColors.whiteColor,
                                                      fontFamily: "Arial",
                                                      textAlign: TextAlign.start,
                                                      fontSize: FontSize.medium),
                                                  "h1": Style(
                                                      textAlign: TextAlign.start,
                                                      color: productController.appColors.whiteColor,
                                                      fontFamily: "Arial",
                                                      fontSize: FontSize.medium),
                                                  "li": Style(
                                                      textAlign: TextAlign.start,
                                                      color: productController.appColors.whiteColor,
                                                      fontFamily: "Arial",
                                                      fontSize: FontSize.medium),
                                                  "ul": Style(
                                                      textAlign: TextAlign.start,
                                                      color: productController.appColors.whiteColor,
                                                      fontFamily: "Arial",
                                                      fontSize: FontSize.medium),
                                                },
                                              ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            if (productController
                                                    .accessoryProductDetailApiModal.value.data!.productVariations !=
                                                null)
                                              if (productController.accessoryProductDetailApiModal.value.data!
                                                      .productVariations!.data !=
                                                  null)
                                                if (productController.accessoryProductDetailApiModal.value.data!
                                                    .productVariations!.data!.isNotEmpty)
                                                  Text("Size",
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          color: productController.appColors.whiteColor,
                                                          fontFamily: "Arial")),
                                            if (productController
                                                    .accessoryProductDetailApiModal.value.data!.productVariations !=
                                                null)
                                              if (productController.accessoryProductDetailApiModal.value.data!
                                                      .productVariations!.data !=
                                                  null)
                                                if (productController.accessoryProductDetailApiModal.value.data!
                                                    .productVariations!.data!.isNotEmpty)
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                            if (productController
                                                    .accessoryProductDetailApiModal.value.data!.productVariations !=
                                                null)
                                              if (productController.accessoryProductDetailApiModal.value.data!
                                                      .productVariations!.data !=
                                                  null)
                                                if (productController.accessoryProductDetailApiModal.value.data!
                                                    .productVariations!.data!.isNotEmpty)
                                                  GestureDetector(
                                                    onTap: () {
                                                      productController.toggleVisibility1();
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                                                      width: 88.w,
                                                      height: 6.h,
                                                      decoration: BoxDecoration(
                                                        borderRadius: productController.isVisible1.value
                                                            ? BorderRadius.only(
                                                                topLeft: Radius.circular(3.sp),
                                                                topRight: Radius.circular(3.sp))
                                                            : BorderRadius.circular(3.sp),
                                                        color: productController.appColors.textfieldBoxColor,
                                                      ),
                                                      child: DropdownButtonHideUnderline(
                                                        child: DropdownButton(
                                                          hint: Obx(() => Text(
                                                                productController.sizeData.value,
                                                                style: const TextStyle(color: Colors.white),
                                                              )),
                                                          dropdownColor: productController.appColors.textfieldBoxColor,
                                                          // Down Arrow Icon
                                                          icon: const Icon(
                                                            Icons.keyboard_arrow_down,
                                                            color: Colors.white,
                                                          ),
                                                          // Array list of items
                                                          items: productController.accessoryProductDetailApiModal.value
                                                              .data!.productVariations!.data!
                                                              .map((items) {
                                                            return DropdownMenuItem(
                                                              value: items,
                                                              child: Text(
                                                                "${items.attributeValue}",
                                                                style: const TextStyle(color: Colors.white),
                                                              ),
                                                            );
                                                          }).toList(),
                                                          // After selecting the desired option,it will
                                                          // change button value to selected value
                                                          onChanged: (newValue) {
                                                            productController.sizeData.value =
                                                                "${newValue?.attributeValue}";
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Price:'.tr,
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      color: productController.appColors.whiteColor,
                                                      fontFamily: "Arial"),
                                                ),
                                                const SizedBox(
                                                  width: 5.0,
                                                ),
                                                Builder(builder: (context) {
                                                  String price = '';
                                                  if (productController.accessoryProductDetailApiModal.value.data!
                                                              .productVariations ==
                                                          null ||
                                                      productController.accessoryProductDetailApiModal.value.data!
                                                              .productVariations!.data ==
                                                          null ||
                                                      productController.accessoryProductDetailApiModal.value.data!
                                                          .productVariations!.data!.isEmpty) {
                                                    price =
                                                        "₹ ${productController.accessoryProductDetailApiModal.value.data!.price}";
                                                  } else {
                                                    price =
                                                        "₹ ${productController.accessoryProductDetailApiModal.value.data!.productVariations!.data!.first.price.toString()}";
                                                  }
                                                  if (price == '₹ null') {
                                                    price = '₹ 0';
                                                  }
                                                  return Text(
                                                    price,
                                                    style: TextStyle(
                                                        height: 0.2.h,
                                                        color: productController.appColors.whiteColor,
                                                        fontSize: 13.sp,
                                                        fontFamily: "Arial"),
                                                  );
                                                }),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 3.h,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (productController.selectFav.isTrue) {
                                          productController.removeFav(productController.productId.value);
                                        } else {
                                          productController.addToFavAccessoryData(
                                              productId: productController.productId.value);
                                        }
                                      },
                                      child: Container(
                                        height: 5.h,
                                        width: 40.w,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5.sp),
                                            color: productController.appColors.blackColor,
                                            border: Border.all(
                                              color: productController.appColors.borderColor,
                                              width: 1,
                                            )),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            productController.selectFav.value
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
                                                color: productController.appColors.whiteColor,
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
                                      color: productController.appColors.lightgreenColor,
                                      productController: productController,
                                    )
                                  ],
                                ),
                                SizedBox(height: 1.h)
                              ],
                            ),
                          )),
          ),
        ),
      ),
    );
  }

  listClick(GlobalKey widgetKey) async {
    if (!getOutOfStock(productController)) {
      if (productController.accessoryProductDetailApiModal.value.data!.productVariations == null ||
          productController.accessoryProductDetailApiModal.value.data!.productVariations!.data == null ||
          productController.accessoryProductDetailApiModal.value.data!.productVariations!.data!.isEmpty) {
        productController.price.value = "${productController.accessoryProductDetailApiModal.value.data!.price}";
      } else {
        productController.price.value = productController
            .accessoryProductDetailApiModal.value.data!.productVariations!.data!.first.price
            .toString();
      }
      if (productController.price.value == 'null') {
        productController.price.value = '0';
      }

      if (productController.accessoryProductDetailApiModal.value.data!.productVariations == null ||
          productController.accessoryProductDetailApiModal.value.data!.productVariations!.data == null ||
          productController.accessoryProductDetailApiModal.value.data!.productVariations!.data!.isEmpty) {
        productController.discount.value =
            "${productController.accessoryProductDetailApiModal.value.data!.discountOnMrp}";
      } else {
        productController.discount.value = productController
            .accessoryProductDetailApiModal.value.data!.productVariations!.data!.first.discountOnMrp
            .toString();
      }
      if (productController.discount.value == 'null') {
        productController.discount.value = '0';
      }

      await productController
          .checkOut(
              discount: productController.discount.value,
              price: productController.price.value,
              productId: productController.accessoryProductDetailApiModal.value.data!.id.toString())
          .then((value) {
        if (!value) {
          return;
        }

        runAddToCartAnimation(widgetKey);
        if (cartKey2.currentState != null) {
          cartKey2.currentState!.runCartAnimation((productController.homeScreenController.counter.value).toString());
        }
      });
    }
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
                        child: Image.network(
                          productController.accessoryProductDetailApiModal.value.data!.image.toString(),
                        )),
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
                ],
              ),
            ],
          ),
        );
      },
    ));
  }
}

bool getOutOfStock(ProductController productController) {
  if (productController.accessoryProductDetailApiModal.value.data != null) {
    if (productController.accessoryProductDetailApiModal.value.data!.productVariations != null) {
      if (productController.accessoryProductDetailApiModal.value.data!.productVariations!.data != null) {
        if (productController.accessoryProductDetailApiModal.value.data!.productVariations!.data!.isNotEmpty) {
          if (productController.accessoryProductDetailApiModal.value.data!.productVariations!.data!.first.quantity !=
              null) {
            if (productController.accessoryProductDetailApiModal.value.data!.productVariations!.data!.first.quantity
                    .toString() ==
                '0') {
              return true;
            } else {
              return false;
            }
          } else {
            return false;
          }
        }
      }
    }

    if (productController.accessoryProductDetailApiModal.value.data!.quantity != null) {
      if (productController.accessoryProductDetailApiModal.value.data!.quantity.toString() == '0') {
        return true;
      }
    }
  }
  return false;
}

class AppListItem extends StatelessWidget {
  final GlobalKey widgetKey = GlobalKey();
  final int index;
  final void Function(GlobalKey) onClick;
  final Color color;

  AppListItem(
      {super.key, required this.onClick, required this.index, required this.color, required this.productController});

  final ProductController productController;

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
            if (!getOutOfStock(productController))
              Container(
                key: widgetKey,
                height: 22,
                width: 22,
                child: Image.asset(
                  'assets/images/CartIcon.png',
                  width: 5.8.w,
                ),
              ),
            if (!getOutOfStock(productController))
              SizedBox(
                width: 1.w,
              ),
            Padding(
              padding: EdgeInsets.only(top: 0.3.h),
              child: getOutOfStock(productController)
                  ? Text(
                      'OUT OF STOCK'.tr,
                      style: TextStyle(fontSize: 10.sp, color: Colors.white, fontFamily: "Arial"),
                    )
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
