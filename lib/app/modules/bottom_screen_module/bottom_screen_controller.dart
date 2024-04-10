import 'dart:io';

import 'package:akalsahae/app/modules/bottom_screen_module/server_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import '../../../ar_view/face_detection_screen.dart';
import '../../../helper_widget/colors.dart';
import '../../apiCollection/api_client.dart';
import '../home_screen_module/drag_image.dart';

class BottomScreenController extends GetxController with GetSingleTickerProviderStateMixin {
  AppColors appColors = AppColors();
  RxInt index = 0.obs;
  TabController? tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);

    serverMaintenanceAPI();
  }

  void serverMaintenanceAPI() async {
    try {
      final serverMaintenanceResponse = await ApiClient.serverMaintData();
      if (serverMaintenanceResponse != null) {
        if (serverMaintenanceResponse.status.toString() == '1') {
          print("showMaintenanceDialog----->>>${serverMaintenanceResponse!.status.toString()}");
          Get.to(ServerMaintenanceScreenPage(
            title: serverMaintenanceResponse!.title.toString(),
            message: serverMaintenanceResponse!.message.toString(),
          ));
        }
      }
    } catch (e) {
      print("Error $e");
    }
    update();
  }

  @override
  void onClose() {
    //tabController?.dispose();
    super.onClose();
  }

  void selectedTab(int? intex) {
    index.value = intex!;
    update();
  }

  Color getTabIconColor(int tabIndex) {
    return index.value == tabIndex ? appColors.darkYellowColor : appColors.bottomIconColor;
  }
  File? imageFile;
  /// Get from Camera
  getImageFromCamera() async {
    XFile? pickedFile;

    await Permission.camera.request();
    if (!await Permission.camera.isGranted) {
      openAppSettings();
    } else {
      pickedFile = await pickImage(fromCamera: true);
    }
    /* if (Platform.isIOS) {
      await Permission.camera.request();
      if (!await Permission.camera.isGranted) {
        openAppSettings();
      }
    } else {
      if (!await Permission.camera.isGranted) {
        openAppSettings();
      } else {
        pickedFile = await pickImage(fromCamera: true);
      }
    }*/


    /*  if (await Permission.photos.isPermanentlyDenied) {
      openAppSettings();
      return;
    } else if (await Permission.photos.isDenied) {
      var result = await Permission.photos.request();
      if (result.isGranted) {
        pickedFile = await pickImage(fromCamera: true);
      } else {
        openAppSettings();
      }
    } else {
      pickedFile = await pickImage(fromCamera: true);
    }*/
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      Get.to(() => DragImage(image: imageFile!.path));
    }
  }

  Future<XFile?> pickImage({bool fromCamera = true}) async {
    return await ImagePicker().pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
  }

  onWillPop() async {
    Get.dialog(
      AlertDialog(
        backgroundColor: appColors.lightBlackColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.sp),
        ),
        content: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.sp),
              color:appColors.lightBlackColor
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'Try Now ',
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
                'With',
                style: TextStyle(
                  fontSize: 12.sp,
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
                      getImageFromCamera();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0, top: 10, right: 0),
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 100,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: appColors.darkYellowColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: appColors.darkYellowColor, width: 1),
                        ),
                        child: Text(
                          "Photo",
                          style: TextStyle(
                            letterSpacing: 1.5,
                            color: appColors.whiteColor,
                            fontFamily: "Poppins",
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Get.back();
                      Get.to(FaceMeshDetectorView());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0, top: 10, right: 0),
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 100,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: appColors.darkYellowColor,
                        ),
                        child: Text(
                          "Live AR",
                          style: TextStyle(
                            letterSpacing: 1.5,
                            color: appColors.whiteColor,
                            fontFamily: "Poppins",
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

  }

}
