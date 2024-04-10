import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:akalsahae/app/apiCollection/api_client.dart';
import 'package:akalsahae/app/modules/fullvoile_turban_screen_module/fullvoile_turban_screen_controller.dart';
import 'package:akalsahae/app/modules/save_address_screen_module/save_address_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:phone_pe_pg/phone_pe_pg.dart';
import 'package:sizer/sizer.dart';
import '../../routes/app_pages.dart';
import '../../utils/shared_preferences_helper.dart';
import '../../utils/shared_prefs_keys.dart';
import '../save_address_screen_module/get_address_api_modal.dart';
import 'Get_Add_To_Cart_api_modal.dart';
import 'check_out_screen_controller.dart';

class CheckOutScreenPage extends StatefulWidget {
  const CheckOutScreenPage({super.key});

  @override
  State<CheckOutScreenPage> createState() => _CheckOutScreenPageState();
}

class _CheckOutScreenPageState extends State<CheckOutScreenPage> {
  final checkOutScreenController = Get.find<CheckOutScreenController>();
  FullvoileTurbanScreenController fullvoileTurbanScreenController = Get.find<FullvoileTurbanScreenController>();
  final addressController = Get.find<SaveAddressScreenController>();
  CardEditController cardEditController = CardEditController();

  bool isLoading = false;
  bool failed = false;
  Map<dynamic, dynamic> data = {};
  bool apiCall = false;
  bool isPayment = false;
  bool isDeleteItem = false;
  StateSetter? toastState;
  var cardInfo = {};

  @override
  void initState() {
    checkOutScreenController.isTapped.value = false;
    checkOutScreenController.getCart();
    checkOutScreenController.update();
    checkOutScreenController.pincodeController.clear();
    super.initState();
  }

