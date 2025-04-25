import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_clean/constants/app_color.dart';
import 'package:smart_clean/view/screens/notificatin_screen/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject the NotificationController

    return GetBuilder<NotificationController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.appBarColor,
          title: const Text(
              'Notification', style: TextStyle(color: Colors.white)),
          actions: [
            TextButton(
              onPressed: () {
                // Optional: Add logic to mark all as read
              },
              child: const Text(
                  'Mark all as read', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                    'Today', style: TextStyle(color: AppColor.grayTextColor)),

                const SizedBox(height: 10),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ctrl.activityList.length,
                  itemBuilder: (context, index) {
                    final activity = ctrl.activityList[index];
                    return Card(
                      color: AppColor.appWhiteColor,
                      child: ListTile(
                        title: Text(
                          activity.status ?? '',
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(activity.address ?? ''),
                        leading: activity.status == 'Completed'
                            ? Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: AppColor.acceptBackgroundColor,
                          ),
                          child: const Icon(
                              Icons.check, color: Colors.green, size: 25),
                        )
                            : Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: AppColor.pendingBackgroundColor,
                          ),
                          child: Icon(Icons.watch_later_outlined,
                              color: AppColor.pendingTextColor, size: 25),
                        ),
                        trailing: Text(
                          ctrl.getTimeDifferenceText(activity.createdAt!),
                          style: const TextStyle(
                            color: AppColor.appBlackColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  },
                ),


              ],
            ),
          ),
        ),
      );
    });
  }


}
