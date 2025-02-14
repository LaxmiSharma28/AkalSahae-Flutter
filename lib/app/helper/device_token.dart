// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DeviceToken {
  Future<String?> getDeviceToken() async {
    String? deviceToken = '@';
    try {
      deviceToken = await FirebaseMessaging.instance.getToken();
    } catch (e) {
      print(e.toString());
    }
    if (deviceToken != null) {
      debugPrint('--------Device Token---------- ' + deviceToken);

    }
    return deviceToken;
  }
}
