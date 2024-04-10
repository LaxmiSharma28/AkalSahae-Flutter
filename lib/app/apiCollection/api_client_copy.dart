import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:akalsahae/app/modules/Accessory_Product_detail/AccessoryAddToCarrtModal.dart';
import 'package:akalsahae/app/modules/accessories/accessories_controller.dart';
import 'package:akalsahae/app/modules/add_address_screen_module/add_address_api_modal.dart';
import 'package:akalsahae/app/modules/check_out_screen_module/DeleteCartApiModal.dart';
import 'package:akalsahae/app/modules/check_out_screen_module/Get_Add_To_Cart_api_modal.dart';
import 'package:akalsahae/app/modules/check_out_screen_module/PlaceOrderApiModal.dart';
import 'package:akalsahae/app/modules/fullvoile_turban_screen_module/TurbanProductDetailApiModal.dart';
import 'package:akalsahae/app/modules/home_screen_module/GetCategoryApiModal.dart';
import 'package:akalsahae/app/modules/home_screen_module/home_screen_controller.dart';
import 'package:akalsahae/app/modules/my_account_screen_module/Log_Out_Api_modal.dart';
import 'package:akalsahae/app/modules/my_order_screen_module/GetPlaceOrderApiModal.dart';
import 'package:akalsahae/app/modules/save_address_screen_module/get_address_api_modal.dart';
import 'package:akalsahae/app/modules/save_address_screen_module/save_address_screen_controller.dart';
import 'package:akalsahae/app/modules/shop_screen_module/GetColorApiModal.dart';
import 'package:akalsahae/app/modules/shop_screen_module/shop_screen_controller.dart';
import 'package:akalsahae/app/utils/shared_preferences_helper.dart';
import 'package:akalsahae/app/utils/shared_prefs_keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
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

  static const String baseUrl = 'https://nexever.tech/AkalSahae';

  static Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static Future<dynamic> resendOTP(
    String phoneNumber,
  ) async {
    var data = {"receiver_number": phoneNumber};
    String path = '$baseUrl/api/admin/resend-sms';
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json'},
    );
    try {
      var response = await dio.post(path, data: data, options: options);
      print("Calling $path");
      print("Request $data");
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {}
      if (e.type == DioExceptionType.receiveTimeout) {}
    }
  }

  static Future<dynamic> socialLoginApi(dynamic request) async {
    var myResponse;
    String path = '$baseUrl/api/socialLogin';
    print("Calling API: $path");
    print("Requesting: $request");
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json'},
    );
    try {
      await dio.post(path, data: request, options: options).then((response) {
        if (response.statusCode == 200) {
          print("Response ${response.data}");
          myResponse = response.data;
          return response.data;
        } else if (response.statusCode == 500) {
          myResponse = {"error": true, "message": "Internal Server Error"};
          print("Internal Server Error ${response.data}");
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
        print("STATUS_CODE ${response.statusCode}");
        if (response.statusCode == 200) {
          myResponse = response.data;

          print("Mobile Response: ${response.data}");
          return myResponse;
        } else {
          throw Exception('Authentication Error');
        }
      }).onError((error, stackTrace) {
        myResponse = {};
        print("Error Occured $error, StackTrace $stackTrace");
      });
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {}
      if (e.type == DioExceptionType.receiveTimeout) {}
    }
    return myResponse;
  }

  static Future<dynamic> getCategoryData() async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    //LoaderWidget.show(Get.context!);
    String path = '$baseUrl/api/getcategory';
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},);
    if (await hasNetwork()) {
      try {
        var response = await dio.get(path,options: options);
        if (response.statusCode == 200) {
          GetCategoryApiModal getCategoryApiModal = GetCategoryApiModal();
          var responseData = jsonDecode(response.toString());
          HomeScreenController homeScreenController = Get.find<HomeScreenController>();

          getCategoryApiModal = GetCategoryApiModal.fromJson(responseData);
          homeScreenController.getCategoryApiModal.value = getCategoryApiModal;

          print("Category Response ${response.data}");
          return true;
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Get Category data>>>>>>>>>>');
        }
        //LoaderWidget.hide();
      } on DioException catch (e, st) {
        //LoaderWidget.hide();
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        print("Stack: $st");
        return false;
      }
    } else {
      //LoaderWidget.hide();
      toAst("No Internet");
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

  static Future<GetColorApiModal?> getColorData({required String clothId}) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    String path = '$baseUrl/api/getcolors';
    var data = {
      'cloth_id': clothId,
    };
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},);
    if (await hasNetwork()) {
      debugPrint("${{
        'cloth_id': clothId,
      }}");
      try {
        var response = await dio.post(path, data: data, options: options);
        log("${response.data}", name: "Color Response");
        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.toString());

          /*  GetColorApiModal getColorApiModal = GetColorApiModal();
          log("${response.data}", name: "Color Response");

          ShopScreenController shopScreenController = Get.find<ShopScreenController>();

          getColorApiModal = GetColorApiModal.fromJson(responseData);
          shopScreenController.getColorApiModal.value = getColorApiModal;*/

          return GetColorApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Get Color data>>>>>>>>>>');
        }
        //LoaderWidget.hide();
      } on DioException catch (e, st) {
        //LoaderWidget.hide();
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        print("Error: $e");
        print("Stack: $st");
        return null;
      }
    } else {
      //LoaderWidget.hide();
      toAst("No Internet");
    }
  }

  static Future<bool> getAccessoriesData({required String CategoryId, required String page}) async {
    print("${CategoryId}cate");
    String path = '$baseUrl/api/getproductbycategory';
    var data = {'category_id': CategoryId, 'page': page};
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json'},
    );
    if (await hasNetwork()) {
      debugPrint("${{'category_id': CategoryId, 'page': page}}");
      try {
        var response = await dio.post(path, data: data, options: options);

        if (response.statusCode == 200) {
          GetAccessoryApiModal getAccessoryApiModal = GetAccessoryApiModal();
          var responseData = jsonDecode(response.toString());
          AccessoriesController accessoriesController = Get.find<AccessoriesController>();

          getAccessoryApiModal = GetAccessoryApiModal.fromJson(responseData);
          accessoriesController.getAccessoryApiModal.value = getAccessoryApiModal;

          print("Accessory Response ${response.data}");
          return true;
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Get Accessory data>>>>>>>>>>');
        }
        return true;
      } on DioException catch (e, st) {
        print("${e}ERROORR");
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}

        print("Stack: $st");
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
      required int status}) async {
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
      "email": email
    };
    String path = '$baseUrl/api/addAddress';
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    printData("Requesting: $data");
    printData("Token $token");
    if (await hasNetwork()) {
      try {
        var response = await dio.post(path, data: data, options: options);

        if (response.statusCode == 200) {
          //AddAddressApiModal addAddressApiModal = AddAddressApiModal();
          var responseData = jsonDecode(response.toString());
          log("${response.data}", name: "Add Address");
          //AddAddressScreenController addressScreenController =
          //Get.put(AddAddressScreenController());
          // addAddressApiModal = AddAddressApiModal.fromJson(responseData);
          // addressScreenController.addAddressApiModal.value = addAddressApiModal;
          ApiClient.toAst(responseData['message'].toString());
          //Fluttertoast.showToast(msg: responseData['message'].toString());
          return AddAddressApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Add Address data>>>>>>>>>>');
        }
        return true;
      } on DioException catch (e, st) {
        print("Add Address error: ${e.response!.data}");
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}

        print("Stack: $st");
        return false;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }

