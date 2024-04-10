// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';
import 'package:akalsahae/app/apiCollection/api_client.dart';
import 'package:akalsahae/app/modules/add_address_screen_module/add_address_api_modal.dart';
import 'package:akalsahae/app/modules/check_out_screen_module/check_out_screen_controller.dart';
import 'package:akalsahae/app/modules/save_address_screen_module/save_address_screen_controller.dart';
import 'package:akalsahae/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../helper_widget/colors.dart';
import '../check_out_screen_module/PinCodeApiModal.dart';
import '../save_address_screen_module/get_address_api_modal.dart';

class AddAddressScreenController extends GetxController {
  SaveAddressScreenController saveAddressScreenController = Get.put(SaveAddressScreenController());
  Rx<AddressData> getAddressApiModal = AddressData().obs;
  CheckOutScreenController checkOutScreenController = Get.find<CheckOutScreenController>();

  bool isPincodeEnable = false;
  bool isCityEnable = false;
  bool isStateEnable = false;
  bool isCountryEnable = false;

  //Map<String, dynamic> shippingData = {};
  String shippingData = "";
  AppColors appColors = AppColors();
  Rx<AddAddressApiModal> addAddressApiModal = AddAddressApiModal().obs;
  int value = 0;
  TextEditingController addressController = TextEditingController();
  TextEditingController billingController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController shippingAddressController = TextEditingController();
  TextEditingController shippingNameController = TextEditingController();
  TextEditingController shippingMobileController = TextEditingController();
  TextEditingController shippingPinCodeController = TextEditingController();
  TextEditingController shippingCityController = TextEditingController();
  TextEditingController shippingStateController = TextEditingController();
  TextEditingController shippingEmailController = TextEditingController();
  TextEditingController shippingCountryController = TextEditingController();
  var address = "".obs;
  RxBool isLoading = false.obs;
  var route = false.obs;

  var addressId = "";
  List<String> dropDownItem = [];
  List<String> dropDownItemShipping = [];
  RxString city = ''.obs;
  RxString cityShipping = ''.obs;
  RxBool isDefaultAddress = false.obs;
  RxBool isBilling = false.obs;
  RxBool isBillingOpen = false.obs;

