import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_clean/constants/app_color.dart';

class CollectionProgress extends StatelessWidget {
  final String requestConfirmedTime;
  final String collectorAssignedTime;
  final String wasteCollectedTime;
  final String currentStatus;

  const CollectionProgress({
    super.key,
    required this.requestConfirmedTime,
    required this.collectorAssignedTime,
    required this.wasteCollectedTime,
    required this.currentStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        title: Text('Collection Status', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
      leading: IconButton(onPressed: (){
        Get.back();
    }, icon: Icon(Icons.arrow_back_ios,color: AppColor.appWhiteColor,),
      ),
      ),
      body:
      Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Collection Progress',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              /// Step 1 - Request Confirmed
              _buildStep(
                title: "Request Confirmed",
                time: requestConfirmedTime,
                isCompleted: currentStatus != 'Pending',
                isCurrent: currentStatus == 'Pending',
              ),

              /// Step 2 - Collector Assigned
              _buildStep(
                title: "Collector Assigned",
                time: collectorAssignedTime,
                isCompleted: currentStatus == 'Accepted' || currentStatus == 'Completed',
                isCurrent: currentStatus == 'Accepted',
              ),

              /// Step 3 - Waste Collected
              _buildStep(
                title: "Waste Collected",
                time: currentStatus == 'Completed' ? wasteCollectedTime : 'Pending',
                isCompleted: currentStatus == 'Completed',
                isCurrent: currentStatus == 'Completed',
              ),
            ],
          ),
        ),
      ),

    );
  }

  Widget _buildStep({
    required String title,
    required String time,
    required bool isCompleted,
    required bool isCurrent,
  }) {
    Color color;
    if (isCompleted) {
      color = Colors.green.shade100;
    } else if (isCurrent) {
      color = Colors.blue;
    } else {
      color = Colors.grey;
    }

    return Card(
      margin: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Container(
        width: Get.width * 0.94,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text('Collection Progress',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: color,
                  ),
                  child: Icon(
                    isCompleted ? Icons.check : Icons.circle,
                    size: 25,
                    color: isCompleted ? Colors.green : Colors.grey.shade200,
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      time,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
