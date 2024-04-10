import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:akalsahae/app/modules/splash_screen_module/splash_screen_controller.dart';

class SplashScreenPage extends GetView<SplashScreenController> {
  final splashScreenController=Get.find<SplashScreenController>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      //<-- For Android SEE HERE (dark icons)
      statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent
    ));
    return GetBuilder(
      init: splashScreenController,
      builder: (context) {
        return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/images/Splash_SCreen_Mobile .png"),
                      fit: BoxFit.fill)
              ),
            )
        );
      }
    );
  }
}
