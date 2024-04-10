import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class DeviceInfo{
  String getDeviceType() {
    if (Platform.isAndroid) {
      return "android";
    } else if (Platform.isIOS) {
      return "ios";
    } else {
      return "";
    }
  }
  Future<String> getDeviceID() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor!; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return "";
  }

  Future<String> getDeviceModel() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.model; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.model; // unique ID on Android
    }
    return "";
  }

  Future<String> getDeviceName() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      return "apple"; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.brand; // unique ID on Android
    }
    return "";
  }

  Future<String> getBuildVersion() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      return "apple"; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.version.codename; // unique ID on Android
    }
    return "";
  }

  Future<String> getBuildNumber() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.utsname.sysname; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return "${androidDeviceInfo.version.sdkInt}"; // unique ID on Android
    }
    return "";
  }

  Future<String> getOSVersion() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.utsname.version; // uni
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.version.release; // unique ID on Android
    }
    return "";
  }

  //String fcmToken = 'f8R26w5GQGawcKUE9KDWsc:APA91bGc5pBlSU2tvLT1k45Pc1v-32MeWarKEc91tgTtZ-exYBTAr_qudITCRbIz7he5K0Q_ojFLJi9G8oglKwqKn-PTgsBZskSl7s8qXEc4gDb87XZKx0Wj-aLUa6glv54ct98nQjyK';

  Future<String?> getFcmToken() async {
    final FirebaseMessaging messaging = FirebaseMessaging.instance;

    String? token = await messaging.getToken();
    print('FCM Token: $token');
    return token;
  }


}