import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../utils/common_methods.dart';
import 'my_order_screen_controller.dart';

class PlaceOrderDetailScreen extends StatefulWidget {
  PlaceOrderDetailScreen(
      {super.key,
      this.name,
      this.size,
      this.price,
      this.stitch,
      this.image,
      this.id,
      this.variationId,
      this.brandName,
      this.orderStatus,
      this.description,
      required this.isCenterStichAvailable});

  String? name;
  String? size;
  String? price;
  String? stitch;
  List? image;
  String? id;
  String? variationId;
  String? brandName;
  String? orderStatus;
  String? description;
  bool isCenterStichAvailable;

  @override
  State<PlaceOrderDetailScreen> createState() => _PlaceOrderDetailScreenState();
}

class _PlaceOrderDetailScreenState extends State<PlaceOrderDetailScreen> {
  final myOrderController = Get.put(MyOrderScreenController());

  CarouselController controller = CarouselController();
  int currentIndex = 0;

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }

  var orderData;

  @override
  void initState() {
    orderData = jsonDecode(Get.arguments['orderData']);
    log("OrderData:${orderData}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              size: 15.sp,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(widget.name.toString(),
              style: TextStyle(fontSize: 14.sp, fontFamily: "Poppins")),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: ListView(
          children: [
            CarouselSlider(
                carouselController: controller,
                items: widget.image!
                    .map(
                      (item) => Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            height: 30.h,
                            width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.sp)),
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
                              fit: BoxFit.fill,
                            ),

                            /*Image.network(
                              item.url.toString(),
                              fit: BoxFit.cover,
                            ),*/
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
                        currentIndex = index;
                        //controller.jumpToPage(val);
                      });
                    })),
            const SizedBox(
              height: 5,
            ),

            /*Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.image!.map((image) {
                  int index = widget.image!.indexOf(image);
                  return Container(
                    width: 10.0,
                    height: 10.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 3.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentIndex == index
                          ? myOrderController.appColors.darkYellowColor
                          : Colors.grey,
                    ),
                  );
                }).toList(),
              ),*/

            SizedBox(
              height: 3.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Container(
                color: myOrderController.appColors.blackColor,
                width: 90.w,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.description != null)
                        if (widget.description!.isNotEmpty)
                          Text(
                            "Description",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Poppins",
                                color: myOrderController.appColors.whiteColor),
                          ),
                      Html(
                        data: widget.description ?? '',
                        shrinkWrap: true,
                        style: {
                          "body": Style(
                              textAlign: TextAlign.start,
                              color: myOrderController.appColors.whiteColor,
                              fontFamily: "Arial",
                              fontSize: FontSize.large),
                          "p": Style(
                              color: myOrderController.appColors.whiteColor,
                              fontFamily: "Arial",
                              textAlign: TextAlign.start,
                              fontSize: FontSize.large),
                          "h1": Style(
                              textAlign: TextAlign.start,
                              color: myOrderController.appColors.whiteColor,
                              fontFamily: "Arial",
                              fontSize: FontSize.large),
                          "li": Style(
                              textAlign: TextAlign.start,
                              color: myOrderController.appColors.whiteColor,
                              fontFamily: "Arial",
                              fontSize: FontSize.large),
                          "ul": Style(
                              textAlign: TextAlign.start,
                              color: myOrderController.appColors.whiteColor,
                              fontFamily: "Arial",
                              fontSize: FontSize.large),
                        },
                      ),
                      if (widget.description != null)
                        if (widget.description!.isNotEmpty)
                          SizedBox(
                            height: 3.h,
                          ),
                      widget.variationId != "null"
                          ? Padding(
                              padding: const EdgeInsets.only(top: 3, bottom: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Size",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Poppins",
                                        color: myOrderController
                                            .appColors.whiteColor),
                                  ),
                                  Text(
                                    "${widget.size.toString()} meters",
                                    //"${widget.size.toString()}  ${widget.size.toString() == "L" ? "" : "meters"}",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins",
                                        color: myOrderController
                                            .appColors.whiteColor),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                      widget.variationId != "null"
                          ? const Divider(
                              color: Colors.white,
                            )
                          : const SizedBox.shrink(),

                      widget.variationId != "null"
                          ? Padding(
                              padding: const EdgeInsets.only(top: 3, bottom: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Brand Name",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Poppins",
                                          color: myOrderController
                                              .appColors.whiteColor),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      widget.brandName.toString(),
                                      maxLines: 2,
                                      textAlign: TextAlign.end,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins",
                                          color: myOrderController
                                              .appColors.whiteColor),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                      widget.variationId != "null"
                          ? const Divider(
                              color: Colors.white,
                            )
                          : const SizedBox.shrink(),

                      widget.isCenterStichAvailable
                          ? Padding(
                              padding: const EdgeInsets.only(top: 3, bottom: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Center Stitch",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Poppins",
                                        color: myOrderController
                                            .appColors.whiteColor),
                                  ),
                                  widget.stitch.toString() == "1"
                                      ? Text(
                                          "Yes",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Poppins",
                                              color: myOrderController
                                                  .appColors.whiteColor),
                                        )
                                      : Text(
                                          "No",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Poppins",
                                              color: myOrderController
                                                  .appColors.whiteColor),
                                        ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                      widget.isCenterStichAvailable
                          ? const Divider(
                              color: Colors.white,
                            )
                          : const SizedBox.shrink(),
                      // widget.isCenterStichAvailable
                      //     ? SizedBox(
                      //         height: 2.h,
                      //       )
                      //     : const SizedBox(),
                      Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Price",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Poppins",
                                  color:
                                      myOrderController.appColors.whiteColor),
                            ),
                            Text(
                              "₹ ${widget.price.toString()}",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                  color:
                                      myOrderController.appColors.whiteColor),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Order Id",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Poppins",
                                  color:
                                      myOrderController.appColors.whiteColor),
                            ),
                            Text(
                              widget.id.toString(),
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                  color:
                                      myOrderController.appColors.whiteColor),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tracking Id",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Poppins",
                                  color:
                                      myOrderController.appColors.whiteColor),
                            ),
                            Text(
                              widget.orderStatus == '4'
                                  ? orderData['tracking_id'].toString()
                                  : '123456789',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                  color:
                                      myOrderController.appColors.whiteColor),
                            ),
                          ],
                        ),
                      ),

                      const Divider(
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 3),
                        child: Builder(builder: (context) {
                          String url =
                              'https://www.fedex.com/en-in/tracking.html';
                          if (widget.orderStatus == '4') {
                            url = orderData['tracking_url'].toString();
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Tracking Url",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Poppins",
                                      color: myOrderController
                                          .appColors.whiteColor),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () async {
                                    Uri openUrl = Uri.parse(url);
                                    CommonMethods().openUrl(openUrl);
                                  },
                                  child: Text(
                                    textAlign: TextAlign.right,
                                    url,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins",
                                        color: myOrderController
                                            .appColors.whiteColor),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      const Divider(
                        color: Colors.white,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Company Name",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Poppins",
                                  color:
                                      myOrderController.appColors.whiteColor),
                            ),
                            Text(
                              widget.orderStatus == '4'
                                  ? orderData['shipping_company_name']
                                      .toString()
                                  : 'Nexever',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                  color:
                                      myOrderController.appColors.whiteColor),
                            ),
                          ],
                        ),
                      ),

                      const Divider(
                        color: Colors.white,
                      ),
                      // if (widget.orderStatus == '4')
                      //   const Divider(
                      //     color: Colors.white,
                      //   ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    Get.dialog(StatefulBuilder(
      builder: (context, StateSetter setState) {
        return Column(
          children: [
            Stack(
              children: [
                InteractiveViewer(
                    child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 1.1,
                  color: Colors.black54,
                  child: Image.network(
                    widget.image!.first.url.toString(),
                  ),
                )),
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
        );
      },
    ));
  }
}

// GestureDetector(
//     onTap: () {
//       showAlertDialog(context);
//     },
//     child: SizedBox(
//       height: 30.h,
//       width: 90.w,
//       child: ListView.builder(
//           shrinkWrap: true,
//           scrollDirection: Axis.horizontal,
//           itemCount: widget.image.length,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.only(right: 5, left: 5),
//               child: Container(
//                 clipBehavior: Clip.hardEdge,
//                 height: 30.h,
//                 width: 88.w,
//                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.sp), color: Colors.white),
//                 child: Image.network(
//                   widget.image[index].url.toString(),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             );
//           }),
//     )
