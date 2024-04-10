import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:akalsahae/app/modules/try_now_screen_module/try_now_screen_controller.dart';
import 'package:sizer/sizer.dart';


class TryNowScreenPage extends GetView<TryNowScreenController> {
  final tryNowScreenController= Get.find<TryNowScreenController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:tryNowScreenController ,
      builder: (context) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                  decoration: BoxDecoration(image: DecorationImage(image:AssetImage('assets/images/tryImage.png'),fit: BoxFit.fill )),
              ),
              Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.center, end: Alignment.bottomCenter,
                        colors: [Color(0x00000000), Color(0xff212121).withOpacity(1.0)], ))
              ),
              Positioned(
                  top: 5.6.h,
                  right:7.w,
                  child: GestureDetector(
                      onTap: () {
                        Get.back();
                        //Get.offNamed(Routes.FULLVOILE_TURBAN_SCREEN);
                      },
                      child: SvgPicture.asset('assets/images/cancelIcon.svg')),width:9.w),
              Positioned(
                bottom: 2.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 6.5.h,
                        width: 45.w,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.sp),color:tryNowScreenController.appColors.blackColor.withOpacity(0.10),border: Border.all(color:tryNowScreenController.appColors.borderColor,width:1,)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/images/FavIcon.svg"),
                            SizedBox(width: 1.w,),
                            Text('favorite'.tr,style:TextStyle(fontSize: 11.sp,color:tryNowScreenController.appColors.whiteColor,fontFamily: "Arial",),),

                          ],
                        ),
                      ),
                      SizedBox(
                        width: 2.5.w,
                      ),
                      Container(
                        height: 6.5.h,
                        width: 45.w,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.sp),color: tryNowScreenController.appColors.lightgreenColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/CartIcon.png',width:5.8.w),
                            SizedBox(width: 1.w,),
                            Padding(
                              padding: EdgeInsets.only(top: 0.7.h),
                              child: Text('add_to_cart'.tr,style:TextStyle(fontSize: 11.sp,color: tryNowScreenController.appColors.whiteColor,fontFamily: "Arial"),),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
