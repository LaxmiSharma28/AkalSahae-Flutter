import 'dart:io';
import 'package:akalsahae/app/apiCollection/api_client.dart';
import 'package:akalsahae/app/modules/add_address_screen_module/add_address_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddAddressScreenPage extends GetView<AddAddressScreenController> {
  final bool isShipping;

  AddAddressScreenPage({super.key, this.isShipping = false});

  final addAddressController = Get.find<AddAddressScreenController>();

  @override
  Widget build(BuildContext context) {
    //addAddressController = isShipping ? addShippingAddressController : addMainAddressController;
    return GetBuilder<AddAddressScreenController>(
      init: addAddressController,
      builder: (controller) {
        return NotificationListener<OverscrollIndicatorNotification>(
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
                title: Text(
                    addAddressController.saveAddressScreenController.isEditing.value
                        ? 'Edit Address'
                        : 'Add New Address'.tr,
                    style: TextStyle(fontSize: 14.sp, fontFamily: "Poppins")),
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
            body: ListView(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 6.w),
              children: [
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.5.w),
                  child: Text(
                    "Shipping Address",
                    style:
                        TextStyle(fontSize: 14.sp, color: addAddressController.appColors.whiteColor, fontFamily: "Arial"),
                  ),
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.5.w),
                  child: Text(
                    'name'.tr,
                    style:
                        TextStyle(fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontFamily: "Arial"),
                  ),
                ),
                SizedBox(
                  height: 0.7.h,
                ),
                SizedBox(
                  height: 6.7.h,
                  width: 100.w,
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    controller: addAddressController.nameController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(25),
                    ],
                    style: TextStyle(
                        fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontWeight: FontWeight.w500),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        hintText: "name".tr,
                        hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 11.sp,
                            color: addAddressController.appColors.whiteColor.withOpacity(0.7)),
                        fillColor: addAddressController.appColors.textfieldBoxColor,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 2.2.h, horizontal: 4.w),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                            borderRadius: BorderRadius.circular(5.sp)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                            borderRadius: BorderRadius.circular(5.sp)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.sp))),
                    onChanged: (value) {
                      addAddressController.updateBillingAddress();
                    },
                  ),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.5.w),
                  child: Text(
                    'mobile_number'.tr,
                    style:
                        TextStyle(fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontFamily: "Arial"),
                  ),
                ),
                SizedBox(
                  height: 0.7.h,
                ),
                SizedBox(
                  height: 6.7.h,
                  width: 100.w,
                  child: TextFormField(
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    textInputAction: TextInputAction.next,
                    controller: addAddressController.mobileController,
                    style: TextStyle(
                        fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontWeight: FontWeight.w500),
                    cursorColor: addAddressController.appColors.whiteColor,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        fillColor: addAddressController.appColors.textfieldBoxColor,
                        filled: true,
                        hintText: 'mobile_number'.tr,
                        hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 11.sp,
                            color: addAddressController.appColors.whiteColor.withOpacity(0.7)),
                        contentPadding: EdgeInsets.symmetric(vertical: 2.2.h, horizontal: 4.w),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                            borderRadius: BorderRadius.circular(5.sp)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                            borderRadius: BorderRadius.circular(5.sp)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.sp))),
                    onChanged: (value) {
                      addAddressController.updateBillingAddress();
                    },
                  ),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.5.w),
                  child: Text(
                    'address'.tr,
                    style:
                        TextStyle(fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontFamily: "Arial"),
                  ),
                ),
                SizedBox(
                  height: 0.7.h,
                ),
                SizedBox(
                  height: 15.h,
                  width: 100.w,
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.sentences,
                    controller: addAddressController.addressController,
                    style: TextStyle(
                        fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontWeight: FontWeight.w500),
                    maxLines: 5,
                    cursorColor: addAddressController.appColors.whiteColor,
                    decoration: InputDecoration(
                        hintText: 'address'.tr,
                        hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 11.sp,
                            color: addAddressController.appColors.whiteColor.withOpacity(0.7)),
                        fillColor: addAddressController.appColors.textfieldBoxColor,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 2.2.h, horizontal: 4.w),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                            borderRadius: BorderRadius.circular(5.sp)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                            borderRadius: BorderRadius.circular(5.sp)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.sp))),
                    onChanged: (value) {
                      addAddressController.updateBillingAddress();
                    },
                  ),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.5.w),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'pincode'.tr,
                            style: TextStyle(
                                fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontFamily: "Arial"),
                          ),
                          SizedBox(
                            height: 0.7.h,
                          ),
                          SizedBox(
                            height: 6.7.h,
                            width: 42.5.w,
                            child: TextFormField(
                              //maxLength: 10,
                              enabled: addAddressController.isPincodeEnable,
                              textInputAction: TextInputAction.search,
                              inputFormatters: [LengthLimitingTextInputFormatter(10)],
                              controller: addAddressController.pinCodeController,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: addAddressController.appColors.whiteColor,
                                  fontWeight: FontWeight.w500),
                              cursorColor: addAddressController.appColors.whiteColor,
                              keyboardType: Platform.isIOS
                                  ? const TextInputType.numberWithOptions(signed: true, decimal: true)
                                  : TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: 'pincode'.tr,
                                  hintStyle: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 11.sp,
                                      color: addAddressController.appColors.whiteColor.withOpacity(0.7)),
                                  fillColor: addAddressController.appColors.textfieldBoxColor,
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 2.2.h, horizontal: 4.w),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                                      borderRadius: BorderRadius.circular(5.sp)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                                      borderRadius: BorderRadius.circular(5.sp)),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.sp))),
                              onChanged: (value) {
                                addAddressController.dropDownItem.clear();
                                addAddressController.city.value = '';
                                addAddressController.countryController.text = '';
                                addAddressController.stateController.text = '';
                              },
                              onFieldSubmitted: (value) async {
                                final response = await addAddressController.pinCodeData(value);
                                if (response != null) {
                                  if (response.message.toString() == "No Delivery Available at this zipcode") {
                                    ApiClient.toAst("No Delivery Available at this zipcode");
                                    return;
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 2.4.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'city'.tr,
                            style: TextStyle(
                                fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontFamily: "Arial"),
                          ),
                          SizedBox(
                            height: 0.7.h,
                          ),
                          SizedBox(
                              height: 6.5.h,
                              width: 42.5.w,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: addAddressController.appColors.textfieldBoxColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: DropdownButton<String>(
                                    isExpanded: true,
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    dropdownColor: addAddressController.appColors.textfieldBoxColor,
                                    style: const TextStyle(color: Colors.white),
                                    icon: const Padding(
                                      padding: EdgeInsets.only(top: 8, right: 10, left: 10, bottom: 8),
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.white,
                                      ),
                                    ),
                                    underline: const SizedBox(),
                                    hint: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Obx(
                                        () => Text(
                                          addAddressController.city.value,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500, fontSize: 11.sp, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    items: controller.dropDownItem
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList(),
                                    onChanged: (v) {
                                      addAddressController.city.value = v!;
                                    }),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.5.w),
                  child: Text(
                    'state'.tr,
                    style:
                        TextStyle(fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontFamily: "Arial"),
                  ),
                ),
                SizedBox(
                  height: 0.7.h,
                ),
                SizedBox(
                  height: 6.7.h,
                  width: 100.w,
                  child: TextFormField(
                    enabled: false,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.sentences,
                    controller: addAddressController.stateController,
                    style: TextStyle(
                        fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontWeight: FontWeight.w500),
                    cursorColor: addAddressController.appColors.whiteColor,
                    decoration: InputDecoration(
                        hintText: 'state'.tr,
                        hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 11.sp,
                            color: addAddressController.appColors.whiteColor.withOpacity(0.7)),
                        fillColor: addAddressController.appColors.textfieldBoxColor,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 2.2.h, horizontal: 4.w),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                            borderRadius: BorderRadius.circular(5.sp)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                            borderRadius: BorderRadius.circular(5.sp)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.sp))),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.5.w),
                  child: Text(
                    'Country'.tr,
                    style:
                        TextStyle(fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontFamily: "Arial"),
                  ),
                ),
                SizedBox(
                  height: 0.7.h,
                ),
                SizedBox(
                  height: 6.7.h,
                  width: 100.w,
                  child: TextFormField(
                    enabled: false,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.sentences,
                    controller: addAddressController.countryController,
                    style: TextStyle(
                        fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontWeight: FontWeight.w500),
                    //controller: verificationScreenController.verifi6controller,
                    cursorColor: addAddressController.appColors.whiteColor,
                    decoration: InputDecoration(
                        hintText: 'Country'.tr,
                        hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 11.sp,
                            color: addAddressController.appColors.whiteColor.withOpacity(0.7)),
                        fillColor: addAddressController.appColors.textfieldBoxColor,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 2.2.h, horizontal: 4.w),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                            borderRadius: BorderRadius.circular(5.sp)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                            borderRadius: BorderRadius.circular(5.sp)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.sp))),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.5.w),
                  child: Text(
                    'email'.tr,
                    style:
                        TextStyle(fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontFamily: "Arial"),
                  ),
                ),
                SizedBox(
                  height: 0.7.h,
                ),
                SizedBox(
                  height: 6.7.h,
                  width: 100.w,
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.emailAddress,
                    controller: addAddressController.emailController,
                    style: TextStyle(
                        fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontWeight: FontWeight.w500),
                    cursorColor: addAddressController.appColors.whiteColor,
                    decoration: InputDecoration(
                        hintText: 'email'.tr,
                        hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 11.sp,
                            color: addAddressController.appColors.whiteColor.withOpacity(0.7)),
                        fillColor: addAddressController.appColors.textfieldBoxColor,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 2.2.h, horizontal: 4.w),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                            borderRadius: BorderRadius.circular(5.sp)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                            borderRadius: BorderRadius.circular(5.sp)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.sp))),
                    onChanged: (value) {
                      addAddressController.updateBillingAddress();
                    },
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.5.w),
                  child: Text(
                    'save_as_address'.tr,
                    style:
                        TextStyle(fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontFamily: "Arial"),
                  ),
                ),
                SizedBox(
                  height: 0.7.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.5.w),
                  child: Row(
                    children: [
                      addAddressController.customRadioButton("home".tr, 1),
                      SizedBox(
                        width: 3.w,
                      ),
                      addAddressController.customRadioButton("work".tr, 2),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      addAddressController.saveAddressScreenController.defaultAddress.value.isDefault == null
                          ? Container(
                              width: 2.2.h,
                              height: 2.2.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.sp),
                                  border: Border.all(
                                    color: addAddressController.appColors.darkYellowColor,
                                    width: 0.3.w,
                                  ),
                                  color: addAddressController.appColors.darkYellowColor),
                              child: Icon(
                                Icons.check_outlined,
                                color: addAddressController.appColors.blackColor,
                                size: 12.sp,
                              ))
                          : GestureDetector(
                              onTap: addAddressController.toggleCheckbox,
                              child: Container(
                                width: 2.2.h,
                                height: 2.2.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.sp),
                                  border: Border.all(
                                    color: addAddressController.appColors.darkYellowColor,
                                    width: 0.3.w,
                                  ),
                                  color: addAddressController.isDefaultAddress.value
                                      ? addAddressController.appColors.darkYellowColor
                                      : Colors.transparent,
                                ),
                                child: addAddressController.isDefaultAddress.value
                                    ? Icon(
                                        Icons.check_outlined,
                                        color: addAddressController.appColors.blackColor,
                                        size: 12.sp,
                                      )
                                    : null,
                              ),
                            ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        'make_this_my_defult_addres'.tr,
                        style: TextStyle(
                          color: addAddressController.appColors.whiteColor,
                          fontFamily: "Arial",
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                const Divider(
                  color: Colors.white,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: addAddressController.toggleCheckbox1,
                        child: Container(
                          width: 2.2.h,
                          height: 2.2.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.sp),
                            border: Border.all(
                              color: addAddressController.appColors.darkYellowColor,
                              width: 0.3.w,
                            ),
                            color: addAddressController.isBilling.value
                                ? addAddressController.appColors.darkYellowColor
                                : Colors.transparent,
                          ),
                          child: addAddressController.isBilling.value
                              ? Icon(
                                  Icons.check_outlined,
                                  color: addAddressController.appColors.blackColor,
                                  size: 12.sp,
                                )
                              : null,
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        "Use same address as billing address",
                        style: TextStyle(
                          color: addAddressController.appColors.whiteColor,
                          fontFamily: "Arial",
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                GestureDetector(
                  onTap: () {
                    addAddressController.isBillingOpen.value = !addAddressController.isBillingOpen.value;
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 0.5.w),
                        child: Text(
                          "Billing Address",
                          style: TextStyle(
                              fontSize: 14.sp, color: addAddressController.appColors.whiteColor, fontFamily: "Arial"),
                        ),
                      ),
                      const Spacer(),
                      Obx(
                        () => addAddressController.isBillingOpen.value
                            ? Icon(
                                Icons.keyboard_arrow_up,
                                color: addAddressController.appColors.darkYellowColor,
                              )
                            : Icon(
                                Icons.keyboard_arrow_down,
                                color: addAddressController.appColors.darkYellowColor,
                              ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                Obx(
                  () => Visibility(
                    visible: addAddressController.isBillingOpen.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 0.5.w),
                          child: Text(
                            'name'.tr,
                            style: TextStyle(
                                fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontFamily: "Arial"),
                          ),
                        ),
                        SizedBox(
                          height: 0.7.h,
                        ),
                        SizedBox(
                          height: 6.7.h,
                          width: 100.w,
                          child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            textInputAction: TextInputAction.next,
                            controller: addAddressController.shippingNameController,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(25),
                            ],
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: addAddressController.appColors.whiteColor,
                                fontWeight: FontWeight.w500),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                hintText: "name".tr,
                                hintStyle: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 11.sp,
                                    color: addAddressController.appColors.whiteColor.withOpacity(0.7)),
                                fillColor: addAddressController.appColors.textfieldBoxColor,
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 2.2.h, horizontal: 4.w),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                                    borderRadius: BorderRadius.circular(5.sp)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                                    borderRadius: BorderRadius.circular(5.sp)),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.sp))),
                            onChanged: (value) {
                              addAddressController.updateBillingAddress();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 0.5.w),
                          child: Text(
                            'mobile_number'.tr,
                            style: TextStyle(
                                fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontFamily: "Arial"),
                          ),
                        ),
                        SizedBox(
                          height: 0.7.h,
                        ),
                        SizedBox(
                          height: 6.7.h,
                          width: 100.w,
                          child: TextFormField(
                            inputFormatters: [LengthLimitingTextInputFormatter(10)],
                            textInputAction: TextInputAction.next,
                            controller: addAddressController.shippingMobileController,
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: addAddressController.appColors.whiteColor,
                                fontWeight: FontWeight.w500),
                            cursorColor: addAddressController.appColors.whiteColor,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                fillColor: addAddressController.appColors.textfieldBoxColor,
                                filled: true,
                                hintText: 'mobile_number'.tr,
                                hintStyle: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 11.sp,
                                    color: addAddressController.appColors.whiteColor.withOpacity(0.7)),
                                contentPadding: EdgeInsets.symmetric(vertical: 2.2.h, horizontal: 4.w),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                                    borderRadius: BorderRadius.circular(5.sp)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                                    borderRadius: BorderRadius.circular(5.sp)),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.sp))),
                            onChanged: (value) {
                              addAddressController.updateBillingAddress();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 0.5.w),
                          child: Text(
                            'address'.tr,
                            style: TextStyle(
                                fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontFamily: "Arial"),
                          ),
                        ),
                        SizedBox(
                          height: 0.7.h,
                        ),
                        SizedBox(
                          height: 15.h,
                          width: 100.w,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.sentences,
                            controller: addAddressController.shippingAddressController,
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: addAddressController.appColors.whiteColor,
                                fontWeight: FontWeight.w500),
                            maxLines: 5,
                            cursorColor: addAddressController.appColors.whiteColor,
                            decoration: InputDecoration(
                                hintText: 'address'.tr,
                                hintStyle: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 11.sp,
                                    color: addAddressController.appColors.whiteColor.withOpacity(0.7)),
                                fillColor: addAddressController.appColors.textfieldBoxColor,
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 2.2.h, horizontal: 4.w),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                                    borderRadius: BorderRadius.circular(5.sp)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                                    borderRadius: BorderRadius.circular(5.sp)),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.sp))),
                            onChanged: (value) {
                              addAddressController.updateBillingAddress();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 0.5.w),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'pincode'.tr,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: addAddressController.appColors.whiteColor,
                                        fontFamily: "Arial"),
                                  ),
                                  SizedBox(
                                    height: 0.7.h,
                                  ),
                                  SizedBox(
                                    height: 6.7.h,
                                    width: 42.5.w,
                                    child: TextFormField(
                                      enabled: addAddressController.isPincodeEnable,
                                      textInputAction: TextInputAction.search,
                                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                                      controller: addAddressController.shippingPinCodeController,
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: addAddressController.appColors.whiteColor,
                                          fontWeight: FontWeight.w500),
                                      cursorColor: addAddressController.appColors.whiteColor,
                                      keyboardType: Platform.isIOS
                                          ? const TextInputType.numberWithOptions(signed: true, decimal: true)
                                          : TextInputType.number,
                                      decoration: InputDecoration(
                                          hintText: 'pincode'.tr,
                                          hintStyle: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 11.sp,
                                              color: addAddressController.appColors.whiteColor.withOpacity(0.7)),
                                          fillColor: addAddressController.appColors.textfieldBoxColor,
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(vertical: 2.2.h, horizontal: 4.w),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                                              borderRadius: BorderRadius.circular(5.sp)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                                              borderRadius: BorderRadius.circular(5.sp)),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.sp))),
                                      onChanged: (value) {
                                        addAddressController.dropDownItemShipping.clear();
                                        addAddressController.cityShipping.value = '';
                                        addAddressController.shippingCountryController.text = '';
                                        addAddressController.shippingStateController.text = '';
                                      },
                                      onFieldSubmitted: (value) async {
                                        final response = await addAddressController.pinCodeShippingData(value);
                                        if (response != null) {
                                          if (response.message.toString() == "No Delivery Available at this zipcode") {
                                            ApiClient.toAst("No Delivery Available at this zipcode");
                                            return;
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 2.4.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'city'.tr,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: addAddressController.appColors.whiteColor,
                                        fontFamily: "Arial"),
                                  ),
                                  SizedBox(
                                    height: 0.7.h,
                                  ),
                                  SizedBox(
                                      height: 6.5.h,
                                      width: 42.5.w,
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: addAddressController.appColors.textfieldBoxColor,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: DropdownButton<String>(
                                            isExpanded: true,
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            dropdownColor: addAddressController.appColors.textfieldBoxColor,
                                            style: const TextStyle(color: Colors.white),
                                            icon: const Padding(
                                              padding: EdgeInsets.only(top: 8, right: 10, left: 10, bottom: 8),
                                              child: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.white,
                                              ),
                                            ),
                                            underline: const SizedBox(),
                                            hint: Padding(
                                              padding: const EdgeInsets.only(left: 8),
                                              child: Obx(
                                                () => Text(
                                                  addAddressController.cityShipping.value,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500, fontSize: 11.sp, color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            items: controller.dropDownItemShipping
                                                .map((e) => DropdownMenuItem(
                                                      value: e,
                                                      child: Text(e),
                                                    ))
                                                .toList(),
                                            onChanged: (v) {
                                              addAddressController.cityShipping.value = v!;
                                            }),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 0.5.w),
                          child: Text(
                            'state'.tr,
                            style: TextStyle(
                                fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontFamily: "Arial"),
                          ),
                        ),
                        SizedBox(
                          height: 0.7.h,
                        ),
                        SizedBox(
                          height: 6.7.h,
                          width: 100.w,
                          child: TextFormField(
                            enabled: false,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.sentences,
                            controller: addAddressController.shippingStateController,
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: addAddressController.appColors.whiteColor,
                                fontWeight: FontWeight.w500),
                            cursorColor: addAddressController.appColors.whiteColor,
                            decoration: InputDecoration(
                                hintText: 'state'.tr,
                                hintStyle: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 11.sp,
                                    color: addAddressController.appColors.whiteColor.withOpacity(0.7)),
                                fillColor: addAddressController.appColors.textfieldBoxColor,
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 2.2.h, horizontal: 4.w),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                                    borderRadius: BorderRadius.circular(5.sp)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                                    borderRadius: BorderRadius.circular(5.sp)),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.sp))),
                            onChanged: (value) {},
                          ),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 0.5.w),
                          child: Text(
                            'Country'.tr,
                            style: TextStyle(
                                fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontFamily: "Arial"),
                          ),
                        ),
                        SizedBox(
                          height: 0.7.h,
                        ),
                        SizedBox(
                          height: 6.7.h,
                          width: 100.w,
                          child: TextFormField(
                            enabled: false,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.sentences,
                            controller: addAddressController.shippingCountryController,
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: addAddressController.appColors.whiteColor,
                                fontWeight: FontWeight.w500),
                            cursorColor: addAddressController.appColors.whiteColor,
                            decoration: InputDecoration(
                                hintText: 'Country'.tr,
                                hintStyle: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 11.sp,
                                    color: addAddressController.appColors.whiteColor.withOpacity(0.7)),
                                fillColor: addAddressController.appColors.textfieldBoxColor,
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 2.2.h, horizontal: 4.w),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                                    borderRadius: BorderRadius.circular(5.sp)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                                    borderRadius: BorderRadius.circular(5.sp)),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.sp))),
                            onChanged: (value) {},
                          ),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 0.5.w),
                          child: Text(
                            'email'.tr,
                            style: TextStyle(
                                fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontFamily: "Arial"),
                          ),
                        ),
                        SizedBox(
                          height: 0.7.h,
                        ),
                        SizedBox(
                          height: 6.7.h,
                          width: 100.w,
                          child: TextFormField(
                            textInputAction: TextInputAction.done,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            controller: addAddressController.shippingEmailController,
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: addAddressController.appColors.whiteColor,
                                fontWeight: FontWeight.w500),
                            cursorColor: addAddressController.appColors.whiteColor,
                            decoration: InputDecoration(
                                hintText: 'email'.tr,
                                hintStyle: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 11.sp,
                                    color: addAddressController.appColors.whiteColor.withOpacity(0.7)),
                                fillColor: addAddressController.appColors.textfieldBoxColor,
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 2.2.h, horizontal: 4.w),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                                    borderRadius: BorderRadius.circular(5.sp)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                                    borderRadius: BorderRadius.circular(5.sp)),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.sp))),
                            onChanged: (value) {
                              addAddressController.updateBillingAddress();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.5.h,
                ),
                Obx(() => addAddressController.isLoading.isTrue
                    ? Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: addAddressController.appColors.darkYellowColor,
                          ),
                        ),
                      )
                    : Center(
                        child: SizedBox(
                          width: 90.w,
                          height: 6.7.h,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: addAddressController.appColors.lightgreenColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.sp))),
                              onPressed: () async {
                                FocusManager.instance.primaryFocus!.unfocus();

                                if (addAddressController.saveAddressScreenController.isEditing.value) {
                                  if (validations()) {
                                    addAddressController.updateAddress();
                                  }
                                } else {
                                  if (validations()) {
                                    print("Pin code: ${addAddressController.pincodeController.text}");
                                    print("Pin code: ${addAddressController.shippingPinCodeController.text}");
                                    addAddressController.addAddressData();
                                  }
                                }
                              },
                              child: Center(
                                child: Text(
                                  addAddressController.saveAddressScreenController.isEditing.value
                                      ? 'update_address'.tr
                                      : 'add_address'.tr,
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      color: addAddressController.appColors.whiteColor,
                                      fontFamily: "Arial",
                                      fontWeight: FontWeight.w700),
                                ),
                              )),
                        ),
                      )),
                SizedBox(
                  height: 3.h,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  validations() {
    if (addAddressController.nameController.text.trim().isEmpty) {
      ApiClient.toAst('Please enter your name');

      return false;
    } else if (addAddressController.mobileController.text.trim().isEmpty) {
      ApiClient.toAst('Please enter your mobile number');

      return false;
    } else if (addAddressController.mobileController.text.trim().length < 8) {
      ApiClient.toAst('Phone number can not be less than 8 digits');

      return false;
    } else if (addAddressController.mobileController.text.trim().length > 15) {
      ApiClient.toAst('Phone number can not be more than 15 digits');

      return false;
    } else if (addAddressController.addressController.text.trim().isEmpty) {
      ApiClient.toAst('Please enter your address');

      return false;
    } else if (addAddressController.pinCodeController.text.trim().isEmpty) {
      ApiClient.toAst('Please enter your pin code');

      return false;
    } else if (addAddressController.city.value.trim().isEmpty) {
      ApiClient.toAst('Please enter your city');

      return false;
    } else if (addAddressController.stateController.text.trim().isEmpty) {
      ApiClient.toAst('Please enter your state');

      return false;
    } else if (addAddressController.countryController.text.trim().isEmpty) {
      ApiClient.toAst('Please enter your country');

      return false;
    } else if (addAddressController.emailController.text.trim().isEmpty) {
      ApiClient.toAst('Please enter your email');

      return false;
    } else if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(addAddressController.emailController.text.trim()) ==
        false) {
      ApiClient.toAst('Please enter valid email');

      return false;
    } else if (addAddressController.saveAddressScreenController.defaultAddress.value.addressType == null ||
        addAddressController.saveAddressScreenController.defaultAddress.value.addressType.toString().isEmpty) {
      ApiClient.toAst('Please select address type');

      return false;
    } else if (addAddressController.shippingNameController.text.trim().isEmpty) {
      ApiClient.toAst('Please enter your billing name');

      return false;
    } else if (addAddressController.shippingMobileController.text.trim().isEmpty) {
      ApiClient.toAst('Please enter your billing mobile number');

      return false;
    } else if (addAddressController.shippingMobileController.text.trim().length < 8) {
      ApiClient.toAst('Phone number can not be less than 8 digits');

      return false;
    } else if (addAddressController.shippingMobileController.text.trim().length > 15) {
      ApiClient.toAst('Phone number can not be more than 15 digits');

      return false;
    } else if (addAddressController.shippingAddressController.text.trim().isEmpty) {
      ApiClient.toAst('Please enter your billing address');

      return false;
    } else if (addAddressController.shippingPinCodeController.text.trim().isEmpty) {
      ApiClient.toAst('Please enter your billing pin code');

      return false;
    } else if (addAddressController.cityShipping.value.trim().isEmpty) {
      ApiClient.toAst('Please enter your billing city');

      return false;
    } else if (addAddressController.shippingStateController.text.trim().isEmpty) {
      ApiClient.toAst('Please enter your billing state');

      return false;
    } else if (addAddressController.shippingCountryController.text.trim().isEmpty) {
      ApiClient.toAst('Please enter your billing country');

      return false;
    } else if (addAddressController.shippingEmailController.text.trim().isEmpty) {
      ApiClient.toAst('Please enter your billing email');

      return false;
    } else if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(addAddressController.emailController.text.trim()) ==
        false) {
      ApiClient.toAst('Please enter valid billing email');

      return false;
    } else {
      return true;
    }
  }
}



