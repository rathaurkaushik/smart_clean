import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_color.dart';

class WasteVerificationScreen extends StatelessWidget {
  const WasteVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        title: Text('Waste Verification',style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        color: AppColor.completeBackgroundColor,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: Get.height * 0.4,
                  width: Get.width * 0.94,
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xC8424242)
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image_outlined,color: AppColor.grayTextColor,size: 90,),
                          SizedBox(height: Get.height * 0.02,),
                          Text('Please wait while we verify the waste',style: TextStyle(color: AppColor.grayTextColor,fontSize: 18,),)
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(color: Colors.white,),
                          SizedBox(height: Get.height * 0.04,),
                          Text('Analyzing Image',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              //--------------------------Verification details
              Card(
                color: Colors.white,
                margin: EdgeInsets.only(top: 20),
                child: Container(
                  width: Get.width * 0.95,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('  Verification Detail', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: Get.height * 0.09,
                            width: Get.width * 0.43,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.acceptBackgroundColor,
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.check_circle_outline,color: Colors.green,size: 25,),
                                Text(' Valid Waste',style: TextStyle(color: AppColor.acceptedTextColor),)
                              ],
                            ),
                          ),
                          Container(
                            height: Get.height * 0.09,
                            width: Get.width * 0.45,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.acceptBackgroundColor,
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.location_on_outlined,color: AppColor.numberHeighlightedColor,size: 25,),
                                Text(' Location Tracked',style: TextStyle(color: AppColor.numberHeighlightedColor),)
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: Get.width * 0.95,
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(top: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade400,width: 1.5)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Identify Waste Type',style: TextStyle(fontSize: 16),),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: AppColor.acceptBackgroundColor,
                                  ),
                                  child: Icon(CupertinoIcons.trash,color: AppColor.acceptedTextColor,size: 30,),
                                ),
                                Text('Recyclable Waste',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),)
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //--------------Buttons
              Container(
                width: Get.width * 0.95,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: AppColor.acceptedTextColor,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Text('Conform & Submit Report',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
              ),
              Container(
                width: Get.width * 0.95,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 8,bottom: 15),
                padding: EdgeInsets.all(13),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1)
                ),
                child: Text('Retake Photo',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
