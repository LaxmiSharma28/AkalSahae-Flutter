import 'package:akalsahae/app/apiCollection/api_client.dart';
import 'package:country_list_pick/country_selection_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../helper_widget/country_Code.dart';
import 'edit_profile_controller.dart';

class EditPhoneScreen extends StatelessWidget {
  EditPhoneScreen({super.key});

  EditProfileController editProfileController = Get.find();

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
          title: Text('Update Phone Number'.tr,
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
      body: Obx(() => Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.5.w, vertical: 1.5.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "Enter your Phone Number",
                    style: TextStyle(
                        color: editProfileController.appColors.whiteColor, fontSize: 14.sp, fontFamily: "Poppins"),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "We will send you OTP on the entered Phone Number to verify your Phone Number.",
                    style: TextStyle(
                        color: editProfileController.appColors.whiteColor, fontSize: 12.sp, fontFamily: "Poppins"),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.sp),
                        color: editProfileController.appColors.textfieldBoxColor),
                    height: 7.1.h,
                    width: 90.w,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(3.sp), topLeft: Radius.circular(3.sp)),
                                color: editProfileController.appColors.textfieldBoxColor),
                            height: 7.1.h,
                            width: 20.w,
                            child: CountryListPick(
                              appBar: AppBar(
                                  backgroundColor: Colors.grey[900],
                                  elevation: 0,
                                  centerTitle: true,
                                  actions: [
                                    Padding(
                                        padding: EdgeInsets.only(top: 2.h, right: 4.w),
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Text(
                                            'Done',
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w700,
                                                color: editProfileController.appColors.whiteColor),
                                          ),
                                        )),
                                  ],
                                  title: Text(
                                    'Country Code',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700,
                                        color: editProfileController.appColors.whiteColor),
                                  )),
                              theme: CountryTheme(
                                alphabetTextColor: Colors.white,
                                // alphabetSelectedTextColor: Colors.white,
                                // containerColor: editProfileController.appColors.textfieldBoxColor,
                                // backgroundColor: Colors.black,
                                labelColor: editProfileController.appColors.whiteColor,
                                alphabetSelectedBackgroundColor: editProfileController.appColors.darkYellowColor,
                                isShowFlag: true,
                                isShowTitle: false,
                                isShowCode: true,
                                isDownIcon: true,
                                showEnglishName: true,
                              ),
                              initialSelection: editProfileController.selectedCountryCode.toString(),
                              onChanged: (ct) {
                                editProfileController.onCountryChange(ct!);
                              },
                            ),
                          ),
                        ),
                        VerticalDivider(
                          color: editProfileController.appColors.dividerColor,
                          width: 1,
                          thickness: 1,
                          indent: 0.4.h,
                        ),
                        Expanded(
                          flex: 5,
                          child: SizedBox(
                            height: 7.1.h,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextFormField(
                                inputFormatters: [LengthLimitingTextInputFormatter(15)],
                                cursorColor: editProfileController.appColors.darkYellowColor,
                                onChanged: (value) {
                                  editProfileController.phone = value;
                                  editProfileController.update();
                                },
                                style: TextStyle(
                                    color: editProfileController.appColors.whiteColor,
                                    fontFamily: "Poppins",
                                    fontSize: 11.sp),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                controller: editProfileController.phoneController.value,
                                decoration: InputDecoration(
                                  filled: true,
                                  contentPadding: EdgeInsets.only(left: 3.w),
                                  isDense: true,
                                  fillColor: editProfileController.appColors.textfieldBoxColor,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(5.sp), bottomRight: Radius.circular(5.sp)),
                                      borderSide: BorderSide.none),
                                  hintText: 'Phone',
                                  hintStyle: TextStyle(
                                    fontSize: 12.sp,
                                    color: editProfileController.appColors.whiteColor.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Obx(
                    () => editProfileController.isEditPhone.isTrue
                        ? Center(
                            child: CircularProgressIndicator(
                            color: editProfileController.appColors.darkYellowColor,
                          ))
                        : GestureDetector(
                            onTap: () {
                              FocusManager.instance.primaryFocus!.unfocus();
                              if (validations()) {
                                editProfileController.editPhoneEmail(type: "phone");

                                // Get.to(VerifyPhoneOtpScreen());
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 7.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.sp),
                                  color: editProfileController.appColors.lightgreenColor),
                              child: Padding(
                                padding: EdgeInsets.only(top: 0.3.h),
                                child: Text(
                                  'Update'.tr,
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
                  )
                ],
              ),
            ),
          )),
    );
  }

  validations() {
    if (editProfileController.phoneController.value.text.trim().isEmpty) {
      ApiClient.toAst('Please enter your mobile number');
      return false;
    } else if (editProfileController.phoneController.value.text.trim().length < 8) {
      ApiClient.toAst('Phone number can not be less than 8 digits');
      return false;
    } else if (editProfileController.phoneController.value.text.trim().length > 15) {
      ApiClient.toAst('Phone number can not be more than 15 digits');
      return false;
    } else {
      return true;
    }
  }
}
