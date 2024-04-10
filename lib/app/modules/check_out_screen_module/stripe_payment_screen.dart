import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:akalsahae/app/modules/check_out_screen_module/check_out_screen_controller.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../../apiCollection/api_client.dart';
import '../../utils/shared_preferences_helper.dart';
import '../../utils/shared_prefs_keys.dart';

class StripePaymentScreen extends StatefulWidget {
  final int? id;

  const StripePaymentScreen({super.key, this.id});

  @override
  State<StripePaymentScreen> createState() => _StripePaymentScreenState();
}

class _StripePaymentScreenState extends State<StripePaymentScreen> {
  final checkOutScreenController = Get.put(CheckOutScreenController());
  CardEditController cardEditController = CardEditController();

  bool isLoading = false;
  bool failed = false;
  Map<dynamic, dynamic> data = {};
  bool apiCall = false;
  bool isPayment = false;
  StateSetter? toastState;
  bool isDeleteItem = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 3.h,
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          bottom: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            titleSpacing: 0.5.sp,
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 12.sp,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            title: Text(("Stripe Payment").tr,
                style: TextStyle(fontSize: 14.sp, fontFamily: "Poppins")),
          ),
        ),
        body: Stack(
          children: [
            Container(
              color: Colors.black,
              height: MediaQuery.of(context).size.height,
              width: Get.width,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Spacer(),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      width: double.infinity,
                      height: 60,
                      margin: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.sp),
                        color: checkOutScreenController.appColors.whiteColor,
                      ),
                      child: CardField(
                        controller: cardEditController,
                        style: TextStyle(
                            color:
                                checkOutScreenController.appColors.whiteColor),
                        //numberHintText: "Enter your card details",
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.grey,
                          filled: true,
                          iconColor: Colors.white,
                        ),
                        cursorColor:
                            checkOutScreenController.appColors.darkYellowColor,
                        onCardChanged: (card) {
                          setState(() {});
                        },
                      ),
                    ),
                    const Spacer(),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 24),
                      child: SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: Visibility(
                          child: GestureDetector(
                            onTap: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              setState(() {
                                apiCall = true;
                              });
                              var val = await createPaymentIntent(
                                //amount: "100",
                                amount: checkOutScreenController
                                    .getAddToCartApiModal.value.totalAmount
                                    .toString()
                                    .replaceFirst(",", ""),
                                currency: "USD",
                              );
                              if (val == 'success') {
                                await confirmPayment();
                              } else {
                                setState(() {
                                  failed = true;
                                  apiCall = false;
                                });
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 6.h,
                              width: 43.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.sp),
                                  color: checkOutScreenController
                                      .appColors.lightgreenColor),
                              child: Padding(
                                padding: EdgeInsets.only(top: 0.3.h),
                                child: Text(
                                  'SUBMIT'.tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: checkOutScreenController
                                          .appColors.whiteColor,
                                      fontFamily: "Arial",
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Spacer(),
                    const Spacer(),
                    Flexible(
                      child: Image.asset(
                        "assets/images/stripe.jpg",
                        width: MediaQuery.of(context).size.width,
                        height: Get.height / 10,
                        fit: BoxFit.cover,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic>? paymentIntent = {};

  /// confirm payment

  confirmPayment() async {
    try {
      var paymentConfirmation = await Stripe.instance.confirmPayment(
        data: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(
                email: data['emailDonate'], name: data['nameDonate']),
          ),
        ),
        paymentIntentClientSecret: paymentIntent!['client_secret'].toString(),
      ).onError((error, stackTrace) {
        return ApiClient.toAst("Please Enter Card Details");
      });

      if (paymentConfirmation.status == PaymentIntentsStatus.Succeeded) {
        ApiClient.toAst("Order Placed Successfully");
        Get.back();
        //checkOutScreenController.placeOrderData(widget.id,);
        // await Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => PurchaseHistorySCreen(
        //             transId: paymentConfirmation.id, payId: paymentConfirmation.paymentMethodId ?? "")));

        String purchaseId = paymentConfirmation.id;
        print("Purchase Id: $purchaseId");

        String paymentMethodId = paymentConfirmation.paymentMethodId ?? "";
        print("Payment Method Id: $paymentMethodId");
      } else {}

      log(paymentConfirmation.toString(), name: "Payment Confirmation");
    } catch (e, st) {
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
  createPaymentIntent(
      {required String amount, required String currency}) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    try {
      checkOutScreenController.isLoading.value = true;

      /// Request body
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };
      print("${{
        'amount': amount,
        'currency': currency,
      }}");

      /// Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://nexever.tech/AkalSahae/api/get-payment-intent'),
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
        checkOutScreenController.isLoading.value = false;
      } else {
        debugPrint(response.body);
        result = 'failure';
        setState(() {
          apiCall = false;
        });
      }
      checkOutScreenController.isLoading.value = false;
    } catch (err, st) {
      if (err is SocketException) {
        checkOutScreenController.isLoading.value = false;
        result = 'no internet';
      }
      print("ERROR: $err");
      print("STACK: $st");
    }
    return result;
  }
}