  @override
  void onInit() {
    if (Get.parameters.containsKey('isEnabled')) {
      if (Get.parameters['isEnabled'] == 'true') {
        isPincodeEnable = true;
        isCityEnable = true;
        isStateEnable = true;
        isCountryEnable = true;
      } else {
        isPincodeEnable = false;
        isCityEnable = false;
        isStateEnable = false;
        isCountryEnable = false;
      }
    }

    if (Get.parameters.containsKey('checkOut')) {
      if (route.value = true) if (Get.parameters.containsKey('state')) {
        pinCodeController.text = Get.parameters['pincode'].toString();
        stateController = TextEditingController(text: "${Get.parameters['state']}");
        shippingPinCodeController.text = Get.parameters['pincode'].toString();
        shippingStateController = TextEditingController(text: "${Get.parameters['state']}");
      }
      if (Get.parameters.containsKey('country')) {
        countryController = TextEditingController(text: "${Get.parameters['country']}");
        shippingCountryController = TextEditingController(text: "${Get.parameters['country']}");
      }
      if (Get.parameters.containsKey('city')) {
        print(Get.parameters['city']);
        print(jsonDecode(Get.parameters['city']!));

        var data = jsonDecode(Get.parameters['city']!);
        for (var element in data) {
          dropDownItem.add(element.toString());
          dropDownItemShipping.add(element.toString());
        }

        city.value = dropDownItem[0];
        cityShipping.value = dropDownItemShipping[0];
        //cityController = TextEditingController(text: dropDownItem[0]);
      } else {
        cityController = TextEditingController(text: cityController.text);
      }
    }

    if (Get.arguments != null) {
      if (Get.arguments != {} && Get.arguments["fromChangeAddress"] != null && Get.arguments["fromChangeAddress"]) {
      } else {
        var json = Get.arguments ?? {};
        print(json);
        getAddressApiModal.value = AddressData.fromJson(json);
        printData("data---->${getAddressApiModal.value.toJson()}");
        addressController = TextEditingController(text: "${getAddressApiModal.value.address}");
        mobileController = TextEditingController(text: "${getAddressApiModal.value.mobile}");
        pinCodeController = TextEditingController(text: "${getAddressApiModal.value.pincode}");
        cityController = TextEditingController(text: "${getAddressApiModal.value.city}");
        stateController = TextEditingController(text: "${getAddressApiModal.value.state}");
        countryController = TextEditingController(text: "${getAddressApiModal.value.country}");
        emailController = TextEditingController(text: "${getAddressApiModal.value.email}");
        nameController = TextEditingController(text: "${getAddressApiModal.value.name}");
        shippingNameController = TextEditingController(text: "${getAddressApiModal.value.shippingName}");
        shippingCountryController = TextEditingController(text: "${getAddressApiModal.value.shippingCountry}");
        shippingStateController = TextEditingController(text: "${getAddressApiModal.value.shippingState}");
        shippingMobileController = TextEditingController(text: "${getAddressApiModal.value.shippingMobile}");
        shippingAddressController = TextEditingController(text: "${getAddressApiModal.value.shippingAddress}");
        shippingCityController = TextEditingController(text: "${getAddressApiModal.value.shippingCity}");
        shippingPinCodeController = TextEditingController(text: "${getAddressApiModal.value.shippingPincode}");
        shippingEmailController = TextEditingController(text: "${getAddressApiModal.value.shippingEmail}");
        dropDownItem.add(cityController.text);
        dropDownItemShipping.add(shippingCityController.text);
        city.value = dropDownItem[0];
        cityShipping.value = dropDownItemShipping[0];

        addressId = "${getAddressApiModal.value.id}";
        printData("IDDDDD---->${getAddressApiModal.value.id}");
        if (getAddressApiModal.value.addressType == 'Home') {
          value = 1;
        } else {
          value = 2;
        }
        pinCodeData(pinCodeController.text);
        pinCodeShippingData(shippingPinCodeController.text);
      }
    }

    super.onInit();
  }

  Rx<PinCodeApiModal> pinCodeValue = PinCodeApiModal().obs;
  TextEditingController pincodeController = TextEditingController();

  Future<PinCodeApiModal?> pinCodeData(String value) async {
    try {
      dropDownItem.clear();
      city.value = '';
      countryController.text = '';
      stateController.text = '';
      update();
      final response = await ApiClient.enterPinCode(pinCode: value);
      if (response != null) {
        if (response.message.toString() == "No Delivery Available at this zipcode") {
          ApiClient.toAst("No Delivery Available at this zipcode");
          return null;
        }
        pinCodeValue.value = response;
        dropDownItem.clear();
        if (pinCodeValue.value.data != null) {
          if (pinCodeValue.value.data!.city != null) {
            for (var element in pinCodeValue.value.data!.city!) {
              dropDownItem.add(element.toString());
            }
            city.value = dropDownItem[0];
          }
          if (pinCodeValue.value.data!.country != null) {
            countryController.text = pinCodeValue.value.data!.country ?? '';
          }
          if (pinCodeValue.value.data!.state != null) {
            stateController.text = pinCodeValue.value.data!.state ?? '';
          }
          updateBillingAddress();
        }
        update();
      }
      return response;
    } catch (err) {
      print("Error pin code $err");
      return null;
    }
  }

  Rx<PinCodeApiModal> pinCodeValue1 = PinCodeApiModal().obs;

