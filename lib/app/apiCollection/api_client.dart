import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:akalsahae/app/modules/accessories/accessories_controller.dart';
import 'package:akalsahae/app/modules/add_address_screen_module/add_address_api_modal.dart';
import 'package:akalsahae/app/modules/check_out_screen_module/DeleteCartApiModal.dart';
import 'package:akalsahae/app/modules/check_out_screen_module/Get_Add_To_Cart_api_modal.dart';
import 'package:akalsahae/app/modules/check_out_screen_module/PinCodeApiModal.dart';
import 'package:akalsahae/app/modules/check_out_screen_module/PlaceOrderApiModal.dart';
import 'package:akalsahae/app/modules/fullvoile_turban_screen_module/TurbanProductDetailApiModal.dart';
import 'package:akalsahae/app/modules/home_screen_module/GetCategoryApiModal.dart';
import 'package:akalsahae/app/modules/home_screen_module/home_screen_controller.dart';
import 'package:akalsahae/app/modules/my_account_screen_module/Log_Out_Api_modal.dart';
import 'package:akalsahae/app/modules/my_order_screen_module/GetPlaceOrderApiModal.dart';
import 'package:akalsahae/app/modules/save_address_screen_module/get_address_api_modal.dart';
import 'package:akalsahae/app/modules/save_address_screen_module/save_address_screen_controller.dart';
import 'package:akalsahae/app/modules/shop_screen_module/GetColorApiModal.dart';
import 'package:akalsahae/app/utils/shared_preferences_helper.dart';
import 'package:akalsahae/app/utils/shared_prefs_keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as getX;
import 'package:sizer/sizer.dart';
import '../modules/Accessory_Product_detail/AccessoryAddToFavApiModal.dart';
import '../modules/Accessory_Product_detail/AccessoryProductDetailApiModal.dart';
import '../modules/accessories/GetAccessoryApiModal.dart';
import '../modules/bottom_screen_module/Server_Maintance_Response.dart';
import '../modules/check_out_screen_module/UpdateRemoveCartApiModal.dart';
import '../modules/favorite_screen_module/FavApiModal.dart';
import '../modules/fullvoile_turban_screen_module/Add_To_Cart_Api_Modal.dart';
import '../modules/fullvoile_turban_screen_module/Add_to_favourite_Api_Modal.dart';
import '../modules/save_address_screen_module/DefaultResponseModal.dart';
import '../modules/save_address_screen_module/RemoveAddressApiModal.dart';

class ApiClient {
  static Dio dio = Dio();

  //static const String baseUrl = 'https://nexever.tech/AkalSahae';
  static const String baseUrl = 'https://nexever.tech/AkalSahae_New';