/*
import 'dart:io';

import 'package:akalsahae/app/apiCollection/api_client.dart';
import 'package:akalsahae/app/modules/add_address_screen_module/add_address_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddAddressScreenPage extends GetView<AddAddressScreenController> {
  final bool isShipping;

  AddAddressScreenPage({super.key, this.isShipping = false});

  final addMainAddressController = Get.find<AddAddressScreenController>();
  final addShippingAddressController = Get.find<AddAddressScreenController>(tag: "shipping");
  late AddAddressScreenController addAddressController;

  @override
  Widget build(BuildContext context) {
    addAddressController = isShipping ? addShippingAddressController : addMainAddressController;
    return GetBuilder<AddAddressScreenController>(
      init: addAddressController,
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black,
              toolbarHeight: 0.h,
              bottom: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.black,
                title: Text(
                    addAddressController.saveAddressScreenController.isEditing.value
                        ? 'Edit Address'
                        : isShipping
                            ? "Shipping Address"
                            : 'Add New Address'.tr,
                    style: TextStyle(fontSize: 14.sp, fontFamily: "Poppins")),
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
            body: ListView(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 6.w),
              children: [
                isShipping
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: EdgeInsets.only(left: 0.5.w),
                        child: Text(
                          'Bill To'.tr,
                          style: TextStyle(
                              fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontFamily: "Arial"),
                        ),
                      ),
                isShipping
                    ? const SizedBox.shrink()
                    : SizedBox(
                        height: 0.7.h,
                      ),
                isShipping
                    ? const SizedBox.shrink()
                    : SizedBox(
                        //height: 6.7.h,
                        width: 100.w,
                        child: TextFormField(
                          maxLines: 3,
                          onTap: () {
                            Get.to(() => AddAddressScreenPage(isShipping: true));
                          },
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.next,
                          controller: addAddressController.billingController,
                          readOnly: true,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(25),
                          ],
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: addAddressController.appColors.whiteColor,
                              fontWeight: FontWeight.w500),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              hintText: "Bill To".tr,
                              hintStyle: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 11.sp,
                                  color: addAddressController.appColors.whiteColor.withOpacity(0.7)),
                              fillColor: addAddressController.appColors.textfieldBoxColor,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 2.2.h, horizontal: 4.w),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                                  borderRadius: BorderRadius.circular(5.sp)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                                  borderRadius: BorderRadius.circular(5.sp)),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.sp))),
                          onChanged: (value) {},
                        ),
                      ),
                SizedBox(
                  height: 1.5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.5.w),
                  child: Text(
                    'name'.tr,
                    style: TextStyle(
                        fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontFamily: "Arial"),
                  ),
                ),
                SizedBox(
                  height: 0.7.h,
                ),
                SizedBox(
                  height: 6.7.h,
                  width: 100.w,
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    controller: addAddressController.nameController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(25),
                    ],
                    style: TextStyle(
                        fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontWeight: FontWeight.w500),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        hintText: "name".tr,
                        hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 11.sp,
                            color: addAddressController.appColors.whiteColor.withOpacity(0.7)),
                        fillColor: addAddressController.appColors.textfieldBoxColor,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 2.2.h, horizontal: 4.w),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                            borderRadius: BorderRadius.circular(5.sp)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                            borderRadius: BorderRadius.circular(5.sp)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.sp))),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.5.w),
                  child: Text(
                    'mobile_number'.tr,
                    style: TextStyle(
                        fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontFamily: "Arial"),
                  ),
                ),
                SizedBox(
                  height: 0.7.h,
                ),
                SizedBox(
                  height: 6.7.h,
                  width: 100.w,
                  child: TextFormField(
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    textInputAction: TextInputAction.next,
                    controller: addAddressController.mobileController,
                    style: TextStyle(
                        fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontWeight: FontWeight.w500),
                    cursorColor: addAddressController.appColors.whiteColor,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        fillColor: addAddressController.appColors.textfieldBoxColor,
                        filled: true,
                        hintText: 'mobile_number'.tr,
                        hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 11.sp,
                            color: addAddressController.appColors.whiteColor.withOpacity(0.7)),
                        contentPadding: EdgeInsets.symmetric(vertical: 2.2.h, horizontal: 4.w),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                            borderRadius: BorderRadius.circular(5.sp)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                            borderRadius: BorderRadius.circular(5.sp)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.sp))),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.5.w),
                  child: Text(
                    'address'.tr,
                    style: TextStyle(
                        fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontFamily: "Arial"),
                  ),
                ),
                SizedBox(
                  height: 0.7.h,
                ),
                SizedBox(
                  height: 15.h,
                  width: 100.w,
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.sentences,
                    controller: addAddressController.addressController,
                    style: TextStyle(
                        fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontWeight: FontWeight.w500),
                    maxLines: 5,
                    cursorColor: addAddressController.appColors.whiteColor,
                    decoration: InputDecoration(
                        hintText: 'address'.tr,
                        hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 11.sp,
                            color: addAddressController.appColors.whiteColor.withOpacity(0.7)),
                        fillColor: addAddressController.appColors.textfieldBoxColor,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 2.2.h, horizontal: 4.w),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                            borderRadius: BorderRadius.circular(5.sp)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                            borderRadius: BorderRadius.circular(5.sp)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.sp))),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.5.w),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'pincode'.tr,
                            style: TextStyle(
                                fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontFamily: "Arial"),
                          ),
                          SizedBox(
                            height: 0.7.h,
                          ),
                          SizedBox(
                            height: 6.7.h,
                            width: 42.5.w,
                            child: TextFormField(
                              //maxLength: 10,
                              enabled: addAddressController.isPincodeEnable,
                              textInputAction: TextInputAction.search,
                              inputFormatters: [LengthLimitingTextInputFormatter(10)],
                              controller: addAddressController.pinCodeController,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: addAddressController.appColors.whiteColor,
                                  fontWeight: FontWeight.w500),
                              cursorColor: addAddressController.appColors.whiteColor,
                              keyboardType: Platform.isIOS
                                  ? const TextInputType.numberWithOptions(signed: true, decimal: true)
                                  : TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: 'pincode'.tr,
                                  hintStyle: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 11.sp,
                                      color: addAddressController.appColors.whiteColor.withOpacity(0.7)),
                                  fillColor: addAddressController.appColors.textfieldBoxColor,
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 2.2.h, horizontal: 4.w),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                                      borderRadius: BorderRadius.circular(5.sp)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                                      borderRadius: BorderRadius.circular(5.sp)),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.sp))),
                              onChanged: (value) {
                                // if (value.length == 6) {
                                //   addAddressController
                                //       .pinCodeData();
                                // }
                              },
                              onFieldSubmitted: (value) async {
                                final response = await addAddressController.pinCodeData(value);
                                if (response != null) {
                                  if (response.message.toString() == "No Delivery Available at this zipcode") {
                                    ApiClient.toAst("No Delivery Available at this zipcode");
                                    return;
                                  }
                                }
                                */
