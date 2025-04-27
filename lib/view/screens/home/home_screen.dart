import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_clean/view/screens/request/request_screen.dart';
import 'package:smart_clean/view/screens/home/home_controller.dart';
import 'package:smart_clean/view/widgets/main_container/container_widget.dart';

import '../../../constants/app_color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.appBarColor,
            leading: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Image(image: AssetImage('assets/images/man.png')),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello John",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Let's keep our city clean",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.toNamed('notification');
                },
                icon: Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 15),
            ],
          ),

          body: RefreshIndicator(
            onRefresh: () => ctrl.getActivities(),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Column(
                  spacing: 10,
                  children: [
                    // ----------- Report Waste and My Reports
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ContainerWidget(
                          title: 'Report Waste',
                          textColor: AppColor.appWhiteColor,
                          icon: Icons.camera_alt_outlined,
                          iconColor: AppColor.appWhiteColor,
                          onTap: () {
                            ctrl.openCamera();
                          },
                          color: AppColor.appBarColor,
                        ),
                        ContainerWidget(
                          title: 'My Report',
                          textColor: AppColor.acceptedTextColor,
                          icon: Icons.pending_actions_outlined,
                          iconColor: AppColor.appBarColor,
                          onTap: () => {},
                          color: AppColor.acceptBackgroundColor,
                        ),

                        // ContainerWidget(title: 'Report Waste', textColor: AppColor.appWhiteColor, icon: Icons.camera_alt_outlined,iconColor: AppColor.appWhiteColor,onTap: () => {},)
                      ],
                    ),
                    //-------------- Recent Activity
                    Card(
                      elevation: 2,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Recent Activity',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: ctrl.activityList.length,
                              itemBuilder: (context, index) {
                                final activity = ctrl.activityList[index];
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => CollectionProgress(
                                      wasteCollectedTime: activity.completedAt != null
                                          ? DateFormat('d MMMM, h:mm a').format(activity.completedAt!)
                                          : 'Pending',
                                      collectorAssignedTime: activity.acceptedAt != null
                                          ? DateFormat('d MMMM, h:mm a').format(activity.acceptedAt!)
                                          : 'Pending',
                                      requestConfirmedTime: activity.createdAt != null
                                          ? DateFormat('d MMMM, h:mm a').format(activity.createdAt!)
                                          : 'Pending',
                                      currentStatus: activity.status ?? 'Pending',
                                    ));
                                  },

                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: 5,
                                    ), // spacing between tiles
                                    decoration: BoxDecoration(
                                      color:
                                          Colors
                                              .grey[200], // 💡 Set your desired background color here
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ListTile(
                                      // contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      title: Text(
                                        activity.status ?? '',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      subtitle: Text(activity.address ?? ''),
                                      leading:
                                          activity.status == 'Completed'
                                              ? Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                  color:
                                                      AppColor
                                                          .acceptBackgroundColor,
                                                ),
                                                child: Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                  size: 25,
                                                ),
                                              )
                                              : Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                  color:
                                                      AppColor
                                                          .pendingBackgroundColor,
                                                ),
                                                child: Icon(
                                                  Icons.watch_later_outlined,
                                                  color:
                                                      AppColor.pendingTextColor,
                                                  size: 25,
                                                ),
                                              ),
                                      trailing: Text(
                                        ctrl.getTimeDifferenceText(
                                          activity.createdAt!,
                                        ),
                                        style: TextStyle(
                                          color: AppColor.appBlackColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