/*showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                        builder: (context, setToastState) {
                                          toastState = setToastState;
                                          return Dialog(
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: SizedBox(
                                              width:
                                              MediaQuery.of(context).size.width * .25,
                                              child: Padding(
                                                padding: const EdgeInsets.all(20),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    children: [
                                                      const Text(
                                                        "Payment",
                                                        style: TextStyle(
                                                            fontFamily: 'Amazon',
                                                            color: Colors.black,
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                     const SizedBox(
                                                        height: 15,
                                                      ),
                                                      CardField(
                                                        style: const TextStyle(
                                                            color: Colors.red),
                                                        //numberHintText: "Enter your card details",
                                                        controller: cardEditController,
                                                        decoration: const InputDecoration(
                                                          // border: OutlineInputBorder(),
                                                          fillColor: Colors.black12,
                                                          filled: true,
                                                          iconColor: Colors.white,
                                                        ),
                                                        cursorColor: Colors.red,
                                                        onCardChanged: (card) {
                                                          setToastState(() {});
                                                        },
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      (isPayment == false)
                                                          ? Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              margin: const EdgeInsets.only(
                                                                  right: 8),
                                                              child: GestureDetector(
                                                                onTap: () {
                                                                  cardEditController
                                                                      .dispose();
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Container(
                                                                  height: 40,
                                                                  alignment: Alignment
                                                                      .center,
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        10),
                                                                    color:
                                                                    Colors.grey,
                                                                  ),
                                                                  padding:
                                                                  const EdgeInsets.all(
                                                                      10),
                                                                  child: const Text(
                                                                    "CANCEL",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                        'Amazon',
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize: 17,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold),
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
                                                                margin:
                                                                const EdgeInsets.only(
                                                                    right: 8),
                                                                child: GestureDetector(
                                                                    onTap: () async {
                                                                      FocusManager
                                                                          .instance
                                                                          .primaryFocus
                                                                          ?.unfocus();

                                                                      setToastState(
                                                                              () {
                                                                            apiCall =
                                                                            true;
                                                                            isDeleteItem =
                                                                            true;
                                                                            isPayment =
                                                                            !isPayment;
                                                                          });
                                                                      var val = await createPaymentIntent(
                                                                          amount: data[
                                                                          'amountDonate'],
                                                                          currency:
                                                                          "USD",
                                                                          );
                                                                      if (val ==
                                                                          'success' &&
                                                                          cardEditController
                                                                              .details
                                                                              .complete ==
                                                                              true) {
                                                                        await confirmPayment();
                                                                      } else {
                                                                        setToastState(
                                                                                () {
                                                                              failed =
                                                                              true;
                                                                              apiCall =
                                                                              false;
                                                                              isPayment =
                                                                              false;
                                                                              Fluttertoast
                                                                                  .showToast(
                                                                                  msg:
                                                                                  "Please Enter Card Details");
                                                                            });
                                                                      }
                                                                    },
                                                                    child: Container(
                                                                        height: 40,
                                                                        alignment: Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                          color: Colors.red,
                                                                        ),
                                                                        padding: const EdgeInsets.all(10),
                                                                        child: const Text(
                                                                          "PAY NOW",
                                                                          style: TextStyle(
                                                                              fontFamily:
                                                                              'Amazon',
                                                                              color: Colors
                                                                                  .white,
                                                                              fontSize:
                                                                              17,
                                                                              fontWeight:
                                                                              FontWeight.bold),
                                                                        ))),
                                                              )),
                                                        ],
                                                      )
                                                          : const CircularProgressIndicator(
                                                        color: Colors.yellow,
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      Image.asset(
                                                        'assets/images/stripe.jpg',
                                                        width: MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  });*/
