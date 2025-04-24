import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_color.dart';

class WasteCollectionStatusScreen extends StatelessWidget {
  const WasteCollectionStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        title: Text('Collection Status',style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.only(top: 25),
                color: Colors.white,
                child: Container(
                  width: Get.width * 0.94,
                  padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: AppColor.acceptBackgroundColor,
                        ),
                        child: Icon(Icons.check_circle_outline,color: Colors.green,size: 25,),
                      ),
                      Text('Waste Collection is in Progress',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700)),
                      Text('Estimated arrival in 25 mins',style: TextStyle(color: AppColor.grayTextColor,fontSize: 16),)
                    ],
                  ),
                ),
              ),
              //------------Collection Progress
              Card(
                margin: EdgeInsets.only(top: 25),
                color: Colors.white,
                child: Container(
                  width: Get.width * 0.94,
                  padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Collection Progress',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
                      SizedBox(height: 20),
                      Row(children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            color: AppColor.acceptBackgroundColor,
                          ),
                          child: Icon(Icons.check,color: Colors.green,size: 25,),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('  Request confirmed'),
                            Text('  10:30 AM',style: TextStyle(color: AppColor.grayTextColor)),
                          ],
                        ),
                      ]),
                      SizedBox(height: 20,),
                      Row(children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            color: Colors.blue.shade100,
                          ),
                          child: Icon(Icons.circle,color: Colors.blue,size: 25,),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('  Collector Assigned'),
                            Text('  10:45 AM',style: TextStyle(color: AppColor.grayTextColor)),
                          ],
                        ),
                      ]),
                      SizedBox(height: 20,),
                      Row(children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            color: Colors.grey.shade100,
                          ),
                          child: Icon(Icons.circle,color: Colors.grey,size: 25,),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('  Waste Collection'),
                            Text('  Pending',style: TextStyle(color: AppColor.grayTextColor)),
                          ],
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 25),
                color: Colors.white,
                child: Container(
                  width: Get.width * 0.94,
                  padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Collector Details',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18)),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: Image(image: AssetImage('assets/images/man.png')),
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('   John Smith',style: TextStyle(fontSize: 15),),
                                    Text('   ID: #WC12345',style: TextStyle(color: AppColor.grayTextColor,fontSize: 13))
                                  ]),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: AppColor.acceptBackgroundColor,
                            ),
                            child: Icon(Icons.phone_outlined,color: Colors.green,size: 25,),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),

              //--------------------------cancel collection button
              
              Container(
                margin: EdgeInsets.only(top: 20,bottom: 15),
                width: Get.width * 0.94,
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.red.shade700,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Center(child: Text('Cancel Collection',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
