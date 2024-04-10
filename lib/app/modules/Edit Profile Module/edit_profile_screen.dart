import 'dart:io';
import 'package:akalsahae/app/apiCollection/api_client.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import '../../routes/app_pages.dart';
import 'editEmailScreen.dart';
import 'editPhoneScreen.dart';
import 'edit_profile_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  EditProfileController editProfileController =
      Get.put(EditProfileController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.arguments != null) {
        editProfileController.emailController.value.text =
            Get.arguments["email"] ?? "";
        editProfileController.phoneController.value.text =
            Get.arguments["phone"] ?? "";
        editProfileController.nameController.value.text =
            Get.arguments["name"] ?? "";
        editProfileController.fileName.value =
            Get.arguments["profile_image"] ?? "";
        editProfileController.countryCode.value = Get.arguments["code"] ?? "";
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        toolbarHeight: 0.h,
        bottom: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Text('Edit Profile'.tr,
              style: TextStyle(
                  color: editProfileController.appColors.whiteColor,
                  fontSize: 14.sp,
                  fontFamily: "Poppins")),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              size: 15.sp,
            ),
            onPressed: () {
              editProfileController.resetData();
              Get.back();
            },
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          editProfileController.resetData();
          return true;
        },
        child: Obx(() => Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.5.w, vertical: 1.5.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 57,
                            backgroundColor:
                                editProfileController.appColors.lightgrayColor,
                            child: Container(
                                alignment: Alignment.center,
                                height: 110,
                                width: 110,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(70),
                                    color: editProfileController
                                        .appColors.textfieldBoxColor),
                                child: editProfileController
                                        .selectedFile.value.isNotEmpty
                                    ? Image.file(
                                        File(editProfileController
                                            .selectedFile.value
                                            .toString()),
                                        fit: BoxFit.cover,
                                        height: 110,
                                        width: 110,
                                        errorBuilder: (context, error, satck) {
                                          return Icon(
                                            Icons.person,
                                            size: 50,
                                            color: editProfileController
                                                .appColors.grayColor,
                                          );
                                        },
                                      )
                                    : Image.network(
                                        editProfileController.fileName.value,
                                        //File(editProfileController.compress.value.toString()),
                                        fit: BoxFit.cover,
                                        height: 110,
                                        width: 110,
                                        errorBuilder: (context, error, satck) {
                                          return Icon(
                                            Icons.person,
                                            size: 50,
                                            color: editProfileController
                                                .appColors.grayColor,
                                          );
                                        },
                                      )),
                          ),
                          Positioned(
                            top: 78,
                            left: 78,
                            child: SizedBox(
                              height: 35,
                              width: 35,
                              child: FloatingActionButton(
                                backgroundColor: editProfileController
                                    .appColors.darkYellowColor,
                                onPressed: (() {
                                  showOptionDialog(context);
                                }),
                                child: const Icon(Icons.create, size: 25),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      "Name",
                      style: TextStyle(
                          color: editProfileController.appColors.whiteColor,
                          fontSize: 12.sp,
                          fontFamily: "Poppins"),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      height: 60,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color:
                            editProfileController.appColors.textfieldBoxColor,
                      ),
                      child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          style: TextStyle(
                              color: editProfileController.appColors.whiteColor,
                              fontFamily: "Poppins",
                              fontSize: 11.sp),
                          controller:
                              editProfileController.nameController.value,
                          keyboardType: TextInputType.name,
                          cursorColor:
                              editProfileController.appColors.darkYellowColor,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.only(left: 10, top: 10),
                            hintText: 'Enter Name',
                            hintStyle: TextStyle(
                              fontSize: 12.sp,
                              color: editProfileController.appColors.whiteColor
                                  .withOpacity(0.7),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      "Phone Number",
                      style: TextStyle(
                          color: editProfileController.appColors.whiteColor,
                          fontSize: 12.sp,
                          fontFamily: "Poppins"),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 60,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:
                              editProfileController.appColors.textfieldBoxColor,
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.to(EditPhoneScreen());
                          },
                          child: TextFormField(
                              style: TextStyle(
                                  color: editProfileController
                                      .appColors.whiteColor,
                                  fontFamily: "Poppins",
                                  fontSize: 11.sp),
                              enabled: false,
                              controller:
                                  editProfileController.phoneController.value,
                              keyboardType: TextInputType.number,
                              cursorColor: editProfileController
                                  .appColors.darkYellowColor,
                              decoration: InputDecoration(
                                prefix: Padding(
                                  padding: const EdgeInsets.only(right: 3),
                                  child: Text(
                                    editProfileController.countryCode.value,
                                    style: TextStyle(
                                        color: editProfileController
                                            .appColors.whiteColor,
                                        fontSize: 11.sp,
                                        fontFamily: "Poppins"),
                                  ),
                                ),
                                border: InputBorder.none,
                                contentPadding:
                                    const EdgeInsets.only(left: 10, top: 5),
                                hintText: 'Enter Phone Number',
                                hintStyle: TextStyle(
                                  fontSize: 12.sp,
                                  color: editProfileController
                                      .appColors.whiteColor
                                      .withOpacity(0.7),
                                ),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      "Email",
                      style: TextStyle(
                          color: editProfileController.appColors.whiteColor,
                          fontSize: 12.sp,
                          fontFamily: "Poppins"),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                      Container(
                      height: 60,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color:
                            editProfileController.appColors.textfieldBoxColor,
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => EditEmailScreen());
                          //Get.toNamed(Routes.emailEditScreen);
                          // !.then((value) {
                          //   if (value == null) {
                          //     editProfileController.email.value.text =
                          //         profileController.userInfoModel.value.details!.email ?? AppText.email.tr;
                          //   }
                          // });
                        },
                        child: TextFormField(
                            style: TextStyle(
                                color:
                                    editProfileController.appColors.whiteColor,
                                fontFamily: "Poppins",
                                fontSize: 11.sp),
                            controller:
                                editProfileController.emailController.value,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor:
                                editProfileController.appColors.darkYellowColor,
                            enabled: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.only(left: 10, top: 10),
                              hintText: 'Enter Email',
                              hintStyle: TextStyle(
                                fontSize: 12.sp,
                                color: editProfileController
                                    .appColors.whiteColor
                                    .withOpacity(0.7),
                              ),
                            )),
                      ),
                    ),
                      SizedBox(
                      height: 15.h,
                    ),
                    editProfileController.isLoading.isTrue
                        ? Center(
                            child: CircularProgressIndicator(
                            color:
                                editProfileController.appColors.darkYellowColor,
                          ))
                        : GestureDetector(
                            onTap: () async {
                              FocusManager.instance.primaryFocus!.unfocus();
                              if (editProfileController
                                  .nameController.value.text
                                  .trim()
                                  .isNotEmpty) {
                                editProfileController.isLoading.value = true;
                                ApiClient.updateProfile(
                                        image: editProfileController
                                                .selectedFile.value.isNotEmpty
                                            ? editProfileController
                                                .selectedFile.value
                                            : editProfileController
                                                .fileName.value,
                                        phoneNo: editProfileController
                                            .phoneController.value.text
                                            .trim(),
                                        email: editProfileController
                                            .emailController.value.text
                                            .trim(),
                                        name: editProfileController
                                            .nameController.value.text
                                            .trim(),
                                        countryCode: editProfileController
                                            .selectedCountry.dialCode)
                                    .then((value) async {
                                  await ApiClient.getProfileData()
                                      .then((value) {
                                    if (value != null &&
                                        value["data"]["name"].trim() != "") {
                                      ApiClient.toAst(
                                          "Profile Updated Successfully");
                                      // Get.offNamed(Routes.PROFILE_SCREEN,
                                      //     arguments: {
                                      //       "email": value["data"]["email"],
                                      //       "phone": value["data"]["phone"],
                                      //       "image": value["data"]["image"],
                                      //       "name": value["data"]["name"]
                                      //     });
                                      Get.back(result: true);
                                    }
                                  });
                                  editProfileController.isLoading.value = false;
                                });

                                /*

                                editProfileController.updateProfile(
                                    name: editProfileController
                                        .nameController.value.text
                                        .trim(),
                                    email: editProfileController
                                        .emailController.value.text
                                        .trim(),
                                    phoneNo: editProfileController
                                        .phoneController.value.text
                                        .trim(),
                                    image: editProfileController
                                            .selectedFile.value.isNotEmpty
                                        ? editProfileController
                                            .selectedFile.value
                                        : editProfileController.fileName.value,
                                    code: editProfileController
                                        .countryCode.value);*/
                              } else {
                                ApiClient.toAst("Name filed is required");
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 7.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.sp),
                                  color: editProfileController
                                      .appColors.lightgreenColor),
                              child: Padding(
                                padding: EdgeInsets.only(top: 0.3.h),
                                child: Text(
                                  'Update Profile'.tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13.sp,
                                      color: editProfileController
                                          .appColors.whiteColor,
                                      fontFamily: "Arial"),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  _cropImage(filePath) async {
    ImageCropper imageCropper = ImageCropper();

    CroppedFile? croppedImage = (await imageCropper.cropImage(
      sourcePath: filePath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
      maxWidth: 1080,
      maxHeight: 1080,
    ));

    if (croppedImage != null) {
      imageFile = File(croppedImage.path);
      print(imageFile);
      editProfileController.selectedFile.value = imageFile!.path;
    }
  }

  void showOptionDialog(BuildContext context) {
    Get.dialog(StatefulBuilder(builder: (context, StateSetter setState) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(3.sp),
                      topRight: Radius.circular(3.sp)),
                  color: editProfileController.appColors.darkYellowColor,
                ),
                height: 45,
                child: Text(
                  "Select Action",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: editProfileController.appColors.whiteColor,
                      fontFamily: "Poppins"),
                ),
              ),
              SizedBox(height: 2.h),
              InkWell(
                  onTap: () {
                    Get.back();
                    _getFromCamera();
                  },
                  child: Center(
                    child: Text(
                      'Select image from camera',
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: editProfileController.appColors.grayColor,
                          fontFamily: "Poppins"),
                    ),
                  )),
              SizedBox(height: 1.h),
              const Divider(),
              SizedBox(
                height: 1.h,
              ),
              InkWell(
                  onTap: () {
                    _getFromGallery();
                  },
                  child: Center(
                    child: Text(
                      'Select image from gallery',
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: editProfileController.appColors.grayColor,
                          fontFamily: "Poppins"),
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );
    }));
  }

  File? imageFile;

  /// Get from Camera
  _getFromCamera() async {
    XFile? pickedFile;
    if (Platform.isIOS) {
      if (!await Permission.photos.isGranted) {
        var result = await Permission.photos.request();
        if (result.isDenied) {
          openAppSettings();
        } else {
          pickedFile = await pickImage(fromCamera: true);
        }
      } else {
        pickedFile = await pickImage(fromCamera: true);
      }

      // Get.back();
      if (pickedFile != null) {
        // imageFile = File(pickedFile.path);
        _cropImage(pickedFile.path);
      }
    } else {
      if (!await Permission.camera.isGranted) {
        openAppSettings();
      } else {
        XFile? pickedFile = await ImagePicker().pickImage(
          source: ImageSource.camera,
          maxWidth: 1800,
          maxHeight: 1800,
        );
        //Get.back();
        if (pickedFile != null) {
          // imageFile = File(pickedFile.path);
          _cropImage(pickedFile.path);
        }
      }
    }
  }

  late bool permissionStatus;

  /// Get from gallery
  _getFromGallery() async {
    XFile? pickedFile;
    if (Platform.isIOS) {
      if (!await Permission.photos.isGranted) {
        var result = await Permission.photos.request();
        if (result.isDenied) {
          openAppSettings();
        } else {
          pickedFile = await pickImage(fromCamera: false);
        }
      } else {
        pickedFile = await pickImage(fromCamera: false);
      }
      Get.back();
      if (pickedFile != null) {
        _cropImage(pickedFile.path);
      }
    } else {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      if (deviceInfo.version.sdkInt > 32) {
        permissionStatus = await Permission.photos.request().isGranted;
      } else {
        permissionStatus = await Permission.storage.request().isGranted;
      }
      await Permission.storage.request();
      if (deviceInfo.version.sdkInt > 32
          ? !await Permission.photos.isGranted
          : !await Permission.storage.isGranted) {
        openAppSettings();
      } else {
        XFile? pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          maxWidth: 1800,
          maxHeight: 1800,
        );
        Get.back();
        if (pickedFile != null) {
          // imageFile = File(pickedFile.path);
          _cropImage(pickedFile.path);
        }
      }
    }
  }

  Future<XFile?> pickImage({bool fromCamera = true}) async {
    return await ImagePicker().pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
  }
}
