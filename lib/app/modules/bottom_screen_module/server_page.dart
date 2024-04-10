// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:akalsahae/helper_widget/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class ServerMaintenanceScreenPage extends StatelessWidget {
  ServerMaintenanceScreenPage({super.key,required this.title,required this.message});
  String title;
  String message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Colors.black,
        body: WillPopScope(
          onWillPop: () async {
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else if (Platform.isIOS) {
              exit(0);
            }
            return false;
          },
          child: Center(
            child: Padding(
              padding:EdgeInsets.symmetric(horizontal:3.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text(title, style: const TextStyle(fontSize: 18.0,fontFamily: "Poppins", fontWeight: FontWeight.bold,color: Colors.white)),
                  const SizedBox(height: 16.0),
                  Text(message, textAlign:TextAlign.center,style: const TextStyle(fontSize: 16.0,color:Colors.white,fontFamily: "Poppins")),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      if (Platform.isAndroid) {
                        SystemNavigator.pop();
                      } else if (Platform.isIOS) {
                        exit(0);
                      }
                    },
                    child: Padding(
                      padding:  EdgeInsets.only( top: 10,bottom:8.h),
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 100,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors().darkYellowColor,
                        ),
                        child: Text(
                          "Exit",
                          style: TextStyle(
                              letterSpacing: 1.5,
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