/* static Future<dynamic> addAddressApiModal(
      {required String name,
      required String address,
      required String pinCode,
      required String state,
      required String city,
      required String country,
      required String addressType,
      required String number,
      required int status}) async {
    var token = await SharePreferencesHelper.getString(SharedPrefkeys.TOKEN);
    var data = {
      "name": name,
      "address": address,
      "pincode": pinCode,
      "state": state,
      "city": city,
      "country": country,
      "address_type": addressType,
      "mobile": number,
      "status": status
    };
    String path = '$baseUrl/api/addAddress';
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.post(path, data: data, options: options);

        if (response.statusCode == 200) {
          AddAddressApiModal addAddressApiModal = AddAddressApiModal();
          var responseData = jsonDecode(response.toString());
          AddAddressScreenController addressScreenController = Get.put(AddAddressScreenController());
          addAddressApiModal = AddAddressApiModal.fromJson(responseData);
          addressScreenController.addAddressApiModal.value = addAddressApiModal;

          toAst(responseData['message'].toString());
          return true;
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Add Address data>>>>>>>>>>');
        }
        return true;
      } on DioException catch (e, st) {
        print("Add Address error: ${e.response!.data}");
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}

        print("Stack: $st");
        return false;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }*/

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
        printData("TOKEN  $token");

        if (response.statusCode == 200) {
          log("${response.data}", name: "Get Address");

          var responseData = jsonDecode(response.toString());

          return GetAddressApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Add Address data>>>>>>>>>>');
        }
        return true;
      } on DioException catch (e, st) {
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        print("Error: $e");
        print("Stack: $st");
        return false;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }

  /* static Future<dynamic> getAddressApiModal() async {
    var token = await SharePreferencesHelper.getString(SharedPrefkeys.TOKEN);
    print("Tokennnn:$token");
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

          //GetAddressApiModal getAddressApiModal = GetAddressApiModal();
          var responseData = jsonDecode(response.toString());
          */

  /* SaveAddressScreenController saveAddressScreenController = Get.put(SaveAddressScreenController());
          getAddressApiModal = GetAddressApiModal.fromJson(responseData);
          saveAddressScreenController.getAddressApiModal.value = getAddressApiModal;*/ /*

          return GetAddressApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Add Address data>>>>>>>>>>');
        }
        return true;
      } on DioException catch (e, st) {
        print("Tokennnn:$token");
        print("Add Address error: ${e.response!.data}");
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        print("Error: $e");
        print("Stack: $st");
        return false;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }*/

  static Future<dynamic> getTurbanProductDetailData({required String clothId, required String colorId}) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    print("${{'cloth_id': clothId, 'color_id': colorId}}");
    var data = {'cloth_id': clothId, 'color_id': colorId};
    String path = '$baseUrl/api/product-details';
    Options options = Options(
      contentType: Headers.jsonContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.get(path, data: data, options: options);
        log("Turban Product Response ==>>>> ${response.data}");
        log("Turban Product Response ==>>>> ${response.statusCode}");
        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.toString());
          /*TurbanProductDetailApiModal turbanProductDetailApiModal = TurbanProductDetailApiModal();
          FullvoileTurbanScreenController fullvoileTurbanScreenController = Get.put(FullvoileTurbanScreenController());
          turbanProductDetailApiModal = TurbanProductDetailApiModal.fromJson(responseData);
          fullvoileTurbanScreenController.turbanProductDetailApiModal.value = turbanProductDetailApiModal;*/
          //toAst("Turban product detail fetched successfully");
          return TurbanProductDetailApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Get Turban Product data>>>>>>>>>>');
        } else if (response.statusCode == 401) {
          throw Exception('Data type error');
        }
      } on DioException catch (e, st) {
        print("Product error: $e");
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        print("Stack: $st");
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
        if (response.statusCode == 200) {
          print("Accessory Product Response ${response.data}");
          var responseData = jsonDecode(response.toString());
          toAst("Accessory product detail fetched successfully");
          return AccessoryProductDetailApiModal.fromJson(responseData);
          /*  ProductController productController = Get.put(ProductController());
          accessoryProductDetailApiModal = AccessoryProductDetailApiModal.fromJson(responseData);
          productController.accessoryProductDetailApiModal.value = accessoryProductDetailApiModal;*/
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Get Turban Product data>>>>>>>>>>');
        }
      } on DioException catch (e, st) {
        print("Product error: $e}");
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        print("Stack: $st");
        return null;
      }
    } else {
      toAst("No Internet");
      //Fluttertoast.showToast(msg: "No Internet");
    }
  }

  static Future<dynamic> addToCartApiModal(
      {required String deviceId,
      required String colorId,
      required String brandId,
      required String clothId,
      required String price,
      required double totalPrice,
      required String size,
      required String quantity,
      required String stitch}) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    var deviceId = await SharePreferencesHelper.getString(SharedPrefKeys.DEVICE_ID);
    var data = {
      "device_id": deviceId,
      "color_id": colorId,
      "brand_id": brandId,
      "cloth_id": clothId,
      "price": price,
      "total_price": totalPrice,
      "size": size,
      "quantity": quantity,
      "center_stitch": stitch
    };
    String path = '$baseUrl/api/add-to-cart';
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.post(path, data: data, options: options);

        if (response.statusCode == 200) {
          log("${response.data}", name: "Add to cart Response");
          var responseData = jsonDecode(response.toString());
          toAst(responseData['message'].toString());
          return AddToCartApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Add Address data>>>>>>>>>>');
        }
      } on DioException catch (e, st) {
        print("Add to cart error: ${e.response!.data}");
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        print("Stack: $st");
        return null;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }

  static Future<dynamic> getAddToCartApiModal() async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    var deviceId = await SharePreferencesHelper.getString(SharedPrefKeys.DEVICE_ID);

    print(token);
    String path = 'https://nexever.tech/AkalSahae/api/getcart';
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
        }
      } on DioException catch (e, st) {
        print("Get cart error: $e");
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        print("Stack: $st");
        return null;
      }
    } else {
      toAst("No Internet");
    }
  }

