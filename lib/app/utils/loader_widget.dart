import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LoaderWidget {
  static hide() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  static show(BuildContext context) {
    return Get.dialog(
      loaderWidget(context),
      barrierDismissible: false,
    );
  }

  static Widget loaderWidget(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Material(
        color: Colors.black12,
        child: Center(
          child: Wrap(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.symmetric(vertical: Get.width * 0.03, horizontal: Get.width * 0.05),
                width: Get.width * 0.8,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(Get.width * 0.04),
                      child: const CircularProgressIndicator(),
                    ),
                    Text("please_wait".tr,
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, fontFamily: "Poppins")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
