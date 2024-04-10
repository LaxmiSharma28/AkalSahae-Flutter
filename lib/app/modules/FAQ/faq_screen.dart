import 'package:akalsahae/helper_widget/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FAQ_Screen extends StatefulWidget {
  const FAQ_Screen({Key? key}) : super(key: key);

  @override
  State<FAQ_Screen> createState() => _FAQ_ScreenState();
}

class _FAQ_ScreenState extends State<FAQ_Screen> {
  AppColors appColors=AppColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor:appColors.blackColor,
        toolbarHeight: 3.h,
        bottom: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor:appColors.blackColor,
          title: Text('FAQs',
              style: TextStyle(fontSize: 14.sp, fontFamily: "Poppins",color:Colors.white)),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              size: 14.sp,
            ),
            onPressed: () {
              // Get.back();
              Get.back();
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w,vertical: 2.h),
        child: Material(
          elevation: 10.sp, // Change the elevation value as needed
          borderRadius: BorderRadius.circular(5.sp),
          color:appColors.grayColor,
          child: Container(
            height:100.h,
            padding: EdgeInsets.symmetric(horizontal:5.w),
            width: MediaQuery.of(context).size.width,
            child:ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final question = questions[index]['question'];
                final answer = questions[index]['answer'];
                return Column(
                  children: [
                    SizedBox(height:2.h,),
                    Theme(
                      data: ThemeData(dividerColor: Colors.transparent,),
                      child: ExpansionTile(
                        collapsedIconColor: appColors.whiteColor,
                        iconColor: appColors.darkYellowColor,
                        title: Text(question!,style: TextStyle(color:appColors.whiteColor,fontFamily: 'Arial',)),
                        children: [
                          SizedBox(height: 1.h,),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w,),
                            child: Text(answer!,style: TextStyle(color:appColors.whiteColor,fontFamily: 'Arial')),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },

            ),

          ),
        ),
      ),
    );
  }

}
final questions = [
  {
    'question': 'What are the benefits of using LockerApp?',
    'answer': 'LockerApp will help you to save your documents in device with security.'
        'Important Documents Anytime, Anywhere !'
  },
  {
    'question': 'Is it safe to put my documents on LockerApp?',
    'answer': 'Yes definitely, this is a secure App to protect your data.'
  },
  {
    'question': 'What are the key components of LockerApp?',
    'answer': 'Home,View Documents,Upload,Delete and Share your documents.'
  },
  {
    'question': ' How can I sign up for LockerApp?',
    'answer': 'It is very easy to signing up LockerApp.All you need is your Full Name,E-mail and password to create your account.'
  },
  {
    'question': 'What is PIN Code?',
    'answer': 'PIN Code is a random 4-digits number which can be generated by you to lock your App and make it protected from others.'
  },
  {
    'question': 'How to Reset PIN?',
    'answer': 'Click on Forgot PIN.Then, enter your Email and one security answer,then Click one Reset PIN. In this way ,you can get your PIN.'
  },
  {
    'question': 'How can I upload my documents to LockerApp?',
    'answer': 'You can firstly click on type of card you want to upload,then add document by clicking on (+) button and then save it.'
  },
  {
    'question': 'What types of files can be uploaded?',
    'answer': 'File types that can be uploaded- pdf, jpeg & png.'
  },
  {
    'question': 'What is the max file size that can be uploaded?',
    'answer': 'Maximum allowed file size is: 5MB.'
  },
];