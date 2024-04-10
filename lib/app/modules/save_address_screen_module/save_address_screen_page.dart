// ignore_for_file: unnecessary_null_comparison

import 'package:akalsahae/app/modules/check_out_screen_module/check_out_screen_controller.dart';
import 'package:akalsahae/main.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:akalsahae/app/modules/save_address_screen_module/save_address_screen_controller.dart';
import 'package:sizer/sizer.dart';
import '../../routes/app_pages.dart';

class SaveAddressScreenPage extends StatefulWidget {
  const SaveAddressScreenPage({super.key});

  @override
  State<SaveAddressScreenPage> createState() => _SaveAddressScreenPageState();
}

class _SaveAddressScreenPageState extends State<SaveAddressScreenPage> {
  SaveAddressScreenController controller = Get.find<SaveAddressScreenController>();
  CheckOutScreenController checkOutScreenController = Get.find<CheckOutScreenController>();

  @override
  void initState() {
    controller.isEditing.value = false;
    if (Get.arguments != null && Get.arguments["fromCheckScreen"] == true) {
      controller.fromCheckOutScreen.value = true;
    } else {
      controller.fromCheckOutScreen.value = false;
    }
    controller.selectedIndex.value = "-1";
    controller.getAddressData();
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
            backgroundColor: Colors.black,
            toolbarHeight: 0.h,
            bottom: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black,
              title: controller.fromCheckOutScreen.value == true
                  ? Text('select_delivery_address'.tr, style: TextStyle(fontSize: 12.sp, fontFamily: "Poppins"))
                  : Text('Saved Address'.tr, style: TextStyle(fontSize: 14.sp, fontFamily: "Poppins")),
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
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await controller.getAddressData();
            },
            child: controller.isLoading.value == true
                ? Center(
                    child: CircularProgressIndicator(
                      color: controller.appColors.darkYellowColor,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Column(
                      children: [
                        Expanded(
                            child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Visibility(
                                visible: controller.defaultAddress.value.address != null,
                                child: Text(
                                  "default_address".tr,
                                  style: TextStyle(fontSize: 12.sp, color: controller.appColors.whiteColor),
                                ),
                              ),
                              Visibility(
                                visible: controller.defaultAddress.value.address != null,
                                child: SizedBox(
                                  height: 1.5.h,
                                ),
                              ),
                              Visibility(
                                visible: controller.defaultAddress.value.address != null,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 3.w,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3.sp), color: controller.appColors.boxColor),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 0, bottom: 15),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            behavior: HitTestBehavior.translucent,
                                            onTap: () {
                                              controller.selectDefaultAddress(-1);
                                            },
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(top: 1.5.h),
                                                child: Container(
                                                  margin: EdgeInsets.all(2.sp),
                                                  padding: EdgeInsets.all(2.sp),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle, color: controller.appColors.whiteColor),
                                                  child: Icon(
                                                    Icons.circle,
                                                    size: 10.5.sp,
                                                    color: controller.appColors.darkYellowColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          SizedBox(
                                            //height: 22.h,
                                            width: 70.w,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 1.5.h,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      controller.defaultAddress.value != null
                                                          ? "${controller.defaultAddress.value.name}"
                                                          : " ",
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          color: controller.appColors.whiteColor,
                                                          fontFamily: "Arial"),
                                                    ),
                                                    SizedBox(
                                                      width: 2.w,
                                                    ),
                                                    Container(
                                                      height: 3.h,
                                                      width: 15.w,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          color: Colors.transparent,
                                                          border: Border.all(
                                                            color: controller.appColors.borderColor,
                                                            width: 1,
                                                          )),
                                                      child: Center(
                                                          child: Text(
                                                        (controller.defaultAddress.value.name ?? "").isNotEmpty
                                                            ? "${controller.defaultAddress.value.addressType}"
                                                            : " ",
                                                        style: TextStyle(
                                                            fontSize: 11.sp,
                                                            color: controller.appColors.whiteColor,
                                                            fontFamily: "Arial"),
                                                      )),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        "${controller.defaultAddress.value.address}, "
                                                        "${controller.defaultAddress.value.state}, "
                                                        "${controller.defaultAddress.value.city}, "
                                                        "${controller.defaultAddress.value.pincode}",
                                                        maxLines: 3,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 11.sp,
                                                            color: controller.appColors.whiteColor,
                                                            fontFamily: "Arial"),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Mobile: ",
                                                      style: TextStyle(
                                                          fontSize: 11.sp,
                                                          color: controller.appColors.whiteColor,
                                                          fontFamily: "Arial"),
                                                    ),
                                                    Text(
                                                      controller.defaultAddress.value != null
                                                          ? "${controller.defaultAddress.value.mobile}"
                                                          : " ",
                                                      style: TextStyle(
                                                          fontSize: 11.sp,
                                                          color: controller.appColors.whiteColor,
                                                          fontFamily: "Arial"),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 1.5.h,
                                                ),
                                                Visibility(
                                                  visible: true,
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          controller
                                                              .updateAddressValue(controller.defaultAddress.toJson());
                                                        },
                                                        child: Container(
                                                          height: 4.5.h,
                                                          width: 16.w,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(5.sp),
                                                              color: Colors.transparent,
                                                              border: Border.all(
                                                                color: controller.appColors.borderColor,
                                                                width: 1,
                                                              )),
                                                          child: Center(
                                                              child: Text(
                                                            "edit".tr,
                                                            style: TextStyle(
                                                                fontSize: 11.sp,
                                                                color: controller.appColors.whiteColor,
                                                                fontFamily: "Arial"),
                                                          )),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 2.w,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () async {
                                                          await controller.showAlertDialog(context).then((value) {
                                                            if (value == true) {
                                                              checkOutScreenController.saveAddressScreenController
                                                                      .defaultAddress.value.address ==
                                                                  null;
                                                              checkOutScreenController.saveAddressScreenController
                                                                      .defaultAddress.value.name ==
                                                                  null;
                                                              checkOutScreenController.saveAddressScreenController
                                                                      .defaultAddress.value.id ==
                                                                  null;
                                                              print(
                                                                  "Address: ${checkOutScreenController.saveAddressScreenController.defaultAddress.value.address == null}");
                                                              print(
                                                                  "Name: ${checkOutScreenController.saveAddressScreenController.defaultAddress.value.name == null}");
                                                              controller.removeAddress(-1);
                                                            }
                                                          });
                                                        },
                                                        child: Container(
                                                          height: 4.5.h,
                                                          width: 20.w,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(5.sp),
                                                              color: Colors.transparent,
                                                              border: Border.all(
                                                                color: controller.appColors.borderColor,
                                                                width: 0.5.w,
                                                              )),
                                                          child: Center(
                                                              child: Text(
                                                            "remove".tr,
                                                            style: TextStyle(
                                                                fontSize: 11.sp,
                                                                color: controller.appColors.whiteColor,
                                                                fontFamily: "Arial"),
                                                          )),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 3.5.h,
                              ),
                              Visibility(
                                visible: controller.getAddressApiModal.value.data != null &&
                                        controller.getAddressApiModal.value.data!.isNotEmpty
                                    ? true
                                    : false,
                                child: Text(
                                  "other_address".tr,
                                  style: TextStyle(fontSize: 12.sp, color: controller.appColors.whiteColor),
                                ),
                              ),
                              Visibility(
                                visible: controller.getAddressApiModal.value.data != null &&
                                        controller.getAddressApiModal.value.data!.isNotEmpty
                                    ? true
                                    : false,
                                child: SizedBox(
                                  height: 1.5.h,
                                ),
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: (controller.getAddressApiModal.value.data ?? []).length,
                                  itemBuilder: (BuildContext context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          controller.selectDefaultAddress(index);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 10),
                                          // padding: EdgeInsets.symmetric(
                                          //   horizontal: 3.w,vertical: 0.h
                                          // ),
                                          // height: 20.h,
                                          width: 50.w,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5.sp),
                                              color: controller.appColors.boxColor),
                                          child: Obx(() => Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Align(
                                                      alignment: Alignment.topLeft,
                                                      child: Padding(
                                                        padding: EdgeInsets.only(top: 1.0.h),
                                                        child: Container(
                                                          margin: EdgeInsets.all(2.sp),
                                                          padding: EdgeInsets.all(2.sp),
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: controller.appColors.whiteColor),
                                                          child: Icon(
                                                            Icons.circle,
                                                            size: 10.5.sp,
                                                            color: controller.appColors.whiteColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 3.w,
                                                    ),
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          // height: 15.h,
                                                          width: 70.w,
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                height: 1.2.h,
                                                              ),
                                                              Row(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  // Text(
                                                                  //   "Name: ",
                                                                  //   style: TextStyle(
                                                                  //       fontSize: 12.sp,
                                                                  //       color: controller.appColors.whiteColor,
                                                                  //       fontFamily: "Arial"),
                                                                  // ),
                                                                  Text(
                                                                    controller.getAddressApiModal.value.data![index].name
                                                                            .toString() ??
                                                                        "",
                                                                    //Address.user[index]['name'].toString(),
                                                                    maxLines: 2,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: TextStyle(
                                                                        fontSize: 12.sp,
                                                                        color: controller.appColors.whiteColor,
                                                                        fontFamily: "Arial"),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 2.w,
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: () {},
                                                                    child: Container(
                                                                      height: 3.h,
                                                                      width: 15.w,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(5),
                                                                          color: Colors.transparent,
                                                                          border: Border.all(
                                                                            color: controller.appColors.borderColor,
                                                                            width: 1,
                                                                          )),
                                                                      child: Center(
                                                                          child: Text(
                                                                        " ${controller.getAddressApiModal.value.data![index].addressType}",
                                                                        style: TextStyle(
                                                                            fontSize: 11.sp,
                                                                            color: controller.appColors.whiteColor,
                                                                            fontFamily: "Arial"),
                                                                      )),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 0.5.h,
                                                              ),
                                                              Row(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  // Text(
                                                                  //   "Address: ",
                                                                  //   style: TextStyle(
                                                                  //       fontSize: 12.sp,
                                                                  //       color: controller
                                                                  //           .appColors
                                                                  //           .whiteColor,
                                                                  //       fontFamily: "Arial"),
                                                                  // ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      "${controller.getAddressApiModal.value.data![index].address}, "
                                                                      "${controller.getAddressApiModal.value.data![index].state}, "
                                                                      "${controller.getAddressApiModal.value.data![index].city}, "
                                                                      "${controller.getAddressApiModal.value.data![index].pincode}",
                                                                      maxLines: 3,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      //Address.user[index]['address'].toString(),
                                                                      style: TextStyle(
                                                                          fontSize: 11.sp,
                                                                          color: controller.appColors.whiteColor,
                                                                          fontFamily: "Arial"),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 1.h,
                                                              ),
                                                              Align(
                                                                  alignment: Alignment.topLeft,
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "Mobile: ",
                                                                        style: TextStyle(
                                                                            fontSize: 11.sp,
                                                                            color: controller.appColors.whiteColor,
                                                                            fontFamily: "Arial"),
                                                                      ),
                                                                      Text(
                                                                        controller
                                                                            .getAddressApiModal.value.data![index].mobile
                                                                            .toString(),
                                                                        //Address.user[index]['mobile'].toString(),
                                                                        style: TextStyle(
                                                                            fontSize: 11.sp,
                                                                            color: controller.appColors.whiteColor,
                                                                            fontFamily: "Arial"),
                                                                      ),
                                                                    ],
                                                                  )),
                                                              SizedBox(
                                                                height: 1.5.h,
                                                              ),
                                                              // if (controller
                                                              //         .selectedIndex
                                                              //         .value ==
                                                              //     index
                                                              //         .toString())
                                                              Row(
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      controller.updateAddressValue(controller
                                                                          .getAddressApiModal.value.data![index]
                                                                          .toJson());
                                                                    },
                                                                    child: Container(
                                                                      height: 4.5.h,
                                                                      width: 16.w,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(5.sp),
                                                                          color: Colors.transparent,
                                                                          border: Border.all(
                                                                            color: controller.appColors.borderColor,
                                                                            width: 1,
                                                                          )),
                                                                      child: Center(
                                                                          child: Text(
                                                                        "edit".tr,
                                                                        style: TextStyle(
                                                                            fontSize: 11.sp,
                                                                            color: controller.appColors.whiteColor,
                                                                            fontFamily: "Arial"),
                                                                      )),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 2.w,
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: () async {
                                                                      await controller
                                                                          .showAlertDialog(context)
                                                                          .then((value) {
                                                                        if (value == true) {
                                                                          controller.removeAddress(index);
                                                                        }
                                                                      });
                                                                    },
                                                                    child: Container(
                                                                      height: 4.5.h,
                                                                      width: 20.w,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(5.sp),
                                                                          color: Colors.transparent,
                                                                          border: Border.all(
                                                                            color: controller.appColors.borderColor,
                                                                            width: 0.5.w,
                                                                          )),
                                                                      child: Center(
                                                                          child: Text(
                                                                        "remove".tr,
                                                                        style: TextStyle(
                                                                            fontSize: 11.sp,
                                                                            color: controller.appColors.whiteColor,
                                                                            fontFamily: "Arial"),
                                                                      )),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ])),
                                        ),
                                      ),
                                    );
                                  }),
                              if (controller.defaultAddress.value.address == null &&
                                  controller.getAddressApiModal.value.data != null &&
                                  controller.getAddressApiModal.value.data!.isEmpty)
                                SizedBox(
                                  height: Get.height * .7,
                                  child: Center(
                                    child: Text("No Address added yet...",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15.sp,
                                            fontFamily: "Poppins",
                                            color: Colors.white)),
                                  ),
                                ),
                              SizedBox(
                                height: 5.h,
                              ),
                            ],
                          ),
                        )),
                        GestureDetector(
                          onTap: () async {
                            if (controller.getAddressApiModal.value.data != null) {
                              if (controller.getAddressApiModal.value.data!.isNotEmpty) {
                                isOnlyOneAddress = true;
                              } else {
                                isOnlyOneAddress = false;
                              }
                            } else {
                              isOnlyOneAddress = false;
                            }

                            if (controller.defaultAddress.value.address != null) {
                              isOnlyOneAddress = true;
                            }
                            Get.toNamed(Routes.ADD_ADDRESS_SCREEN, parameters: {
                              'isEnabled': 'true',
                            })!
                                .then((value) {
                              setState(() {
                                controller.getAddressData();
                              });
                            });
                            // }
                          },
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            color: controller.appColors.borderColor,
                            radius: Radius.circular(5.sp),
                            child: Container(
                              height: 6.5.h,
                              decoration:
                                  BoxDecoration(borderRadius: BorderRadius.circular(5.sp), color: Colors.transparent),
                              child: Center(
                                child: Text(
                                  'add_new_address'.tr,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: controller.appColors.whiteColor,
                                      fontFamily: "Arial"),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        controller.fromCheckOutScreen.value == true
                            ? GestureDetector(
                                onTap: () {
                                  controller.setAddressValue();
                                  Get.back();
                                  //Get.toNamed(Routes.CHECK_OUT_SCREEN);
                                },
                                child: Container(
                                  height: 6.5.h,
                                  //width: 90.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3.sp),
                                      color: controller.appColors.lightgreenColor),
                                  child: Center(
                                    child: Text(
                                      'add_address'.tr,
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w700,
                                          color: controller.appColors.whiteColor,
                                          fontFamily: "Arial"),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        // controller.isCheck.value == true
                        //     ?
                        SizedBox(
                          height: 3.h,
                        )
                        // : const SizedBox.shrink(),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