  static Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static Future<ServerMaintenanceResponse?> serverMaintData() async {
    String path = 'https://nexever.org/Maintenance-mode/akal-sahae';
    if (await hasNetwork()) {
      try {
        var response = await dio.get(path);
        print("status code ${response.statusCode}");
        print("response data ${response.data}");
        if (response.statusCode == 200) {
          return ServerMaintenanceResponse.fromJson(response.data);
        }
        return null;
      } on DioException {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<dynamic> resendOTP({String? phoneNumber, String? email, String? type}) async {
    var data;
    print(phoneNumber);
    if (type == "phone") {
      data = {"receiver_number": phoneNumber};
    } else {
      data = {"receiver_email": email};
    }
    String path = '$baseUrl/api/admin/resend-sms';
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json'},
    );
    try {
      var response = await dio.post(path, data: data, options: options);
      if (response.statusCode == 200) {
        return response.data;
      } else if (response.statusCode == 401) {
        logOutApi();
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e, st) {
      print("OTP ERROR: $e");
      print("OTP ERROR: $st");
      if (e.type == DioExceptionType.connectionTimeout) {}
      if (e.type == DioExceptionType.receiveTimeout) {}
    }
  }

  static Future<dynamic> socialLoginApi(dynamic request) async {
    var myResponse;
    String path = '$baseUrl/api/socialLogin';
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json'},
    );
    try {
      await dio.post(path, data: request, options: options).then((response) {
        if (response.statusCode == 200) {
          myResponse = response.data;
          return response.data;
        } else if (response.statusCode == 401) {
          logOutApi();
        } else if (response.statusCode == 500) {
          myResponse = {"error": true, "message": "Internal Server Error"};
          return myResponse;
        } else {
          throw Exception('Authentication Error');
        }
      }).onError((error, stackTrace) {
        myResponse = {"error": true, "message": "Internal Server Error"};
        return myResponse;
      });
      return myResponse;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {}
      if (e.type == DioExceptionType.receiveTimeout) {}
    }
    return myResponse;
  }

  static Future<dynamic> loginApi(dynamic request) async {
    var myResponse;
    String path = '$baseUrl/api/login';
    Options options = Options(
      headers: {Headers.acceptHeader: 'application/json'},
    );
    try {
      await dio.post(path, data: request, options: options).then((response) {
        if (response.statusCode == 200) {
          myResponse = response.data;
          return myResponse;
        } else if (response.statusCode == 401) {
          logOutApi();
        } else {
          throw Exception('Authentication Error');
        }
      }).onError((error, stackTrace) {
        myResponse = {};
      });
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {}
      if (e.type == DioExceptionType.receiveTimeout) {}
    }
    return myResponse;
  }

  static Future<dynamic> getHomeData() async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    print("Token:- $token");
    String path = '$baseUrl/api/home';
    print("Home page URL $path");
    print("Home page token $token");
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.get(path, options: options);
        if (response.statusCode == 200) {
          print("Home Screen data: $response");
          GetCategoryApiModal getCategoryApiModal = GetCategoryApiModal();
          var responseData = jsonDecode(response.toString());
          HomeScreenController homeScreenController = getX.Get.find<HomeScreenController>();

          getCategoryApiModal = GetCategoryApiModal.fromJson(responseData);
          homeScreenController.getCategoryApiModal.value = getCategoryApiModal;
          return true;
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Get Category data>>>>>>>>>>');
        } else if (response.statusCode == 401) {
          logOutApi();
        }
      } on DioException catch (e, st) {
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        return false;
      }
    } else {
      toAst("No Internet");
    }
  }

  /*static Future<dynamic> getCategoryData() async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    String path = '$baseUrl/api/getcategory';
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {
        Headers.acceptHeader: 'application/json',
        "Authorization": "Bearer $token"
      },
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.get(path, options: options);
        if (response.statusCode == 200) {
          GetCategoryApiModal getCategoryApiModal = GetCategoryApiModal();
          var responseData = jsonDecode(response.toString());
          HomeScreenController homeScreenController =
              getX.Get.find<HomeScreenController>();

          getCategoryApiModal = GetCategoryApiModal.fromJson(responseData);
          homeScreenController.getCategoryApiModal.value = getCategoryApiModal;
          return true;
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Get Category data>>>>>>>>>>');
        } else if (response.statusCode == 401) {
          logOutApi();
        }
      } on DioException catch (e, st) {
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        return false;
      }
    } else {
      toAst("No Internet");
    }
  }*/

  static Future<GetColorApiModal?> getColorData({required String clothId}) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    //String path = '$baseUrl/api/getcolors';
    String path = '$baseUrl/api/turban-colors';
    var data = {
      'product_id': clothId,
    };
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.post(path, data: data, options: options);
        log("${response.data}", name: "Color Response");
        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.toString());
          return GetColorApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Get Color data>>>>>>>>>>');
        } else if (response.statusCode == 401) {
          logOutApi();
        }
      } on DioException catch (e, st) {
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        return null;
      }
    } else {
      toAst("No Internet");
    }
  }

  static Future<bool> getAccessoriesData({required String CategoryId, required String page}) async {
    String path = '$baseUrl/api/getproductbycategory';
    var data = {'category_id': CategoryId, 'page': page};
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json'},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.post(path, data: data, options: options);

        if (response.statusCode == 200) {
          GetAccessoryApiModal getAccessoryApiModal = GetAccessoryApiModal();
          var responseData = jsonDecode(response.toString());
          AccessoriesController accessoriesController = getX.Get.find<AccessoriesController>();
          log("${response.data}", name: "Accessory Response");
          getAccessoryApiModal = GetAccessoryApiModal.fromJson(responseData);
          accessoriesController.getAccessoryApiModal.value = getAccessoryApiModal;
          return true;
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Get Accessory data>>>>>>>>>>');
        } else if (response.statusCode == 401) {
          logOutApi();
        }
        return true;
      } on DioException catch (e, st) {
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}

        return false;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }

  static Future<dynamic> addAddressApiModal(
      {required String name,
      required String address,
      required String pinCode,
      required String state,
      required String city,
      required String country,
      required String addressType,
      required String number,
      required String email,
      required String shippingAddress,
      required String shippingName,
      required String shippingCity,
      required String shippingCountry,
      required String shippingEmail,
      required String shippingState,
      required String shippingPinCode,
      required String shippingMobile,
      required int status,
      required String isDefault}) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    var data = {
      "name": name,
      "address": address,
      "pincode": pinCode,
      "state": state,
      "city": city,
      "country": country,
      "address_type": addressType,
      "mobile": number,
      "status": status,
      "email": email,
      "shipping_address": shippingAddress,
      "shipping_pincode": shippingPinCode,
      "shipping_state": shippingState,
      "shipping_mobile": shippingMobile,
      "shipping_name": shippingName,
      "shipping_email": shippingEmail,
      "shipping_city": shippingCity,
      "shipping_country": shippingCountry,
      "is_default": isDefault
    };
    String path = '$baseUrl/api/addAddress';

    print("Add address URL $path");
    print("Add address body $data");

    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.post(path, data: data, options: options);

        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.toString());
          log("${response.data}", name: "Add Address");
          ApiClient.toAst(responseData['message'].toString());
          return AddAddressApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Add Address data>>>>>>>>>>');
        } else if (response.statusCode == 401) {
          logOutApi();
        }
        return true;
      } on DioException catch (e, st) {
        print("Address Error:$e");
        print("Address stack:$st");
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}

        return false;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }

  static Future<dynamic> getAddressApiModal() async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    String path = '$baseUrl/api/getaddress';
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.get(path, options: options);

        if (response.statusCode == 200) {
          log("${response.data}", name: "Get Address");

          var responseData = jsonDecode(response.toString());

          return GetAddressApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Add Address data>>>>>>>>>>');
        } else if (response.statusCode == 401) {
          logOutApi();
        }
        return true;
      } on DioException catch (e, st) {
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        return false;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }

  static Future<dynamic> getTurbanProductDetailData({required String productId, required String colorName}) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    print("${{'product_id': productId, 'color_slug': colorName}}");
    var data = {'product_id': productId, 'color_slug': colorName};
    String path = '$baseUrl/api/product-details';
    Options options = Options(
      contentType: Headers.jsonContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.get(path, data: data, options: options);
        log("Turban Product Response ==>>>> ${response}");
        log("Turban Product Response ==>>>> ${response.statusCode}");
        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.toString());
          return TurbanProductDetailApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Get Turban Product data>>>>>>>>>>');
        } else if (response.statusCode == 401) {
          logOutApi();
        }
      } on DioException catch (e, st) {
        log("Turban Product Error ==>>>> ${e} ${st}");
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        throw Exception('Data type error');
      }
    } else {
      toAst("No Internet");
    }
  }

  static Future<AccessoryProductDetailApiModal?> getAccessoryProductDetailData({required String productId}) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    var data = {'product_id': productId};
    String path = '$baseUrl/api/product-details';
    Options options = Options(
      contentType: Headers.jsonContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.get(path, data: data, options: options);
        log(" Product Response ==>>>> ${response}");
        log("Accessory Product Response ==>>>> ${response.statusCode}");
        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.toString());

          return AccessoryProductDetailApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Get Accessory data>>>>>>>>>>');
        } else if (response.statusCode == 401) {
          logOutApi();
        }
      } on DioException catch (e, st) {
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        return null;
      }
    } else {
      toAst("No Internet");
    }
  }

  static Future<dynamic> addToCartApiModal({
    required String colorId,
    required String brandId,
    required int? productId,
    required String variationId,
    required String priceBeforeDiscount,
    required String priceAfterDiscount,
    required String size,
    required String stitch,
    required String turbanLength,
  }) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    var deviceId = await SharePreferencesHelper.getString(SharedPrefKeys.DEVICE_ID);

    var data = {
      "color_id": colorId,
      "brand_id": brandId,
      "product_id": productId,
      "variation_id": variationId,
      "price_before_discount": priceBeforeDiscount,
      "price_after_discount": priceAfterDiscount,
      "size": size,
      "length_in_meters": turbanLength
    };

    if (stitch.isNotEmpty) {
      data["center_stitch"] = stitch;
    }
    String path = '$baseUrl/api/add-to-cart';

    print("sdfklsdjfljkdlsf $path");
    print("sdfklsdjfljkdlsf $data");
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.post(path, data: jsonEncode(data), options: options);
        log("${response.data}", name: "Add to cart Response");
        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.toString());
          return AddToCartApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Add Address data>>>>>>>>>>');
        } else if (response.statusCode == 401) {
          logOutApi();
        }
      } on DioException catch (e, st) {
        log("${e.response}", name: "Add to cart Error", error: e, stackTrace: st);
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        return null;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }

  static Future<dynamic> getAddToCartApiModal() async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    print("Token: $token");
    String path = 'https://nexever.tech/AkalSahae_New/api/getcart';
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.get(path, options: options);
        if (response.statusCode == 200) {
          log("${response.data}", name: "Get Cart Response");
          var responseData = jsonDecode(response.toString());
          return GetAddToCartApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Get Turban Product data>>>>>>>>>>');
        } else if (response.statusCode == 401) {
          logOutApi();
        }
      } on DioException catch (e, st) {
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        return null;
      }
    } else {
      toAst("No Internet");
    }
  }

  static Future<dynamic> placeOderApiData({
    required String addressId,
    required String transId,
    required String payId,
  }) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);

    var data = {"address_id": addressId, "transaction_id": transId, "pay_method_id": payId};
    String path = '$baseUrl/api/placeOrder';
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.post(path, data: data, options: options);

        if (response.statusCode == 200) {
          log("${response.data}", name: "Place Order Response");
          var responseData = jsonDecode(response.toString());
          return PlaceOrderApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Place Order>>>>>>>>>>');
        } else if (response.statusCode == 401) {
          logOutApi();
        }
      } on DioException catch (e, st) {
        print("Error :$e");
        print("Stack :$st");
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        return null;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }

  static Future<dynamic> getOrderApiModal() async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    String path = '$baseUrl/api/getOrders';
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.get(path, options: options);

        if (response.statusCode == 200) {
          log("${response.data}", name: "Get OrderResponse");
          var responseData = jsonDecode(response.toString());
          return GetOrderApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to get order>>>>>>>>>>');
        } else if (response.statusCode == 401) {
          logOutApi();
        }
      } on DioException catch (e, st) {
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        return null;
      }
    } else {
      toAst("No Internet");
    }
  }

  static Future<dynamic> removeApiData({required int cardId, required int quantity}) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    var data = {"card_id": cardId, "quantity": quantity};
    String path = '$baseUrl/api/updatecart';
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );

    if (await hasNetwork()) {
      try {
        var response = await dio.post(path, data: data, options: options);

        if (response.statusCode == 200) {
          log("${response.data}", name: "Remove cart Response");
          var responseData = jsonDecode(response.toString());
          toAst(responseData['message'].toString());
          return RemoveCartApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to remove cart>>>>>>>>>>');
        } else if (response.statusCode == 401) {
          logOutApi();
        }
      } on DioException catch (e, st) {
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        return null;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }

  static Future<dynamic> enterPinCode({required String pinCode}) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    var data = {"pincode": pinCode};

    print("sdfsddksf $data");

    String path = 'https://nexever.tech/AkalSahae_New/api/pincode_checker';
    Options options = Options(
      headers: {'Content-Type': 'application/json', "Authorization": "Bearer $token"},
    );

    if (await hasNetwork()) {
      try {
        var response = await dio.post(path, data: jsonEncode(data), options: options);

        print("dsfklsdkflsdjf ${response.statusCode}");
        print("dsfklsdkflsdjf ${response.data}");
        log("${response.data}", name: "Pin Code");
        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.toString());

          return PinCodeApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          // throw Exception('<<<<<<<<<<Failed to remove cart>>>>>>>>>>');
          return null;
        } else if (response.statusCode == 401) {
          logOutApi();
          return null;
        } else {
          return null;
        }
      } on DioException catch (e, st) {
        log("${e.response}", name: "Pincode Response");
        log("${st}", name: "Pincode Response");
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        return null;
      }
    } else {
      toAst("No Internet");
      return null;
    }
  }

  static Future<dynamic> deleteCartData({required int cartId}) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    var data = {"cart_id": cartId};
    String path = 'https://nexever.tech/AkalSahae_New/api/remove-cart-item';
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );

    if (await hasNetwork()) {
      try {
        var response = await dio.post(path, data: data, options: options);

        log("${response.data}", name: "Delete cart Response");
        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.toString());
          toAst(responseData['message'].toString());
          return DeleteCartApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to remove cart>>>>>>>>>>');
        } else if (response.statusCode == 401) {
          logOutApi();
        } else if (response.statusCode == 404) {
          toAst("Cart item not found");
        }
      } on DioException catch (e, st) {
        log("${e.response}", name: "Delete cart Response");
        log("${st}", name: "Delete cart Response");
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        return null;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }

  static Future<dynamic> defualtAddressApi({required String address_id}) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    var data = {
      "address_id": address_id,
    };
    String path = '$baseUrl/api/setdefaultaddress';
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.post(path, data: data, options: options);

        if (response.statusCode == 200) {
          DefaultResponseModal defaultResponse = DefaultResponseModal();
          var responseData = jsonDecode(response.toString());
          SaveAddressScreenController saveAddressScreenController = getX.Get.put(SaveAddressScreenController());
          defaultResponse = DefaultResponseModal.fromJson(responseData);
          saveAddressScreenController.defaultAddressApiModal.value = defaultResponse;
          toAst(responseData['message'].toString());
          return true;
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Add Address data>>>>>>>>>>');
        } else if (response.statusCode == 401) {
          logOutApi();
        }
        return true;
      } on DioException catch (e, st) {
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}

        return false;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }

  static Future<dynamic> updateAddressApi(
      {required String address_id,
      required String address,
      required String email,
      required String name,
      required String pinCode,
      required String state,
      required String city,
      required String country,
      required String addressType,
      required String number,
      required String shippingAddress,
      required String shippingName,
      required String shippingCity,
      required String shippingCountry,
      required String shippingEmail,
      required String shippingState,
      required String shippingPinCode,
      required String shippingMobile,
      required int status,
      required String isDefault}) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    var data = {
      "address_id": address_id,
      "address": address,
      "pincode": pinCode,
      "state": state,
      "city": city,
      "country": country,
      "address_type": addressType,
      "mobile": number,
      "email": email,
      "name": name,
      "shipping_address": shippingAddress,
      "shipping_pincode": shippingPinCode,
      "shipping_state": shippingState,
      "shipping_mobile": shippingMobile,
      "shipping_name": shippingName,
      "shipping_email": shippingEmail,
      "shipping_city": shippingCity,
      "shipping_country": shippingCountry,
      "status": status,
      "is_default": isDefault
    };
    String path = '$baseUrl/api/updateaddress';

    print("Path of the $path");
    print("Data of the $data");
    print("Token $token");

    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.post(path, data: data, options: options);
        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.toString());
          toAst(responseData['message'].toString());
          return true;
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Remove Address data>>>>>>>>>>');
        } else if (response.statusCode == 401) {
          logOutApi();
        }
        return true;
      } on DioException catch (e, st) {
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        return false;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }

  static Future<dynamic> removeAddressApi({required String address_id}) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);

    var data = {
      "address_id": address_id,
    };

    String path = '$baseUrl/api/deleteaddress';
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.post(path, data: data, options: options);

        if (response.statusCode == 200) {
          RemoveResponseModal removeResponseModal = RemoveResponseModal();
          var responseData = jsonDecode(response.toString());
          SaveAddressScreenController saveAddressScreenController = getX.Get.put(SaveAddressScreenController());
          removeResponseModal = RemoveResponseModal.fromJson(responseData);
          saveAddressScreenController.removeAddressApiModal.value = removeResponseModal;

          toAst(responseData['message'].toString());
          return true;
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Remove Address data>>>>>>>>>>');
        } else if (response.statusCode == 401) {
          logOutApi();
        }
        return true;
      } on DioException catch (e, st) {
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        return false;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }

  static Future<dynamic> accessoryAddToCartModal({
    required String productId,
    required String priceBeforeDiscount,
    required String priceAfterDiscount,
  }) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    var deviceId = await SharePreferencesHelper.getString(SharedPrefKeys.DEVICE_ID);

    var data = {
      "color_id": "",
      "brand_id": "",
      "product_id": productId,
      "variation_id": "",
      "price_before_discount": priceBeforeDiscount,
      "price_after_discount": priceAfterDiscount,
      "size": "",
      "center_stitch": "",
      "length_in_meters": ""
    };
    String path = '$baseUrl/api/add-to-cart';

    print("URL:- $path");
    print("Data 88:- $data");

    Options options = Options(
      headers: {'Content-Type': 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.post(path, data: jsonEncode(data), options: options);

        print("Reponse :- ${response.statusCode}");
        print("Reponse body :- ${response.data}");

        log("${response.data}", name: "Add to cart Response");
        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.toString());
          return AddToCartApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Add Address data>>>>>>>>>>');
        } else if (response.statusCode == 401) {
          logOutApi();
        }
      } on DioException catch (e, st) {
        print("Reponse body expection:- $e");

        log("${e.response}", name: "Add to cart Error", error: e, stackTrace: st);
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        return null;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }

  static Future<dynamic> logOutApi() async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    String path = '$baseUrl/api/logout';
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.post(path, options: options);
        log("Log out Response ==>>>> ${response.data}");
        log("Log outResponse ==>>>> ${response.statusCode}");
        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.toString());
          return LogOutApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Log Out>>>>>>>>>>');
        } else if (response.statusCode == 401) {
          logOutApi();
        }
      } on DioException catch (e, st) {
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        throw Exception('Data type error');
      }
    } else {
      toAst("No Internet");
    }
  }

  static Future<dynamic> addToFavoriteCartApi(
      {required int productId, required String colorSlug, required bool isFavorite}) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    print("${{"color_slug": colorSlug, "product_id": productId, "is_favorite": isFavorite}}");
    var data = {"color_slug": colorSlug, "product_id": productId, "is_favorite": isFavorite};
    String path = '$baseUrl/api/add-to-favorites-new';
    Options options = Options(
      contentType: Headers.jsonContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.post(path, data: data, options: options);
        if (response.statusCode == 200) {
          log("${response.data}", name: "Add to Fav Response");
          var responseData = jsonDecode(response.toString());
          toAst(responseData['message'].toString());
          return AddToFavoriteApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Add Address data>>>>>>>>>>');
        } else if (response.statusCode == 401) {
          logOutApi();
        }
      } on DioException catch (e, st) {
        print("addToFavoriteCartApi ==> Error: $e");
        print("addToFavoriteCartApi ==> Error: $st");
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        return null;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }

  static Future<dynamic> getFavList() async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    String path = '$baseUrl/api/get-to-favorites-new';
    print("sdlf;sdf $path");
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.get(path, options: options);

        if (response.statusCode == 200) {
          print("Get fav data:${response}");
          var responseData = jsonDecode(response.toString());
          return GetFavListModel.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to get fav data>>>>>>>>>>');
        } else if (response.statusCode == 401) {
          logOutApi();
        }
      } on DioException catch (e, st) {
        print("Error : $e");
        print("Stack Trace : $st");
        if (e.type == DioExceptionType.connectionTimeout) {
          toAst("No Internet");
          return null;
        }
        if (e.type == DioExceptionType.receiveTimeout) {}
        return null;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }

  static Future<dynamic> accessoryAddToFavoriteCartApi({required int productId, required bool isFavorite}) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    var data = {"product_id": productId, "is_favorite": isFavorite};
    String path = '$baseUrl/api/add-to-favorites';
    Options options = Options(
      contentType: Headers.jsonContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.post(path, data: data, options: options);
        if (response.statusCode == 200) {
          log("${response.data}", name: "Add to Fav Response");
          var responseData = jsonDecode(response.toString());
          toAst(responseData['message'].toString());
          return AccessoryAddToFavApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Add Fav accessory data>>>>>>>>>>');
        } else if (response.statusCode == 401) {
          logOutApi();
        }
      } on DioException catch (e, st) {
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        return null;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }

  static toAst(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xffFF9900),
        textColor: Colors.black,
        fontSize: 10.sp);
  }

  static Future<dynamic> getProfileData() async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    String path = '$baseUrl/api/get-profile';
    Options options = Options(
      contentType: Headers.jsonContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.get(path, options: options);
        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.toString());
          if (responseData["data"]["name"].trim() == "") {
            return responseData;
          } else {
            return responseData;
          }
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Add Fav accessory data>>>>>>>>>>');
        } else if (response.statusCode == 401) {
          logOutApi();
        }
      } on DioException catch (e, st) {
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        return null;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }

  static Future<dynamic> updateProfile(
      {String? name, String? email, String? image, String? phoneNo, String? countryCode}) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    String path = '$baseUrl/api/update-profile';
    Options options = Options(
      contentType: Headers.jsonContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    FormData formData;
    if (image != null && image.contains("http")) {
      formData =
          FormData.fromMap({"profile_image": image, "first_name": name, "email": email, "country_code": countryCode});
    } else {
      formData = FormData.fromMap({
        "profile_image": image != null && image.isNotEmpty
            ? await MultipartFile.fromFile(
                image ?? "",
                filename: File(image).path,
              )
            : "",
        "first_name": name,
        "email": email,
        "country_code": countryCode
      });
    }

    if (await hasNetwork()) {
      try {
        var response = await dio.post(path, data: formData, options: options);
        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.toString());
          return responseData;
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Add Fav accessory data>>>>>>>>>>');
        } else if (response.statusCode == 401) {
          logOutApi();
        }
      } on DioException catch (e, st) {
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        return null;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }

  ///Update Phone Number
  static Future<dynamic> checkPhoneNumber({String? phoneNo, String? countryCode, String? email, String? type}) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    String path = '$baseUrl/api/check-phone-email';
    Options options = Options(
      contentType: Headers.jsonContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    var data = {};
    if (type == "email") {
      data = {"email": email};
    } else {
      data = {"new_mobile_number": phoneNo, "new_country_code": countryCode};
    }

    if (await hasNetwork()) {
      try {
        var response = await dio.post(path, data: data, options: options);
        if (response.statusCode == 200) {
          return true;
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Exception>>>>>>>>>>');
        } else if (response.statusCode == 401) {
          logOutApi();
        }
      } on DioException catch (e, st) {
        if (type == "phone") {
          toAst("This number is already linked");
        } else {
          toAst("This email is already linked");
        }
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        return null;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }

  static Future updatePhoneNumber({String? countryCode, required String phoneNo, String? type, String? email}) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    String path = '$baseUrl/api/change-phone-email';
    Options options = Options(
      contentType: Headers.jsonContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    var data;
    if (type == "phone") {
      data = {"new_mobile_number": phoneNo, "new_country_code": countryCode};
    } else {
      data = {"email": email};
    }

    if (await hasNetwork()) {
      try {
        var response = await dio.post(path, data: data, options: options);
        if (response.statusCode == 200) {
          if (type == "phone") {
            ApiClient.toAst("Phone number update successfully");
          } else {
            ApiClient.toAst("Email update successfully");
          }
          return true;
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Add Fav accessory data>>>>>>>>>>');
        } else if (response.statusCode == 401) {
          logOutApi();
        }
      } on DioException catch (e, st) {
        toAst("This number is already linked");
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        return null;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }
}

void printData(object) {
  String message = "$object";
  if (kDebugMode) {
    print(message);
  }
}