  Future<PinCodeApiModal?> pinCodeShippingData(String value) async {
    try {
      dropDownItemShipping.clear();
      cityShipping.value = '';
      shippingCountryController.text = '';
      shippingStateController.text = '';
      update();
      final response = await ApiClient.enterPinCode(pinCode: value);
      if (response != null) {
        if (response.message.toString() == "No Delivery Available at this zipcode") {
          ApiClient.toAst("No Delivery Available at this zipcode");
          return null;
        }
        pinCodeValue1.value = response;
        dropDownItemShipping.clear();
        if (pinCodeValue1.value.data != null) {
          if (pinCodeValue1.value.data!.city != null) {
            for (var element in pinCodeValue1.value.data!.city!) {
              dropDownItemShipping.add(element.toString());
            }
            cityShipping.value = dropDownItemShipping[0];
          }
          if (pinCodeValue1.value.data!.country != null) {
            shippingCountryController.text = pinCodeValue1.value.data!.country ?? '';
          }
          if (pinCodeValue1.value.data!.state != null) {
            shippingStateController.text = pinCodeValue1.value.data!.state ?? '';
          }
        }
        update();
      }
      return response;
    } catch (err) {
      print("Error shipping pin code $err");
      return null;
    }
  }

  Widget customRadioButton(String text, int index) {
    return GestureDetector(
      onTap: () {
        value = index;
        if (value == 1) {
          saveAddressScreenController.defaultAddress.value.addressType = "Home";
        } else {
          saveAddressScreenController.defaultAddress.value.addressType = "Work";
        }
        update();
      },
      child: Container(
        height: 5.h,
        width: 23.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.sp),
            color: Colors.black,
            border: Border.all(
              color: (value == index) ? appColors.whiteColor : appColors.borderColor,
              width: 1,
            )),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 12.sp,
                color: (value == index) ? appColors.whiteColor : appColors.borderColor,
                fontFamily: "Arial"),
          ),
        ),
      ),
    );
  }

  setShippingAddress() {
    final addMainAddressController = Get.find<AddAddressScreenController>();
    addMainAddressController.billingController.text = addMainAddressController.shippingData.toString();
  }

  setShippingData({
    required String name,
    required String address,
    required String pinCode,
    required String state,
    required String city,
    required String country,
    required String addressType,
    required String number,
    required String email,
  }) async {
    final addMainAddressController = Get.find<AddAddressScreenController>();

    var data = {
      "billingName": name,
      "billingAddress": address,
      "billingPincode": pinCode,
      "billingState": state,
      "billingCity": city,
      "billingCountry": country,
      "billingAddressType": addressType,
      "billingMobile": number,
      "billingEmail": email,
    };

    /// show data in single line with coma
    String billData =
        "${data["billingName"]} ,${data["billingAddress"]} ,${data["billingPincode"]} ,${data["billingState"]},${data["billingCity"]},${data["billingCountry"]},${data["billingAddressType"]},${data["billingMobile"]},${data["billingEmail"]} ";

    /// show data in next next line
    // String datata = """
    // ${data["billingName"]}
    // ${data["billingMobile"]}
    // ${data["billingEmail"]}
    // """;
    addMainAddressController.shippingData = billData;
    setShippingAddress();
  }

  void toggleCheckbox() {
    isDefaultAddress.value = !isDefaultAddress.value;
    update();
  }

  void toggleCheckbox1() {
    isBilling.value = !isBilling.value;
    updateBillingAddress();
    update();
  }

  void updateBillingAddress() {
    if (isBilling.value) {
      shippingNameController.text = nameController.text;
      shippingMobileController.text = mobileController.text;
      shippingAddressController.text = addressController.text;
      shippingPinCodeController.text = pinCodeController.text;
      cityShipping.value = city.value;
      dropDownItemShipping = dropDownItem;
      shippingStateController.text = stateController.text;
      shippingCountryController.text = countryController.text;
      shippingEmailController.text = emailController.text;
    }
    update();
  }

  addAddressData() async {
    isLoading.value = true;

    print("Shipping pin code ${shippingPinCodeController.text}   || ${pincodeController.text}");
    await ApiClient.addAddressApiModal(
            shippingAddress: shippingAddressController.text,
            shippingCity: cityShipping.value,
            shippingCountry: shippingCountryController.text,
            shippingEmail: shippingEmailController.text,
            shippingMobile: shippingMobileController.text,
            shippingName: shippingNameController.text,
            shippingPinCode: shippingPinCodeController.text,
            shippingState: shippingStateController.text,
            name: nameController.text,
            email: emailController.text,
            address: addressController.text,
            pinCode: pinCodeController.text,
            state: stateController.text,
            city: city.value,
            //city: route.value == true ? city.value : cityController.text,
            country: countryController.text,
            addressType: value == 1 ? "Home" : "Work",
            number: mobileController.text,
            status: 1,
            isDefault: isDefaultAddress.value ? '1' : '0')
        .then((value) {
      if (value != null) {
        addAddressApiModal.value = value;
        // checkOutScreenController.saveAddressScreenController.isCheck.value = true;
        checkOutScreenController.saveAddressScreenController.selectAddress.value.id =
            addAddressApiModal.value.address!.id;
        checkOutScreenController.saveAddressScreenController.defaultAddress.value.name = nameController.text;
        checkOutScreenController.saveAddressScreenController.defaultAddress.value.address = addressController.text;
        checkOutScreenController.saveAddressScreenController.selectAddress.value.address = addressController.text;

        print("Only one address $isOnlyOneAddress");
        print("Default ${isDefaultAddress.value}");
        if (isOnlyOneAddress) {
          if (isDefaultAddress.value) {
            selectDefaultAddress(addAddressApiModal.value.address!.id.toString());
          } else {
            Get.back(result: {
              "address": addressController.text.trim(),
              "name": nameController.text.trim(),
              "id": addAddressApiModal.value.address?.id
            });
          }
        } else {
          Get.back(result: {
            "address": addressController.text.trim(),
            "name": nameController.text.trim(),
            "id": addAddressApiModal.value.address?.id
          });
        }
      }
    });
    isLoading.value = false;
  }

  void selectDefaultAddress(String addressId) async {
    print("Address id pass in default address: $addressId");
    await ApiClient.defualtAddressApi(address_id: addressId).then((value) {
      Get.back(result: {
        "address": addressController.text.trim(),
        "name": nameController.text.trim(),
        "id": addAddressApiModal.value.address?.id
      });
    });
  }

  updateAddress() async {
    isLoading.value = true;
    var updateAddress = await ApiClient.updateAddressApi(
        shippingAddress: shippingAddressController.text,
        shippingCity: cityShipping.value,
        shippingCountry: shippingCountryController.text,
        shippingEmail: shippingEmailController.text,
        shippingMobile: shippingMobileController.text,
        shippingName: shippingNameController.text,
        shippingPinCode: shippingPinCodeController.text,
        shippingState: shippingStateController.text,
        name: nameController.text,
        address: addressController.text,
        pinCode: pinCodeController.text,
        state: stateController.text,
        city: city.value,
        country: countryController.text,
        address_id: addressId,
        addressType: value == 1 ? "Home" : "Work",
        number: mobileController.text,
        email: emailController.text,
        status: 1,
        isDefault: isDefaultAddress.value ? '1' : '0');
    if (updateAddress == true) {
      if (isDefaultAddress.value) {
        selectDefaultAddress(addressId.toString());
      } else {
        Get.back(result: true);
      }
    }
  }

  void getDataFromPinCode(pincode) {
    const JsonDecoder _decoder = JsonDecoder();
    ApiClient.dio.get("http://www.postalpincode.in/api/pincode/$pincode").then((response) {
      final String res = response.data.toString();

      if (response.statusCode! < 200 || response.statusCode! > 400) {
        throw Exception("Error while fetching data");
      }
      /*    var json = _decoder.convert(res);
        var tmp = json['PostOffice'] as List;
        locations =
            tmp.map<Location>((json) => Location.fromJson(json)).toList();
        status = 'All Locations at Pincode ' + pincode;*/
    });
  }
}
