import 'dart:convert';
import 'package:akalsahae/app/modules/my_order_screen_module/oder_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:akalsahae/app/modules/my_order_screen_module/my_order_screen_controller.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../utils/common_methods.dart';

class MyOrderScreenPage extends StatefulWidget {
  const MyOrderScreenPage({super.key});

  @override
  State<MyOrderScreenPage> createState() => _MyOrderScreenPageState();
}

class _MyOrderScreenPageState extends State<MyOrderScreenPage> {
  final myOrderController = Get.find<MyOrderScreenController>();

  @override
  void initState() {
    myOrderController.getOrderData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 0.h,
            backgroundColor: Colors.black,
            bottom: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black,
              title: Text('my_order'.tr, style: TextStyle(fontSize: 14.sp, fontFamily: "Poppins")),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 15.sp,
                ),
                onPressed: () {
                  Get.back();
                  //Get.offNamed(Routes.BOTTOM_SCREEN);
                },
              ),
            ),
          ),
          body: myOrderController.isLoading.isTrue
              ? Center(
                  child: CircularProgressIndicator(
                    color: myOrderController.appColors.darkYellowColor,
                  ),
                )
              : myOrderController.getOrderApiData.value.data == null ||
                      myOrderController.getOrderApiData.value.data!.isEmpty
                  ? Center(
                      child: Text("No order placed yet",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                              fontFamily: "Poppins",
                              color: Colors.white)),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        await myOrderController.getOrderData();
                      },
                      child: ListView(
                        shrinkWrap: true,
                        // physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ListView.separated(
                                shrinkWrap: true,
                                reverse: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: myOrderController.getOrderApiData.value.data!.length,
                                separatorBuilder: (context, _) => const SizedBox(
                                      height: 10,
                                    ),
                                itemBuilder: (context, dataIndex) {
                                  print("Data List: ${myOrderController.getOrderApiData.value.data!.length}");
                                  return Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5.sp),
                                        color: myOrderController.appColors.textfieldBoxColor),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/images/deliveryIcon.svg",
                                                  height: 18,
                                                  width: 18,
                                                ),
                                                SizedBox(
                                                  width: 2.w,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 2, bottom: 2),
                                                  child: Obx(()=>
                                                     Text(
                                                      myOrderController.orderStatus(myOrderController
                                                              .getOrderApiData.value.data![dataIndex].orderStatus ??
                                                          0),
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontFamily: "Arial",
                                                          color: myOrderController.colorStatus(myOrderController
                                                                  .getOrderApiData.value.data![dataIndex].orderStatus ??
                                                              0)),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                              behavior: HitTestBehavior.translucent,
                                              onTap: () {
                                                CommonMethods().openUrl(Uri.parse(myOrderController
                                                        .getOrderApiData.value.data![dataIndex].invoicePdf ??
                                                    ''));
                                              },
                                              child: Text(
                                                "Invoice",
                                                style: TextStyle(
                                                    color: myOrderController.appColors.darkYellowColor,
                                                    decoration: TextDecoration.underline),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 6.5.w,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 2, bottom: 4),
                                                  child: Text(
                                                    "Order Id: ${myOrderController.getOrderApiData.value.data![dataIndex].orderId.toString()}",
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontFamily: "Arial",
                                                        color: myOrderController.appColors.greenColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 6.5.w,
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                "Tracking Id:",
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontFamily: "Arial",
                                                    color: myOrderController.appColors.whiteColor),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Text(
                                                myOrderController.getOrderApiData.value.data![dataIndex].orderStatus
                                                            .toString() ==
                                                        '4'
                                                    ? myOrderController
                                                        .getOrderApiData.value.data![dataIndex].trackingId
                                                        .toString()
                                                    : '123456789',
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Arial",
                                                    color: myOrderController.appColors.whiteColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 6.5.w,
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                "Tracking Url:",
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontFamily: "Arial",
                                                    color: myOrderController.appColors.whiteColor),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Builder(builder: (context) {
                                                String url = 'https://www.fedex.com/en-in/tracking.html';
                                                if (myOrderController.getOrderApiData.value.data![dataIndex].orderStatus
                                                        .toString() ==
                                                    '4') {
                                                  url = myOrderController
                                                      .getOrderApiData.value.data![dataIndex].trackingUrl
                                                      .toString();
                                                }
                                                return InkWell(
                                                  onTap: () {
                                                    Uri openUrl = Uri.parse(url);

                                                    CommonMethods().openUrl(openUrl);
                                                  },
                                                  child: Text(
                                                    url,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily: "Arial",
                                                        decoration: TextDecoration.underline,
                                                        color: myOrderController.appColors.whiteColor),
                                                  ),
                                                );
                                              }),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),

                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 6.5.w,
                                            ),
                                            Text(
                                              "Shipping Company: ",
                                              style: TextStyle(
                                                  fontSize: 11.sp,
                                                  fontFamily: "Arial",
                                                  color: myOrderController.appColors.whiteColor),
                                            ),
                                            Text(
                                              myOrderController.getOrderApiData.value.data![dataIndex].orderStatus
                                                          .toString() ==
                                                      '4'
                                                  ? myOrderController
                                                      .getOrderApiData.value.data![dataIndex].shippingCompanyName
                                                      .toString()
                                                  : 'NexEver',
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 11.sp,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Arial",
                                                  color: myOrderController.appColors.whiteColor),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 6.5.w,
                                            ),
                                            Text(
                                              _showDateTime(myOrderController
                                                  .getOrderApiData.value.data![dataIndex].createdAt
                                                  .toString()),
                                              style: TextStyle(
                                                  fontSize: 11.sp,
                                                  fontFamily: "Arial",
                                                  color: myOrderController.appColors.whiteColor),
                                            ),
                                          ],
                                        ),
                                        // SizedBox(
                                        //   height: 1.5.h,
                                        // ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: myOrderController
                                                .getOrderApiData.value.data![dataIndex].cartItems!.length,
                                            itemBuilder: (context, index) {
                                              print(
                                                  "Cart Item List: ${myOrderController.getOrderApiData.value.data![dataIndex].cartItems!.length}");
                                              return Stack(
                                                children: [
                                                  Container(
                                                    alignment: Alignment.bottomCenter,
                                                    padding: const EdgeInsets.only(top: 15, bottom: 5),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(bottom: 10),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          String description = '';

                                                          if (myOrderController.getOrderApiData.value.data![dataIndex]
                                                                  .cartItems![index].productVarientDescription !=
                                                              null) {
                                                            description = myOrderController
                                                                .getOrderApiData
                                                                .value
                                                                .data![dataIndex]
                                                                .cartItems![index]
                                                                .productVarientDescription
                                                                .toString();
                                                          } else if (myOrderController
                                                                  .getOrderApiData
                                                                  .value
                                                                  .data![dataIndex]
                                                                  .cartItems![index]
                                                                  .productDescription !=
                                                              null) {
                                                            description = myOrderController.getOrderApiData.value
                                                                .data![dataIndex].cartItems![index].productDescription
                                                                .toString();
                                                          }

                                                          bool isCenterStichAvailable = false;

                                                          if (myOrderController.getOrderApiData.value.data![dataIndex]
                                                                      .cartItems![index].variations !=
                                                                  null &&
                                                              myOrderController.getOrderApiData.value.data![dataIndex]
                                                                  .cartItems![index].variations!.isNotEmpty) {
                                                            for (var variation in myOrderController.getOrderApiData
                                                                .value.data![dataIndex].cartItems![index].variations!) {
                                                              if (variation.key.toString().contains('Stitch')) {
                                                                isCenterStichAvailable = true;
                                                              }
                                                            }
                                                          }

                                                          Get.to(
                                                              PlaceOrderDetailScreen(
                                                                description: description,
                                                                name: myOrderController.getOrderApiData.value
                                                                    .data![dataIndex].cartItems![index].productName
                                                                    .toString(),
                                                                size: myOrderController.getOrderApiData.value
                                                                    .data![dataIndex].cartItems![index].lengthInMeters
                                                                    .toString(),
                                                                stitch: myOrderController.getOrderApiData.value
                                                                    .data![dataIndex].cartItems![index].centerStitch
                                                                    .toString(),
                                                                price: myOrderController.getOrderApiData.value
                                                                    .data![dataIndex].cartItems![index].price
                                                                    .toString(),
                                                                image: myOrderController.getOrderApiData.value
                                                                    .data![dataIndex].cartItems![index].image,
                                                                id: myOrderController.getOrderApiData.value
                                                                    .data![dataIndex].cartItems![index].id
                                                                    .toString(),
                                                                variationId: myOrderController.getOrderApiData.value
                                                                    .data![dataIndex].cartItems![index].variationId
                                                                    .toString(),
                                                                brandName: myOrderController.getOrderApiData.value
                                                                    .data![dataIndex].cartItems![index].brandName
                                                                    .toString(),
                                                                orderStatus: myOrderController
                                                                    .getOrderApiData.value.data![dataIndex].orderStatus
                                                                    .toString(),
                                                                isCenterStichAvailable: isCenterStichAvailable,
                                                              ),
                                                              arguments: {
                                                                "orderData": jsonEncode(myOrderController
                                                                    .getOrderApiData.value.data![dataIndex]),
                                                              });
                                                        },
                                                        child: Container(
                                                          //height: 17.h,
                                                          width: double.infinity,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(5.sp),
                                                              color: myOrderController.appColors.lightblackColor),
                                                          child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                SizedBox(
                                                                  width: 2.w,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: Container(
                                                                    height: 12.5.h,
                                                                    width: 25.w,
                                                                    clipBehavior: Clip.hardEdge,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(4.sp),
                                                                      color: myOrderController.appColors.blackColor,
                                                                    ),
                                                                    child: myOrderController
                                                                                    .getOrderApiData
                                                                                    .value
                                                                                    .data![dataIndex]
                                                                                    .cartItems![index]
                                                                                    .image ==
                                                                                null ||
                                                                            myOrderController
                                                                                .getOrderApiData
                                                                                .value
                                                                                .data![dataIndex]
                                                                                .cartItems![index]
                                                                                .image!
                                                                                .isEmpty
                                                                        ? myOrderController
                                                                                    .getOrderApiData
                                                                                    .value
                                                                                    .data![dataIndex]
                                                                                    .cartItems![index]
                                                                                    .variationId ==
                                                                                null
                                                                            ? Image.asset(
                                                                                "assets/images/placeholder.jpg")
                                                                            : Image.asset(
                                                                                "assets/images/placeholder.jpg")
                                                                        : FadeInImage.assetNetwork(
                                                                            imageErrorBuilder:
                                                                                (context, error, stackTrace) {
                                                                              return Image.asset(
                                                                                "assets/images/placeholder.jpg",
                                                                                fit: BoxFit.cover,
                                                                              );
                                                                            },
                                                                            placeholder:
                                                                                "assets/images/placeholder.jpg",
                                                                            placeholderFit: BoxFit.cover,
                                                                            image: myOrderController
                                                                                .getOrderApiData
                                                                                .value
                                                                                .data![dataIndex]
                                                                                .cartItems![index]
                                                                                .image![0]
                                                                                .url
                                                                                .toString(),
                                                                            fit: BoxFit.cover,
                                                                          ),
                                                                    /* Image.network(
                                                                            myOrderController
                                                                                .getOrderApiData
                                                                                .value
                                                                                .data![dataIndex]
                                                                                .cartItems![index]
                                                                                .image![0]
                                                                                .url
                                                                                .toString(),
                                                                            fit: BoxFit.cover,
                                                                            errorBuilder: (context, child, event) {
                                                                            return myOrderController
                                                                                        .getOrderApiData
                                                                                        .value
                                                                                        .data![dataIndex]
                                                                                        .cartItems![index]
                                                                                        .variationId ==
                                                                                    null
                                                                                ? Image.asset(
                                                                                "assets/images/placeholder.jpg")
                                                                                : Image.asset(
                                                                                "assets/images/placeholder.jpg");
                                                                          }),*/
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 2.5.w,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.symmetric(vertical: 3.h),
                                                                  child: SizedBox(
                                                                    width: 45.w,
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text(
                                                                          myOrderController
                                                                              .getOrderApiData
                                                                              .value
                                                                              .data![dataIndex]
                                                                              .cartItems![index]
                                                                              .productName
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              fontSize: 11.sp,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontFamily: "Poppins",
                                                                              color: myOrderController
                                                                                  .appColors.whiteColor),
                                                                        ),
                                                                        SizedBox(
                                                                          height: 1.h,
                                                                        ),

                                                                        ///////////////////////////////////////////////
                                                                        ///
                                                                        ///
                                                                        // myOrderController
                                                                        //     .getOrderApiData
                                                                        //     .value
                                                                        //     .data![dataIndex]
                                                                        //     .cartItems![index]
                                                                        //     .variationId !=
                                                                        //     null
                                                                        //     ? Row(
                                                                        //         children: [
                                                                        //           Text(
                                                                        //             'size'.tr,
                                                                        //             style: TextStyle(
                                                                        //                 fontSize: 9.sp,
                                                                        //                 fontWeight: FontWeight.w500,
                                                                        //                 fontFamily: "Arial",
                                                                        //                 color: myOrderController
                                                                        //                     .appColors.checkColor),
                                                                        //           ),
                                                                        //           Text(
                                                                        //             "${myOrderController.getOrderApiData.value.data![dataIndex].cartItems![index].lengthInMeters.toString() ?? ""} meters",
                                                                        //             style: TextStyle(
                                                                        //                 fontSize: 9.sp,
                                                                        //                 fontWeight: FontWeight.w700,
                                                                        //                 fontFamily: "Arial",
                                                                        //                 color: myOrderController
                                                                        //                     .appColors.whiteColor),
                                                                        //           ),
                                                                        //           // Text(
                                                                        //           //   myOrderController
                                                                        //           //               .getOrderApiData
                                                                        //           //               .value
                                                                        //           //               .data![dataIndex]
                                                                        //           //               .cartItems![index]
                                                                        //           //               .size ==
                                                                        //           //           "L"
                                                                        //           //       ? ""
                                                                        //           //       : ' meters',
                                                                        //           //   style: TextStyle(
                                                                        //           //       fontSize: 9.sp,
                                                                        //           //       fontWeight: FontWeight.w700,
                                                                        //           //       fontFamily: "Arial",
                                                                        //           //       color:
                                                                        //           //           myOrderController.appColors.whiteColor),
                                                                        //           // ),
                                                                        //         ],
                                                                        //       )
                                                                        //     : const SizedBox.shrink(),
                                                                        // SizedBox(
                                                                        //   height: 0.7.h,
                                                                        // ),
                                                                        // myOrderController
                                                                        //             .getOrderApiData
                                                                        //             .value
                                                                        //             .data![dataIndex]
                                                                        //             .cartItems![index]
                                                                        //             .variationId !=
                                                                        //         null
                                                                        //     ? Row(
                                                                        //         children: [
                                                                        //           Text(
                                                                        //             'double_(center stitch)'.tr,
                                                                        //             style: TextStyle(
                                                                        //                 fontSize: 9.5.sp,
                                                                        //                 fontWeight: FontWeight.w500,
                                                                        //                 fontFamily: "Arial",
                                                                        //                 color: myOrderController
                                                                        //                     .appColors.checkColor),
                                                                        //           ),
                                                                        //           myOrderController
                                                                        //                       .getOrderApiData
                                                                        //                       .value
                                                                        //                       .data![dataIndex]
                                                                        //                       .cartItems![index]
                                                                        //                       .centerStitch ==
                                                                        //                   1
                                                                        //               ? Text(
                                                                        //                   'Yes',
                                                                        //                   style: TextStyle(
                                                                        //                       fontSize: 9.5.sp,
                                                                        //                       fontWeight: FontWeight.w700,
                                                                        //                       fontFamily: "Arial",
                                                                        //                       color: myOrderController
                                                                        //                           .appColors.whiteColor),
                                                                        //                 )
                                                                        //               : Text(
                                                                        //                   'No',
                                                                        //                   style: TextStyle(
                                                                        //                       fontSize: 9.5.sp,
                                                                        //                       fontWeight: FontWeight.w700,
                                                                        //                       fontFamily: "Arial",
                                                                        //                       color: myOrderController
                                                                        //                           .appColors.whiteColor),
                                                                        //                 ),
                                                                        //         ],
                                                                        //       )
                                                                        //     :const SizedBox.shrink(),

                                                                        if (myOrderController
                                                                                .getOrderApiData
                                                                                .value
                                                                                .data![dataIndex]
                                                                                .cartItems![index]
                                                                                .variations !=
                                                                            null)
                                                                          ListView.separated(
                                                                            physics:
                                                                                const NeverScrollableScrollPhysics(),
                                                                            shrinkWrap: true,
                                                                            itemCount: myOrderController
                                                                                .getOrderApiData
                                                                                .value
                                                                                .data![dataIndex]
                                                                                .cartItems![index]
                                                                                .variations!
                                                                                .length,
                                                                            itemBuilder: (ctx, newIndex) {
                                                                              return Row(
                                                                                children: [
                                                                                  Text(
                                                                                    "${myOrderController.getOrderApiData.value.data![dataIndex].cartItems![index].variations![newIndex].key.toString()}: ",
                                                                                    style: TextStyle(
                                                                                        fontSize: 9.5.sp,
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontFamily: "Arial",
                                                                                        color: myOrderController
                                                                                            .appColors.checkColor),
                                                                                  ),
                                                                                  Text(
                                                                                    myOrderController
                                                                                        .getOrderApiData
                                                                                        .value
                                                                                        .data![dataIndex]
                                                                                        .cartItems![index]
                                                                                        .variations![newIndex]
                                                                                        .data
                                                                                        .toString(),
                                                                                    style: TextStyle(
                                                                                        fontSize: 9.5.sp,
                                                                                        fontWeight: FontWeight.w700,
                                                                                        fontFamily: "Arial",
                                                                                        color: myOrderController
                                                                                            .appColors.whiteColor),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                            separatorBuilder: (ctx, index) =>
                                                                                const SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                          ),

                                                                        ///////////////////////////////////////////////

                                                                        SizedBox(
                                                                          height: 0.7.h,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              'price'.tr,
                                                                              style: TextStyle(
                                                                                  fontSize: 9.sp,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontFamily: "Arial",
                                                                                  color: myOrderController
                                                                                      .appColors.checkColor),
                                                                            ),
                                                                            Text(
                                                                              "₹ ${myOrderController.getOrderApiData.value.data![dataIndex].cartItems![index].totalPrice}",
                                                                              style: TextStyle(
                                                                                  fontSize: 9.sp,
                                                                                  fontWeight: FontWeight.w700,
                                                                                  fontFamily: "Arial",
                                                                                  color: myOrderController
                                                                                      .appColors.whiteColor),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                    bottom: 3.h,
                                                                  ),
                                                                  child: Align(
                                                                      alignment: Alignment.bottomRight,
                                                                      child: Image.asset(
                                                                          "assets/images/forwordIcon.png",
                                                                          width: 2.w)),
                                                                ),
                                                                SizedBox(
                                                                  width: 2.5.w,
                                                                )
                                                              ]),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // Positioned(
                                                  //   top: -2,
                                                  //   left: 5,
                                                  //   child: Text(
                                                  //     myOrderController.getOrderApiData.value.data![dataIndex]
                                                  //             .cartItems![index].createdAt ??
                                                  //         "",
                                                  //     style: TextStyle(color: Colors.white),
                                                  //   ),
                                                  // )
                                                ],
                                              );
                                            }),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }

  String _showDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDateTime = DateFormat('dd-MM-yyyy   h:mm a', 'en_US').format(dateTime);
    return formattedDateTime;
  }
}
