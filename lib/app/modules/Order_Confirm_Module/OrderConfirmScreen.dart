import 'package:akalsahae/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../apiCollection/api_client.dart';
import '../my_order_screen_module/my_order_screen_controller.dart';
import 'OrderConfirmScreenController.dart';

class OrderConfirmScreenPage extends GetView<OrderConfirmScreenController> {
  OrderConfirmScreenController orderScreenController = Get.put(OrderConfirmScreenController());


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: orderScreenController,
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: orderScreenController.appColors.blackColor,
              automaticallyImplyLeading: false,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 3.h),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 50.h,
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.h),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.sp),
                      color: orderScreenController.appColors.whiteColor.withOpacity(0.5)),
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    children: [
                      Center(
                          child: Text(
                        'Your order placed successfully',
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: orderScreenController.appColors.whiteColor,
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.w600),
                      )),
                      SizedBox(height: 3.h),
                      Image(
                        image: const AssetImage('assets/images/ok.png'),
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Center(
                          child: Text(
                        'Thank you for your purchase',
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: orderScreenController.appColors.whiteColor,
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.w500),
                      )),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Your Order Id is: ',
                            style: TextStyle(
                                fontSize: 10.sp,
                                color: orderScreenController.appColors.whiteColor,
                                fontFamily: 'Arial',
                                fontWeight: FontWeight.w500),
                          ),
                          Obx(
                            () => Text(
                              orderScreenController.getOrderApiData.value.data?.first.orderId ?? "",
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: orderScreenController.appColors.whiteColor,
                                  fontFamily: 'Arial',
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.offAllNamed(Routes.BOTTOM_SCREEN);
                        },
                        child: Container(
                          height: 6.h,
                          width: 43.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.sp),
                              color: orderScreenController.appColors.darkYellowColor),
                          child: Padding(
                            padding: EdgeInsets.only(top: 0.3.h),
                            child: Center(
                              child: Text(
                                'CONTINUE SHOPPING',
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: orderScreenController.appColors.whiteColor,
                                    fontFamily: "Arial"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