  PhonePePg phonePePg = PhonePePg(
      isUAT: true,
      saltKey: "099eb0cd-02cf-4e2a-8aca-3e6c6aff0399",
      saltIndex: "1",
      prodUrl: "https://api.phonepe.com/apis/hermes");

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          toolbarHeight: 0.h,
          bottom: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            title: Text('My Cart'.tr, style: TextStyle(fontSize: 14.sp, fontFamily: "Poppins")),
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
            await checkOutScreenController.getCart();
          },
          child: checkOutScreenController.isLoading.isTrue
              ? Center(
                  child: CircularProgressIndicator(
                    color: checkOutScreenController.appColors.darkYellowColor,
                  ),
                )
              : checkOutScreenController.getAddToCartApiModal.value.data == null ||
                      checkOutScreenController.getAddToCartApiModal.value.data!.isEmpty
                  ? SizedBox(
                      height: Get.height * .7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                              child: Image.asset(
                            "assets/images/shopping-bag.png",
                            height: 150,
                            width: 150,
                          )),
                          SizedBox(
                            height: 1.h,
                          ),
                          Center(
                            child: Text("Your cart is empty",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.sp,
                                    fontFamily: "Poppins",
                                    color: Colors.white)),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.offAllNamed(Routes.BOTTOM_SCREEN);
                            },
                            child: Text("Let's add something in your cart",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13.sp,
                                    fontFamily: "Poppins",
                                    color: checkOutScreenController.appColors.darkYellowColor)),
                          )
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.8.w, vertical: 1.h),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Obx(
                            () => Container(
                              //height: 7.h,
                              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.sp),
                                  color: checkOutScreenController.appColors.textfieldBoxColor),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                        child: checkOutScreenController
                                                    .saveAddressScreenController.defaultAddress.value.address !=
                                                null
                                            ? Obx(
                                                () => Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Deliver to: ',
                                                          style: TextStyle(
                                                              fontSize: 10.sp,
                                                              fontFamily: "Kaint",
                                                              color: checkOutScreenController.appColors.whiteColor,
                                                              fontWeight: FontWeight.w500),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            addressController.defaultAddress.value.name.toString(),
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 11.sp,
                                                                fontFamily: "Kaint",
                                                                color: checkOutScreenController.appColors.whiteColor,
                                                                fontWeight: FontWeight.w700),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      addressController.defaultAddress.value.address.toString(),
                                                      maxLines: 3,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 11.sp,
                                                          fontFamily: "Kaint",
                                                          color: checkOutScreenController.appColors.whiteColor,
                                                          fontWeight: FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Text(
                                                checkOutScreenController.address.value.isNotEmpty
                                                    ? checkOutScreenController.address.value
                                                    : 'check_delivery_time_&_services'.tr,
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontFamily: "Kaint",
                                                    color: checkOutScreenController.appColors.whiteColor,
                                                    fontWeight: FontWeight.w500))),
                                  ),
                                  GestureDetector(
                                    onTap: checkOutScreenController
                                                .saveAddressScreenController.defaultAddress.value.address !=
                                            null
                                        ? () {
                                            Get.toNamed(Routes.SAVE_ADDRESS_SCREEN,
                                                    arguments: {"fromCheckScreen": true})!
                                                .then((value) {
                                              setState(() {});
                                            });
                                          }
                                        : () {},
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 45,
                                        width: 28.w,
                                        padding: const EdgeInsets.only(left: 5, right: 5),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(3.sp),
                                            color: checkOutScreenController.appColors.blackColor),
                                        child: Center(
                                          child: checkOutScreenController
                                                      .saveAddressScreenController.defaultAddress.value.address !=
                                                  null
                                              ? Text(
                                                  'change_address'.tr,
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Kaint",
                                                    color: checkOutScreenController.appColors.whiteColor,
                                                  ),
                                                )
                                              : TextFormField(
                                            cursorColor: checkOutScreenController.appColors.darkYellowColor,
                                                  onFieldSubmitted: (value) async {
                                                    final response = await checkOutScreenController.pinCodeData();
                                                    if (response != null) {
                                                      if (response.message.toString() ==
                                                          "No Delivery Available at this zipcode") {
                                                        ApiClient.toAst("No Delivery Available at this zipcode");
                                                        return;
                                                      }
                                                      Get.toNamed(Routes.ADD_ADDRESS_SCREEN, parameters: {
                                                        'isEnabled': 'false',
                                                        'checkOut': '1',
                                                        'pincode': checkOutScreenController.pincodeController.text,
                                                        'state': response.data!.state ?? '',
                                                        'country': response.data!.country ?? '',
                                                        'city': jsonEncode(response.data!.city ?? "")
                                                      })?.then(
                                                        (value) {
                                                          if (value != null) {
                                                            checkOutScreenController.saveAddressScreenController
                                                                .defaultAddress.value = AddressData(
                                                              address: value["address"],
                                                              name: value["name"],
                                                              id: value["id"],
                                                            );
                                                          }
                                                        },
                                                      );
                                                    }
                                                  },
                                                  controller: checkOutScreenController.pincodeController,
                                                  keyboardType:
                                                      const TextInputType.numberWithOptions(signed: true, decimal: true),
                                                  // textInputAction:
                                                  //     TextInputAction.done,
                                                  onChanged: (value) async {},
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(10),
                                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                  ],
                                                  style: const TextStyle(color: Colors.white, fontSize: 15),
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: "ENTER PIN CODE",
                                                      contentPadding: const EdgeInsets.only(bottom: 3),
                                                      hintStyle: TextStyle(
                                                          fontSize: 12,
                                                          color: checkOutScreenController.appColors.whiteColor)),
                                                ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.5.h,
                          ),
                          Obx(
                            () => ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: checkOutScreenController.getAddToCartApiModal.value.data!.length,
                                itemBuilder: (context, int index) {
                                  AddData data = checkOutScreenController.getAddToCartApiModal.value.data![index];
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 10.sp),
                                    child: Container(
                                      //height: 18.h,
                                      width: 86.4.w,

                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(3.sp),
                                          color: checkOutScreenController.appColors.textfieldBoxColor),
                                      child: Row(children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 3.w, top: 7, bottom: 7),
                                          child: Container(
                                            clipBehavior: Clip.hardEdge,
                                            height: 13.h,
                                            width: 26.w,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4.sp),
                                              color: checkOutScreenController.appColors.blackColor,
                                            ),
                                            child: checkOutScreenController
                                                            .getAddToCartApiModal.value.data![index].productImage ==
                                                        null ||
                                                    checkOutScreenController
                                                        .getAddToCartApiModal.value.data![index].productImage!.isEmpty
                                                ? checkOutScreenController
                                                            .getAddToCartApiModal.value.data![index].variationId !=
                                                        null
                                                    ? Image.asset("assets/images/placeholder.jpg")
                                                    : Image.asset("assets/images/placeholder.jpg")
                                                : FadeInImage.assetNetwork(
                                                    imageErrorBuilder: (context, error, stackTrace) {
                                                      return Image.asset(
                                                        "assets/images/placeholder.jpg",
                                                        fit: BoxFit.cover,
                                                      );
                                                    },
                                                    placeholder: "assets/images/placeholder.jpg",
                                                    placeholderFit: BoxFit.cover,
                                                    image: checkOutScreenController
                                                        .getAddToCartApiModal.value.data![index].productImage!.first.url
                                                        .toString(),
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 2.8.h),
                                          child: SizedBox(
                                            width: 48.w,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  checkOutScreenController
                                                          .getAddToCartApiModal.value.data![index].productName
                                                          .toString() ??
                                                      "",
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "Poppins",
                                                      color: checkOutScreenController.appColors.whiteColor),
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                if (data.variations != null)
                                                  ListView.separated(
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: data.variations!.length,
                                                    itemBuilder: (ctx, index) {
                                                      Variations variation = data.variations![index];
                                                      return Row(
                                                        children: [
                                                          Text(
                                                            "${variation.key.toString()}: ",
                                                            style: TextStyle(
                                                                fontSize: 9.5.sp,
                                                                fontWeight: FontWeight.w500,
                                                                fontFamily: "Arial",
                                                                color: checkOutScreenController.appColors.checkColor),
                                                          ),
                                                          Text(
                                                            variation.data.toString(),
                                                            style: TextStyle(
                                                                fontSize: 9.5.sp,
                                                                fontWeight: FontWeight.w700,
                                                                fontFamily: "Arial",
                                                                color: checkOutScreenController.appColors.whiteColor),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                    separatorBuilder: (ctx, index) => const SizedBox(
                                                      height: 5,
                                                    ),
                                                  ),
                                                // SizedBox(
                                                //   height: 0.7.h,
                                                // ),
                                                // checkOutScreenController
                                                //             .getAddToCartApiModal.value.data![index].variationId !=
                                                //         null
                                                //     ? Row(
                                                //         children: [
                                                //           Text(
                                                //             'double_(center stitch)'.tr,
                                                //             style: TextStyle(
                                                //                 fontSize: 9.5.sp,
                                                //                 fontWeight: FontWeight.w500,
                                                //                 fontFamily: "Arial",
                                                //                 color: checkOutScreenController.appColors.checkColor),
                                                //           ),
                                                //           // Text(
                                                //           //   checkOutScreenController
                                                //           //               .getAddToCartApiModal
                                                //           //               .value
                                                //           //               .data![
                                                //           //                   index]
                                                //           //               .centerStitch ==
                                                //           //           1
                                                //           //       ? 'Yes'
                                                //           //       : 'No',
                                                //           //   style: TextStyle(
                                                //           //       fontSize: 9.5.sp,
                                                //           //       fontWeight: FontWeight.w700,
                                                //           //       fontFamily: "Arial",
                                                //           //       color: checkOutScreenController.appColors.whiteColor),
                                                //           // ),
                                                //         ],
                                                //       )
                                                //     : SizedBox(),
                                                SizedBox(
                                                  height: 0.7.h,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'price'.tr,
                                                      style: TextStyle(
                                                          fontSize: 9.5.sp,
                                                          fontWeight: FontWeight.w500,
                                                          fontFamily: "Arial",
                                                          color: checkOutScreenController.appColors.checkColor),
                                                    ),
                                                    Text(
                                                      "₹ ${checkOutScreenController.getAddToCartApiModal.value.data![index].totalPrice.toString()}",
                                                      style: TextStyle(
                                                          fontSize: 9.5.sp,
                                                          fontWeight: FontWeight.w700,
                                                          fontFamily: "Arial",
                                                          color: checkOutScreenController.appColors.whiteColor),
                                                    ),
                                                    // checkOutScreenController
                                                    //             .getAddToCartApiModal
                                                    //             .value
                                                    //             .data![index]
                                                    //             .centerStitch ==
                                                    //         1
                                                    //
                                                    //     ? Text(
                                                    //         "₹ ${(double.parse(checkOutScreenController.getAddToCartApiModal.value.data![index].totalPrice.toString().replaceFirst(",", ""))) + (double.parse(30.toString()))}",
                                                    //         style: TextStyle(
                                                    //             fontSize: 9.5.sp,
                                                    //             fontWeight: FontWeight.w700,
                                                    //             fontFamily: "Arial",
                                                    //             color: checkOutScreenController.appColors.whiteColor),
                                                    //       )
                                                    //     : Text(
                                                    //         "₹ ${checkOutScreenController.getAddToCartApiModal.value.data![index].totalPrice}" ??
                                                    //             "",
                                                    //         style: TextStyle(
                                                    //             fontSize: 9.5.sp,
                                                    //             fontWeight: FontWeight.w700,
                                                    //             fontFamily: "Arial",
                                                    //             color: checkOutScreenController.appColors.whiteColor),
                                                    //       ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 0.7.h,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            checkOutScreenController.showAlertDialog(
                                                context,
                                                checkOutScreenController.getAddToCartApiModal.value.data![index].cartId!
                                                    .toInt(),
                                                index: index);

                                            //   checkOutScreenController.removeCartApi(checkOutScreenController
                                            //     .getAddToCartApiModal.value.data![index].cartId!
                                            // .toInt());
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(bottom: 10.h),
                                            child: Container(
                                              height: 20,
                                              width: 15,
                                              child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Image.asset(
                                                    "assets/images/crossIcon.png",
                                                    width: 3.w,
                                                    color: checkOutScreenController.appColors.crossColor,
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  );
                                  /*  return (checkOutScreenController.getAddToCartApiModal.value.data![index].productId!=null)
                                        ? turbanProduct(
                                            index, checkOutScreenController.getAddToCartApiModal.value.data![index])
                                        : accessoryProduct(
                                            index, checkOutScreenController.getAddToCartApiModal.value.data![index]);*/
                                }),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Row(
                            children: [
                              Text(
                                'price_details'.tr,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Kaint",
                                    color: checkOutScreenController.appColors.whiteColor),
                              ),
                              Text(
                                "(${checkOutScreenController.getAddToCartApiModal.value.data!.length.toString()} Items)",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Kaint",
                                    color: checkOutScreenController.appColors.whiteColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'total_mrp'.tr,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Kaint",
                                    color: checkOutScreenController.appColors.whiteColor),
                              ),
                              Text(
                                "₹${checkOutScreenController.getAddToCartApiModal.value.totalMrp.toString()}",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Kaint",
                                    color: checkOutScreenController.appColors.whiteColor),
                              ),
                            ],
                          ),
                          checkOutScreenController.getAddToCartApiModal.value.addOnPrice.toString() == "0"
                              ? const SizedBox.shrink()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Add On",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Kaint",
                                          color: checkOutScreenController.appColors.whiteColor),
                                    ),
                                    Text(
                                      "₹${checkOutScreenController.getAddToCartApiModal.value.addOnPrice.toString()}",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Kaint",
                                          color: checkOutScreenController.appColors.whiteColor),
                                    ),
                                  ],
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'discount_on_mrp'.tr,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Kaint",
                                    color: checkOutScreenController.appColors.whiteColor),
                              ),
                              Text(
                                "₹${checkOutScreenController.getAddToCartApiModal.value.totalDiscountOnMrp.toString()}",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Kaint",
                                    color: checkOutScreenController.appColors.whiteColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          Divider(
                            color: checkOutScreenController.appColors.whiteColor,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'total_amount'.tr,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Kaint",
                                    color: checkOutScreenController.appColors.whiteColor),
                              ),
                              Text(
                                "₹${checkOutScreenController.getAddToCartApiModal.value.totalAmount.toString()}",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Kaint",
                                    color: checkOutScreenController.appColors.whiteColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4.5.h,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  if (checkOutScreenController
                                          .saveAddressScreenController.defaultAddress.value.address !=
                                      null) {
                                    showOptionDialog();
                                  } else if (checkOutScreenController.pincodeController.text.isEmpty) {
                                    ApiClient.toAst("Please enter your pin code");
                                  } else {
                                    ApiClient.toAst("No Delivery Available at this zipcode");
                                  }

                                  ///Payment Work done Here============>

                                  /*if (checkOutScreenController.isTapped.isFalse) {
                                      checkOutScreenController.isTapped.value = true;
                                    } else if (checkOutScreenController.isTapped.isTrue) {
                                      if (checkOutScreenController
                                              .saveAddressScreenController.defaultAddress.value.address !=
                                          null) {
                                        showOptionDialog();
                                        // Get.to(StripePaymentScreen(
                                        //   id: checkOutScreenController
                                        //       .saveAddressScreenController.defaultAddress.value.id,
                                        //   name: addressController.defaultAddress.value.name.toString(),
                                        //   address: addressController.defaultAddress.value.address.toString(),
                                        // ));
                                      } else {
                                        ApiClient.toAst("Please enter your pin code");
                                      }
                                    }*/
                                },
                                child: Container(
                                  height: 6.5.h,
                                  width: 86.4.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3.sp),
                                      color: checkOutScreenController.appColors.lightgreenColor),
                                  child: Center(
                                    child: Text(
                                      "Proceed To Pay",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w700,
                                          color: checkOutScreenController.appColors.whiteColor,
                                          fontFamily: "Arial"),
                                    ),
                                    /*   Obx(
                                      () => Text(
                                        checkOutScreenController.isTapped.isTrue ? "Proceed To Pay" : "Place Order",
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w700,
                                            color: checkOutScreenController.appColors.whiteColor,
                                            fontFamily: "Arial"),
                                      ),
                                    )*/
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }

  PaymentRequest paymentRequest = PaymentRequest(
      amount: 100,
      redirectUrl: "https://nexever.tech/akalSahae/phonepe-redirect",
      callbackUrl: 'https://nexever.tech/akalSahae/phonepe-redirect',
      merchantId: 'PGTESTPAYUAT',
      merchantTransactionId: _randomString(6),
      merchantUserId: '122324343',
      mobileNumber: '8219333272',
      //Payment Instrument for UPI Intent
      paymentInstrument: UpiIntentPaymentInstrument(
        targetApp: Platform.isAndroid ? "com.phonepe.app" : "PHONEPE",
        //Input is the package name of the UPI App you want to use for  payment from for Android and iOS App Name of the app you want to use for payment for iOS
      ));

  Future<void> _proceedToPay() async {
    final result = await phonePePg.startUpiTransaction(paymentRequest: paymentRequest);
    print(result);
  }

  showOptionDialog() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setToastState) {
            toastState = setToastState;
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .25,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Payment",
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CardField(
                          style: TextStyle(color: checkOutScreenController.appColors.blackColor),
                          controller: cardEditController,
                          decoration: const InputDecoration(
                            fillColor: Colors.black12,
                            filled: true,
                            iconColor: Colors.white,
                          ),
                          cursorColor: checkOutScreenController.appColors.blackColor,
                          onCardChanged: (card) {
                            cardInfo = {
                              "number": card!.last4,
                              "valid_date": card!.validExpiryDate == CardValidationState.Valid,
                              "month": card!.expiryMonth,
                              "year": card!.expiryYear,
                              'cvv': card!.validCVC != CardValidationState.Incomplete
                            };
                            setToastState(() {});
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        (isPayment == false)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      child: GestureDetector(
                                        onTap: () {
                                          //cardEditController.dispose();
                                          Get.back();
                                          setToastState(() {});
                                        },
                                        child: Container(
                                          height: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.grey,
                                          ),
                                          padding: const EdgeInsets.only(left: 10, right: 10),
                                          child: const Text(
                                            "CANCEL",
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin: const EdgeInsets.only(right: 8),
                                        child: GestureDetector(
                                            onTap: () async {
                                              FocusManager.instance.primaryFocus?.unfocus();
                                              setToastState(() {
                                                apiCall = true;
                                                isDeleteItem = true;
                                                isPayment = !isPayment;
                                              });
                                              var val = await createPaymentIntent(
                                                // amount: "100",
                                                amount: checkOutScreenController.getAddToCartApiModal.value.totalAmount
                                                    .toString()
                                                    .replaceFirst(",", ""),
                                                currency: "INR",
                                              );
                                              if (val == 'success' && cardEditController.details.complete == true) {
                                                await confirmPayment();
                                              } else {
                                                setToastState(() {
                                                  failed = true;
                                                  apiCall = false;
                                                  isPayment = false;
                                                  //ApiClient.toAst("Please Enter Card Details");
                                                  checkOutScreenController.isLoading.value = false;
                                                  if (cardInfo["number"] == null ||
                                                      cardEditController.details.validNumber !=
                                                          CardValidationState.Valid) {
                                                    ApiClient.toAst("Please enter your Card Number");
                                                  } else if (cardInfo['month'] == null) {
                                                    ApiClient.toAst("Please enter Card Expiry Month");
                                                  } else if (cardInfo['year'] == null) {
                                                    ApiClient.toAst("Please enter Card Expiry Year");
                                                  } else if (cardInfo["valid_date"] == false) {
                                                    ApiClient.toAst("Please enter valid Expiry Date");
                                                  } else if (cardInfo['cvv'] == false) {
                                                    ApiClient.toAst("Please enter valid CVC");
                                                  }
                                                });
                                              }
                                            },
                                            child: Container(
                                                height: 40,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: checkOutScreenController.appColors.darkYellowColor,
                                                ),
                                                padding: const EdgeInsets.only(left: 10, right: 10),
                                                child: const Text(
                                                  "PAY NOW",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.white,
                                                      fontFamily: "Poppins",
                                                      fontWeight: FontWeight.w700),
                                                ))),
                                      )),
                                ],
                              )
                            : CircularProgressIndicator(
                                color: checkOutScreenController.appColors.darkYellowColor,
                              ),
                        const SizedBox(
                          height: 15,
                        ),
                        Image.asset(
                          'assets/images/stripe.jpg',
                          width: MediaQuery.of(context).size.width,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

  Map<String, dynamic>? paymentIntent = {};

  /// confirm payment

  confirmPayment() async {
    try {
      var paymentConfirmation = await Stripe.instance
          .confirmPayment(
        data: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(name: addressController.defaultAddress.value.name.toString()),
          ),
        ),
        paymentIntentClientSecret: paymentIntent!['client_secret'].toString(),
      )
          .onError((error, stackTrace) {
        checkOutScreenController.isLoading.value = false;
        if (cardInfo["number"] == null || cardEditController.details.validNumber != CardValidationState.Valid) {
          return ApiClient.toAst("Please Enter Your Card Number");
        } else if (cardInfo['month'] == null) {
          return ApiClient.toAst("Please Enter Card Expiry Month");
        } else if (cardInfo['year'] == null) {
          return ApiClient.toAst("Please Enter Card Expiry Year");
        } else if (cardInfo["valid_date"] == false) {
          return ApiClient.toAst("Please Enter Valid Expiry Date");
        } else if (cardInfo['cvv'] == false) {
          return ApiClient.toAst("Please Enter Valid CVC");
        }

        return ApiClient.toAst("Please Enter Card Details");
      });

      if (paymentConfirmation.status == PaymentIntentsStatus.Succeeded) {
        checkOutScreenController.isLoading.value = false;
        ApiClient.toAst("Order Placed Successfully");
        Get.back();
        // checkOutScreenController
        //     .placeOrderData(checkOutScreenController.saveAddressScreenController.defaultAddress.value.id);
        checkOutScreenController.placeOrderData(
            id: checkOutScreenController.saveAddressScreenController.defaultAddress.value.id.toString(),
            transId: paymentConfirmation.id.toString() ?? "",
            payId: paymentConfirmation.paymentMethodId ?? "");

        String purchaseId = paymentConfirmation.id;
        print("Purchase Id: $purchaseId");

        String paymentMethodId = paymentConfirmation.paymentMethodId ?? "";
        print("Payment Method Id: $paymentMethodId");
      } else {
        checkOutScreenController.isLoading.value = false;
      }
    } catch (e, st) {
      checkOutScreenController.isLoading.value = false;
      setState(() {
        isLoading = false;
        failed = true;
      });
      debugPrint("Confirm Payment $e");
      debugPrint("Confirm Payment $st");
    }
  }

  dynamic result;

  /// initialize stripe card payment
  createPaymentIntent({required String amount, required String currency}) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    try {
      // checkOutScreenController.isLoading.value = true;

      /// Request body
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'confirm': "true",
        "confirmation_method": "automatic",
        // "automatic_payment_methods[enabled]"=true
      };
      print("${{
        'amount': amount,
        'currency': currency,
      }}");

      /// Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://nexever.tech/AkalSahae_New/api/get-payment-intent'),
        headers: {
          'Authorization': "Bearer $token",
          //'Authorization':
          // "Bearer sk_test_51HOfZgCV09H7ndi3Lq96mym5emttHJGWX7SUFjLEAU5cQUfPKKPh191dkmySMfgsWYEXdwmD3JQEq90cYMWSywPS00EbBrzT3h",
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      if (response.statusCode == 200) {
        result = 'success';
        paymentIntent = json.decode(response.body);
        debugPrint(response.body);
        // checkOutScreenController.isLoading.value = false;
      } else {
        debugPrint(response.body);
        result = 'failure';
        setState(() {
          apiCall = false;
        });
      }
      // checkOutScreenController.isLoading.value = false;
    } catch (err, st) {
      if (err is SocketException) {
        // checkOutScreenController.isLoading.value = false;
        result = 'no internet';
      }
      print("ERROR: $err");
      print("STACK: $st");
    }
    return result;
  }
}

String _randomString(int length) {
  var rand = Random();
  var codeUnits = List.generate(length, (index) {
    return rand.nextInt(33) + 89;
  });

  return String.fromCharCodes(codeUnits);
}