/*if (value.length == 6) {
                                  final response = await addAddressController.pinCodeData(value);
                                  if (response != null) {
                                    if (response.message.toString() == "No Delivery Available at this zipcode") {
                                      ApiClient.toAst("No Delivery Available at this zipcode");
                                      return;
                                    }
                                  }
                                }*/ /*

                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 2.4.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'city'.tr,
                            style: TextStyle(
                                fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontFamily: "Arial"),
                          ),
                          SizedBox(
                            height: 0.7.h,
                          ),
                          SizedBox(
                              height: 6.5.h,
                              width: 42.5.w,
                              child:
                                  // addAddressController.route.value == true
                                  //     ?
                                  Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: addAddressController.appColors.textfieldBoxColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: DropdownButton<String>(
                                    isExpanded: true,
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    dropdownColor: addAddressController.appColors.textfieldBoxColor,
                                    style: const TextStyle(color: Colors.white),
                                    icon: const Padding(
                                      padding: EdgeInsets.only(top: 8, right: 10, left: 10, bottom: 8),
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.white,
                                      ),
                                    ),
                                    underline: const SizedBox(),
                                    hint: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Obx(
                                        () => Text(
                                          addAddressController.city.value,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500, fontSize: 11.sp, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    items: controller.dropDownItem
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList(),
                                    onChanged: (v) {
                                      addAddressController.city.value = v!;
                                    }),
                              )

                              // : TextFormField(
                              //     textInputAction: TextInputAction.next,
                              //     textCapitalization: TextCapitalization.sentences,
                              //     controller: addAddressController.cityController,
                              //     style: TextStyle(
                              //         fontSize: 12.sp,
                              //         color: addAddressController.appColors.whiteColor,
                              //         fontWeight: FontWeight.w500),
                              //     cursorColor: addAddressController.appColors.whiteColor,
                              //     decoration: InputDecoration(
                              //         hintText: 'city'.tr,
                              //         hintStyle: TextStyle(
                              //             fontFamily: "Poppins",
                              //             fontSize: 11.sp,
                              //             color: addAddressController.appColors.whiteColor.withOpacity(0.7)),
                              //         fillColor: addAddressController.appColors.textfieldBoxColor,
                              //         filled: true,
                              //         contentPadding: EdgeInsets.symmetric(vertical: 2.2.h, horizontal: 4.w),
                              //         focusedBorder: OutlineInputBorder(
                              //             borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                              //             borderRadius: BorderRadius.circular(5.sp)),
                              //         enabledBorder: OutlineInputBorder(
                              //             borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                              //             borderRadius: BorderRadius.circular(5.sp)),
                              //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.sp))),
                              //     onChanged: (value) {},
                              //   ),
                              ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.5.w),
                  child: Text(
                    'state'.tr,
                    style: TextStyle(
                        fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontFamily: "Arial"),
                  ),
                ),
                SizedBox(
                  height: 0.7.h,
                ),
                SizedBox(
                  height: 6.7.h,
                  width: 100.w,
                  child: TextFormField(
                    enabled: false,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.sentences,
                    controller: addAddressController.stateController,
                    style: TextStyle(
                        fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontWeight: FontWeight.w500),
                    cursorColor: addAddressController.appColors.whiteColor,
                    decoration: InputDecoration(
                        hintText: 'state'.tr,
                        hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 11.sp,
                            color: addAddressController.appColors.whiteColor.withOpacity(0.7)),
                        fillColor: addAddressController.appColors.textfieldBoxColor,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 2.2.h, horizontal: 4.w),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                            borderRadius: BorderRadius.circular(5.sp)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                            borderRadius: BorderRadius.circular(5.sp)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.sp))),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.5.w),
                  child: Text(
                    'Country'.tr,
                    style: TextStyle(
                        fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontFamily: "Arial"),
                  ),
                ),
                SizedBox(
                  height: 0.7.h,
                ),
                SizedBox(
                  height: 6.7.h,
                  width: 100.w,
                  child: TextFormField(
                    enabled: false,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.sentences,
                    controller: addAddressController.countryController,
                    style: TextStyle(
                        fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontWeight: FontWeight.w500),
                    //controller: verificationScreenController.verifi6controller,
                    cursorColor: addAddressController.appColors.whiteColor,
                    decoration: InputDecoration(
                        hintText: 'Country'.tr,
                        hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 11.sp,
                            color: addAddressController.appColors.whiteColor.withOpacity(0.7)),
                        fillColor: addAddressController.appColors.textfieldBoxColor,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 2.2.h, horizontal: 4.w),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                            borderRadius: BorderRadius.circular(5.sp)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                            borderRadius: BorderRadius.circular(5.sp)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.sp))),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.5.w),
                  child: Text(
                    'email'.tr,
                    style: TextStyle(
                        fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontFamily: "Arial"),
                  ),
                ),
                SizedBox(
                  height: 0.7.h,
                ),
                SizedBox(
                  height: 6.7.h,
                  width: 100.w,
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.emailAddress,
                    controller: addAddressController.emailController,
                    style: TextStyle(
                        fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontWeight: FontWeight.w500),
                    cursorColor: addAddressController.appColors.whiteColor,
                    decoration: InputDecoration(
                        hintText: 'email'.tr,
                        hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 11.sp,
                            color: addAddressController.appColors.whiteColor.withOpacity(0.7)),
                        fillColor: addAddressController.appColors.textfieldBoxColor,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 2.2.h, horizontal: 4.w),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                            borderRadius: BorderRadius.circular(5.sp)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: addAddressController.appColors.blackColor),
                            borderRadius: BorderRadius.circular(5.sp)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.sp))),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.5.w),
                  child: Text(
                    'save_as_address'.tr,
                    style: TextStyle(
                        fontSize: 12.sp, color: addAddressController.appColors.whiteColor, fontFamily: "Arial"),
                  ),
                ),
                SizedBox(
                  height: 0.7.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.5.w),
                  child: Row(
                    children: [
                      addAddressController.customRadioButton("home".tr, 1),
                      SizedBox(
                        width: 3.w,
                      ),
                      addAddressController.customRadioButton("work".tr, 2),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.2.h,
                ),
                isShipping
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: EdgeInsets.only(left: 0.5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            addAddressController.saveAddressScreenController.defaultAddress.value.isDefault == null
                                ? Container(
                                    width: 2.2.h,
                                    height: 2.2.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4.sp),
                                        border: Border.all(
                                          color: addAddressController.appColors.darkYellowColor,
                                          width: 0.3.w,
                                        ),
                                        color: addAddressController.appColors.darkYellowColor),
                                    child: Icon(
                                      Icons.check_outlined,
                                      color: addAddressController.appColors.blackColor,
                                      size: 12.sp,
                                    ))
                                : GestureDetector(
                                    onTap: addAddressController.toggleCheckbox,
                                    child: Container(
                                      width: 2.2.h,
                                      height: 2.2.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4.sp),
                                        border: Border.all(
                                          color: addAddressController.appColors.darkYellowColor,
                                          width: 0.3.w,
                                        ),
                                        color: addAddressController.isDefaultAddress.value
                                            ? addAddressController.appColors.darkYellowColor
                                            : Colors.transparent,
                                      ),
                                      child: addAddressController.isDefaultAddress.value
                                          ? Icon(
                                              Icons.check_outlined,
                                              color: addAddressController.appColors.blackColor,
                                              size: 12.sp,
                                            )
                                          : null,
                                    ),
                                  ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              'make_this_my_defult_addres'.tr,
                              style: TextStyle(
                                color: addAddressController.appColors.whiteColor,
                                fontFamily: "Arial",
                              ),
                            ),
                          ],
                        ),
                      ),
                SizedBox(
                  height: 2.h,
                ),
                isShipping == false
                    ? const SizedBox.shrink()
                    : SizedBox(
                        width: 90.w,
                        height: 6.7.h,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: addAddressController.appColors.lightgreenColor,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.sp))),
                            onPressed: () {

                              addAddressController.setShippingData(
                                  name: addShippingAddressController.nameController.text,
                                  address: addShippingAddressController.addressController.text,
                                  pinCode: addShippingAddressController.pincodeController.text,
                                  state: addShippingAddressController.stateController.text,
                                  city: addShippingAddressController.city.value,
                                  country: addShippingAddressController.countryController.text,
                                  addressType: addShippingAddressController.value == 1 ? "Home" : "Work",
                                  number: addShippingAddressController.mobileController.text,
                                  email: addShippingAddressController.emailController.text);
                              Get.back();
                              print("Shipping pin code ${addShippingAddressController.pincodeController.text}");
                            },
                            child: Center(
                              child: Text(
                                "Add Shipping Address",
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: addAddressController.appColors.whiteColor,
                                    fontFamily: "Arial",
                                    fontWeight: FontWeight.w700),
                              ),
                            )),
                      ),
                SizedBox(
                  height: 2.h,
                ),
                isShipping
                    ? const SizedBox.shrink()
                    : Obx(() => addAddressController.isLoading.isTrue
                        ? Center(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: addAddressController.appColors.darkYellowColor,
                              ),
                            ),
                          )
                        : Center(
                            child: SizedBox(
                              width: 90.w,
                              height: 6.7.h,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: addAddressController.appColors.lightgreenColor,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.sp))),
                                  onPressed: () async {
                                    FocusManager.instance.primaryFocus!.unfocus();

                                    print(addMainAddressController.nameController.text);
                                    if (addAddressController.saveAddressScreenController.isEditing.value) {
                                      if (validations()) {
                                        addAddressController.updateAddress();
                                      }
                                    } else {
                                      if (validations()) {
                                        print("Pin code: ${addAddressController.pincodeController.text}");
                                        addAddressController.addAddressData();
                                      }
                                    }
                                  },
                                  child: Center(
                                    child: Text(
                                      addAddressController.saveAddressScreenController.isEditing.value
                                          ? 'update_address'.tr
                                          : 'add_address'.tr,
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          color: addAddressController.appColors.whiteColor,
                                          fontFamily: "Arial",
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )),
                            ),
                          )),
                SizedBox(
                  height: 3.h,
                )
              ],
            ));
      },
    );
  }

  validations() {
    if (addAddressController.nameController.text.trim().isEmpty) {
      ApiClient.toAst('Please enter your name');

      return false;
    } else if (addAddressController.mobileController.text.trim().isEmpty) {
      ApiClient.toAst('Please enter your mobile number');

      return false;
    } else if (addAddressController.mobileController.text.trim().length < 8) {
      ApiClient.toAst('Phone number can not be less than 8 digits');

      return false;
    } else if (addAddressController.mobileController.text.trim().length > 15) {
      ApiClient.toAst('Phone number can not be more than 15 digits');

      return false;
    } else if (addAddressController.addressController.text.trim().isEmpty) {
      ApiClient.toAst('Please enter your address');

      return false;
    } else if (addAddressController.pinCodeController.text.trim().isEmpty) {
      ApiClient.toAst('Please enter your pin code');

      return false;
    } else if (addAddressController.city.value.trim().isEmpty) {
      ApiClient.toAst('Please enter your city');

      return false;
    }
    // else if (addAddressController.route.value == true
    //     ? addAddressController.city.value.trim().isEmpty
    //     : addAddressController.cityController.text.trim().isEmpty) {
    //   ApiClient.toAst('Please enter your city');
    //
    //   return false;
    // }
    else if (addAddressController.stateController.text.trim().isEmpty) {
      ApiClient.toAst('Please enter your state');

      return false;
    } else if (addAddressController.countryController.text.trim().isEmpty) {
      ApiClient.toAst('Please enter your country');

      return false;
    } else if (addAddressController.emailController.text.trim().isEmpty) {
      ApiClient.toAst('Please enter your email');

      return false;
    } else if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(addAddressController.emailController.text.trim()) ==
        false) {
      ApiClient.toAst('Please enter valid email');

      return false;
    } else if (addAddressController.saveAddressScreenController.defaultAddress.value.addressType == null ||
        addAddressController.saveAddressScreenController.defaultAddress.value.addressType.toString().isEmpty) {
      ApiClient.toAst('Please select address type');

      return false;
    }
    */
/* else if (addAddressController.isDefaultAddress.value==false) {
      ApiClient.toAst('Please select make this default address');

      return false;
    } */ /*

    else {
      return true;
    }
  }
}
*/