/*  static Future<dynamic> getAddToCartApiModal({required String deviceId}) async {
    var token = await SharePreferencesHelper.getString(SharedPrefkeys.TOKEN);
    var deviceId = await SharePreferencesHelper.getString(SharedPrefkeys.DEVICE_ID);
    var data = {'device_id': deviceId};
    print(deviceId);
    String path = '$baseUrl/api/getcart/$deviceId';
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.get(path, data: data, options: options);

        if (response.statusCode == 200) {
          log("${response.data}", name: "Get Cart Response");

          var responseData = jsonDecode(response.toString());

          return GetAddToCartApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Get Turban Product data>>>>>>>>>>');
        }
      } on DioException catch (e, st) {
        print("Get cart error: ${e.response!.data}");
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        print("Stack: $st");
        return null;
      }
    } else {
      toAst("No Internet");
    }
  }*/

  static Future<dynamic> placeOderApiData({
    required String addressId,
  }) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);

    var data = {
      "address_id": addressId,
    };
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
          //  toAst(responseData['message'].toString());
          return PlaceOrderApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Place Order>>>>>>>>>>');
        }
      } on DioException catch (e, st) {
        print("Place order error: $e");
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        print("Stack: $st");
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
          //toAst("Orders fetched successfully");
          return GetOrderApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to get order>>>>>>>>>>');
        }
      } on DioException catch (e, st) {
        print("Place order error: ${e}");
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        print("Stack: $st");
        return null;
      }
    } else {
      toAst("No Internet");
    }
  }

  static Future<dynamic> removeApiData({required int cardId, required int quantity}) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    print(token);
    print("${{"card_id": cardId, "quantity": quantity}}");
    var data = {"card_id": cardId, "quantity": quantity};
    String path = 'https://nexever.tech/AkalSahae/api/updatecart';
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
        }
      } on DioException catch (e, st) {
        print("Remove cart error: $e $st");
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        return null;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }

  static Future<dynamic> deleteCartData({required int cartId}) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    print(token);
    print("${{
      "cart_id": cartId,
    }}");
    var data = {"cart_id": cartId};
    String path = 'https://nexever.tech/AkalSahae/api/remove-cart-item';
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );

    if (await hasNetwork()) {
      try {
        var response = await dio.post(path, data: data, options: options);

        if (response.statusCode == 200) {
          log("${response.data}", name: "Delete cart Response");
          var responseData = jsonDecode(response.toString());
          toAst(responseData['message'].toString());
          return DeleteCartApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to remove cart>>>>>>>>>>');
        }
      } on DioException catch (e, st) {
        print("Remove cart error: $e $st");
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
    print("data---> ${data}");
    String path = '$baseUrl/api/setdefaultaddress';
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.post(path, data: data, options: options);

        if (response.statusCode == 200) {
          print("Set Default Address  ${response.data}");
          DefaultResponseModal defaultResponse = DefaultResponseModal();
          var responseData = jsonDecode(response.toString());
          SaveAddressScreenController saveAddressScreenController = Get.put(SaveAddressScreenController());
          defaultResponse = DefaultResponseModal.fromJson(responseData);
          saveAddressScreenController.defaultAddressApiModal.value = defaultResponse;
          print('message-->${responseData['message'].toString()}');
          toAst(responseData['message'].toString());
          return true;
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Add Address data>>>>>>>>>>');
        }
        return true;
      } on DioException catch (e, st) {
        print("Add Address error: $e}");
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}

        print("Stack: $st");
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
      required int status}) async {
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
      "status": status
    };
    String path = '$baseUrl/api/updateaddress';
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    printData("Requesting: $data");
    printData("Token--> $token");
    if (await hasNetwork()) {
      try {
        var response = await dio.post(path, data: data, options: options);
        if (response.statusCode == 200) {
          print("update  Address ---> ${response.data}");
          var responseData = jsonDecode(response.toString());
          toAst(responseData['message'].toString());
          return true;
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Remove Address data>>>>>>>>>>');
        }
        return true;
      } on DioException catch (e, st) {
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        print("Stack: $st");
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
          print("REMOVE ADDRESS--> ${response.data}");
          RemoveResponseModal removeResponseModal = RemoveResponseModal();
          var responseData = jsonDecode(response.toString());
          SaveAddressScreenController saveAddressScreenController = Get.put(SaveAddressScreenController());
          removeResponseModal = RemoveResponseModal.fromJson(responseData);
          saveAddressScreenController.removeAddressApiModal.value = removeResponseModal;

          toAst(responseData['message'].toString());
          return true;
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Remove Address data>>>>>>>>>>');
        }
        return true;
      } on DioException catch (e, st) {
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
print("ERROR: $e");
        print("Stack: $st");
        return false;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }

  static Future<dynamic> accessoryAddToCartModal({
    required String deviceId,
    required String productId,
    required String price,
    required String totalPrice,
    required String size,
    required String quantity,
  }) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    var deviceId = await SharePreferencesHelper.getString(SharedPrefKeys.DEVICE_ID);

    var data = {
      "device_id": deviceId,
      "product_id": productId,
      "price": price,
      "total_price": totalPrice,
      "size": size,
      "quantity": quantity,
    };
    String path = 'https://nexever.tech/AkalSahae/api/add-to-cart';
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.post(path, data: data, options: options);

        if (response.statusCode == 200) {
          log("${response.data}", name: "Accessory Add to cart Response");
          var responseData = jsonDecode(response.toString());
          toAst(responseData['message'].toString());
          return AccessoryAddToCartModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Add Accessory data>>>>>>>>>>');
        }
      } on DioException catch (e, st) {
        print("Accessory to cart error: $e}");
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        print("Stack: $st");
        return null;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }
