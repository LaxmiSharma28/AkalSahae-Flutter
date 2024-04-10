import 'package:akalsahae/app/apiCollection/api_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'edit_profile_controller.dart';

class EditEmailScreen extends StatelessWidget {
  EditEmailScreen({super.key});

  EditProfileController editProfileController = Get.put(EditProfileController());
  //ProfileController profileController = Get.find();

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
          title: Text('Update Email'.tr,
              style:
                  TextStyle(color: editProfileController.appColors.whiteColor, fontSize: 14.sp, fontFamily: "Poppins")),
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
      body: Obx(()=>Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.5.w, vertical: 1.5.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.h,
              ),
              Text(
                "Enter your Email Address",
                style: TextStyle(
                    color: editProfileController.appColors.whiteColor, fontSize: 14.sp, fontFamily: "Poppins"),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "We will send you OTP on the entered Email to verify your Email.",
                style: TextStyle(
                    color: editProfileController.appColors.whiteColor, fontSize: 12.sp, fontFamily: "Poppins"),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                height: 7.1.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: editProfileController.appColors.textfieldBoxColor,
                ),
                child: TextFormField(
                  style:
                  TextStyle(color: editProfileController.appColors.whiteColor, fontFamily: "Poppins", fontSize: 11.sp),
                  controller: editProfileController.emailController.value,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: editProfileController.appColors.darkYellowColor,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(
                          fontSize: 12.sp, color: editProfileController.appColors.whiteColor.withOpacity(0.7)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 10, top: 10),
                      hintText: "Enter your email"),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              editProfileController.isEditPhone.isTrue?Center(child: CircularProgressIndicator(color:
              editProfileController.appColors.darkYellowColor,),):   GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus!.unfocus();
                  if (validations()) {
                    editProfileController.editPhoneEmail(type:"email");
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 7.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.sp), color: editProfileController.appColors.lightgreenColor),
                  child: Padding(
                    padding: EdgeInsets.only(top: 0.3.h),
                    child: Text(
                      'UPDATE'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13.sp,
                          color: editProfileController.appColors.whiteColor,
                          fontFamily: "Arial"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  validations() {
    if (editProfileController.emailController.value.text.trim().isEmpty) {
      ApiClient.toAst('Please enter your email');
      return false;
    } else if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(editProfileController.emailController.value.text.trim()) ==
        false) {
      ApiClient.toAst('Please enter valid email');
      return false;
    } else {
      return true;
    }
  }
}
