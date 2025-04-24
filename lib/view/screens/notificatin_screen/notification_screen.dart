import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_color.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        title: Text('Notification',style: TextStyle(color: Colors.white)),
        actions: [
          Text('Mark all as read',style: TextStyle(color: Colors.white)),
          SizedBox(width: 10,)
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Today',style: TextStyle(color: AppColor.grayTextColor),),
            ),
            Card(
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                width: Get.height * 0.94,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.acceptBackgroundColor,
                      ),
                      child: Icon(Icons.check_circle_outline,color: AppColor.acceptedTextColor,size: 25,),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Waste Collection Confirmed',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700)),
                        // Text('Your waste report has been verified and scheduled for collection.',style: TextStyle(color: AppColor.grayTextColor,fontSize: 14),maxLines: 2,overflow: TextOverflow.ellipsis,),
                        Text('2 Hours ago',style: TextStyle(color: AppColor.grayTextColor,fontSize: 12))
                      ],
                    ),
                    Icon(Icons.circle,color: Colors.green,size: 20)
                  ],
                ),
              ),
            ),
            Card(
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                width: Get.height * 0.94,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blue.shade100,
                      ),
                      child: Icon(Icons.badge_outlined,color: Colors.blue.shade700,size: 25,),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Collector Arrived',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700)),
                        // Text('Waste collector has arrived at your location.',style: TextStyle(color: AppColor.grayTextColor,fontSize: 14),maxLines: 2,overflow: TextOverflow.ellipsis,),
                        Text('5 Hours ago',style: TextStyle(color: AppColor.grayTextColor,fontSize: 12))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Earlier',style: TextStyle(color: AppColor.grayTextColor),),
            ),
            Card(
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                width: Get.height * 0.94,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade300,
                      ),
                      child: Icon(Icons.check,color: AppColor.grayTextColor,size: 25,),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Collection CompletedConfirmed',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700)),
                        // Text('Previous waste collection has been completed successfully.',style: TextStyle(color: AppColor.grayTextColor,fontSize: 14),maxLines: 2,overflow: TextOverflow.ellipsis,),
                        Text('3 Days ago',style: TextStyle(color: AppColor.grayTextColor,fontSize: 12))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