/*
  static Future<dynamic> addToFavoriteCartApi(
      {required int productId,
      required String id,
      required String colorId,
      required String brandId,
      required int clothId,
      required String images,
      required String price,
      required String size,
      required String description,
      required bool isFavorite}) async {
    var token = await SharePreferencesHelper.getString(SharedPrefkeys.TOKEN);
    var data = {
      "id": id,
      "product_id": productId,
      "color_id": colorId,
      "brand_id": brandId,
      "cloth_id": clothId,
      "price": price,
      "images": images,
      "size": size,
      "description": description,
      "is_favorite": isFavorite
    };
    printData("dataFav--->$data");
    String path = '$baseUrl/api/add-to-favorites';
    Options options = Options(
      contentType: Headers.jsonContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.post(path, data: data, options: options);
        if (response.statusCode == 200) {
          printData("favvvvResp----->${response.data}");
          log("${response.data}", name: "Add to Fav Response");
          var responseData = jsonDecode(response.toString());
          toAst(responseData['message'].toString());
          return AddToFavoriteApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Add Address data>>>>>>>>>>');
        }
      } on DioException catch (e, st) {
        print("Dio Error: ${e.response?.statusCode}");
        print("Response Data: ${e.response?.data}");
        print("Error while adding to favorites: $e");
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        print("Stack: $st");
        return null;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }*/

  static Future<dynamic> logOutApi() async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    print("Token: $token");
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
          throw Exception('Data type error');
        }
      } on DioException catch (e, st) {
        print("Log Out Error: $e");
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        print("Stack: $st");
        throw Exception('Data type error');
      }
    } else {
      toAst("No Internet");
    }
  }


  static Future<dynamic> addToFavoriteCartApi(
      {required int productId,
        required String productVariation,
        required bool isFavorite}) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    var data = {
      "product_variation_id": productVariation,
      "product_id": productId,
      "is_favorite": isFavorite
    };
    printData("dataFav--->$data");
    String path = '$baseUrl/api/add-to-favorites';
    Options options = Options(
      contentType: Headers.jsonContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.post(path, data: data, options: options);
        if (response.statusCode == 200) {
          printData("favvvvResp----->${response.data}");
          log("${response.data}", name: "Add to Fav Response");
          var responseData = jsonDecode(response.toString());
          toAst(responseData['message'].toString());
          return AddToFavoriteApiModal.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Add Address data>>>>>>>>>>');
        }
      } on DioException catch (e, st) {
        print("Dio Error: ${e.response?.statusCode}");
        print("Response Data: ${e.response?.data}");
        print("Error while adding to favorites: $e");
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        print("Stack: $st");
        return null;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }



  static Future<dynamic> getFavList() async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    String path = '$baseUrl/api/get-to-favorites';
    Options options = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {Headers.acceptHeader: 'application/json', "Authorization": "Bearer $token"},
    );
    if (await hasNetwork()) {
      try {
        var response = await dio.get(path,  options: options);

        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.toString());
          print("GetFav Response: ${responseData}");
          //  toAst(responseData['message'].toString());
          return GetFavListModel.fromJson(responseData);
        } else if (response.statusCode == 400) {
          throw Exception('<<<<<<<<<<Failed to Place Order>>>>>>>>>>');
        }
      } on DioException catch (e, st) {
        print("Place order error: $e");
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        print("Stack: $st");
        return null;
      }
    } else {
      toAst("No Internet");
      return false;
    }
  }

  static Future<dynamic> accessoryAddToFavoriteCartApi(
      {required int productId,
        required bool isFavorite}) async {
    var token = await SharePreferencesHelper.getString(SharedPrefKeys.TOKEN);
    var data = {
      "product_id": productId,
      "is_favorite": isFavorite
    };
    printData("dataFav--->$data");
    String path = 'https://nexever.tech/AkalSahae/api/add-to-favorites';
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
        }
      } on DioException catch (e, st) {
        print("Dio Error: ${e.response?.statusCode}");
        print("Response Data: ${e.response?.data}");
        print("Error while adding to favorites: $e");
        if (e.type == DioExceptionType.connectionTimeout) {}
        if (e.type == DioExceptionType.receiveTimeout) {}
        print("Stack: $st");
        print("ERROR $e");
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
        backgroundColor: Color(0xffFF9900),
        textColor: Colors.black,
        fontSize: 10.sp);
  }
}

void printData(object) {
  String message = "$object";
  if (kDebugMode) {
    print(message);
  }
}
