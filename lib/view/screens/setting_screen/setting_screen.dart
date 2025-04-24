import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_color.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        title: Text('Setting',style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Account',style: TextStyle(color: AppColor.grayTextColor),),
              ),
              Card(
                color: Colors.white,
                child: Container(
                  width: Get.width * 0.94,
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blue.shade50,
                        ),
                        child: Icon(Icons.person,color: Colors.blue.shade700,size: 25),
                      ),
                      Text('Personal Information',style: TextStyle(fontSize: 18),),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ),
              ),
              Card(
                color: Colors.white,
                child: Container(
                  width: Get.width * 0.94,
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.purple.shade50,
                        ),
                        child: Icon(Icons.lock,color: Colors.purple.shade700,size: 25),
                      ),
                      Text('Security                    ',style: TextStyle(fontSize: 18),),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Notification',style: TextStyle(color: AppColor.grayTextColor),),
              ),
              Card(
                color: Colors.white,
                child: Container(
                  width: Get.width * 0.94,
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.yellow.shade100,
                        ),
                        child: Icon(Icons.notifications_none,color: Colors.yellow.shade700,size: 25),
                      ),
                      Text('Push Notification',style: TextStyle(fontSize: 18),),
                      Icon(Icons.toggle_off_outlined)
                    ],
                  ),
                ),
              ),
              Card(
                color: Colors.white,
                child: Container(
                  width: Get.width * 0.94,
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blue.shade50,
                        ),
                        child: Icon(Icons.email,color: Colors.blue.shade700,size: 25),
                      ),
                      Text('Email Notification',style: TextStyle(fontSize: 18),),
                      Icon(Icons.toggle_off_outlined)
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('App Settings',style: TextStyle(color: AppColor.grayTextColor)),
              ),

              Card(
                color: Colors.white,
                child: Container(
                  width: Get.width * 0.94,
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColor.acceptBackgroundColor,
                        ),
                        child: Icon(Icons.language_outlined,color: AppColor.acceptedTextColor,size: 25),
                      ),
                      Text('Language',style: TextStyle(fontSize: 18),),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ),
              ),
              Card(
                color: Colors.white,
                child: Container(
                  width: Get.width * 0.94,
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.red.shade50,
                        ),
                        child: Icon(Icons.delete,color: Colors.red.shade700,size: 25),
                      ),
                      Text('Clear Cache',style: TextStyle(fontSize: 18),),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('About',style: TextStyle(color: AppColor.grayTextColor)),
              ),

              Card(
                color: Colors.white,
                child: Container(
                  width: Get.width * 0.94,
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade200,
                        ),
                        child: Icon(Icons.help_outline_rounded,color: Colors.grey.shade700,size: 25),
                      ),
                      Text('Help & Support',style: TextStyle(fontSize: 18),),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ),
              ),
              Card(
                color: Colors.white,
                child: Container(
                  width: Get.width * 0.94,
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade200,
                        ),
                        child: Icon(Icons.privacy_tip_outlined,color: Colors.grey.shade700,size: 25),
                      ),
                      Text('Privacy Policy',style: TextStyle(fontSize: 18),),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                margin: EdgeInsets.only(top: 30,bottom: 20),
                width: Get.width * 0.95,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.red.shade100
                ),
                child: Text('Sign Out',style: TextStyle(color: Colors.red,fontSize: 18),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
