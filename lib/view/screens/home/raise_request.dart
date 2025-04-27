import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:smart_clean/constants/app_color.dart';
import 'package:smart_clean/view/screens/home/home_controller.dart';
import 'package:smart_clean/view/screens/home/location_controller.dart';
import 'package:smart_clean/view/screens/home/location_screen.dart';
import 'package:smart_clean/view/widgets/buildCard/build_card.dart';
import 'package:smart_clean/view/widgets/button_widgets.dart';

class RaiseRequest extends StatelessWidget {
  final File imagePath;

  const RaiseRequest({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final address = Get.put(LocationController());

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColor.appBarColor,
            title: Text(
              "Raise Request",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.appWhiteColor,
              ),
            ),
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColor.appWhiteColor,
                )
            )
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Column(
              children: [

                /// Image
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: FileImage(imagePath), // Use FileImage
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 10),

                /// Location button
                ButtonWidgets(
                  title: 'Location Tracker',
                  backgroundColor: AppColor.userLocation,
                  color: AppColor.numberHeighlightedColor,
                  icon: Icons.location_on_outlined,
                  onTap: () async {
                    String? result = await Get.to(() => LocationScreen());
                    if (result != null) {
                      ctrl.updateSelectedLocation(result); // ✅ Use this instead of direct assignment
                    }
                  },
                ),

                /// Show selected Location
                if (ctrl.selectedLocation != null) ...[
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColor.appWhiteColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.appWhiteColor,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on, color: Colors.red),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              ctrl.selectedLocation!,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 10),

                /// Submit button with loading spinner
                Obx(() {
                  return Stack(
                    children: [
                      ButtonWidgets(
                        title: ctrl.isLoading.value
                            ? 'Submitting...'  // Change text while loading
                            : 'Confirm & Submit Report',
                        backgroundColor: AppColor.appBarColor,
                        color: AppColor.appWhiteColor,
                        onTap: ctrl.isLoading.value
                            ? null  // Disable button while loading
                            : () {
                          ctrl.sendRequestData(
                              imagePath,
                              address.currentAddress.value ?? "NO IMAGE PATH"
                          );
                        },
                      ),
                      if (ctrl.isLoading.value)
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(AppColor.appWhiteColor),
                            ),
                          ),
                        ),
                    ],
                  );
                }),

                SizedBox(height: 10),

                /// Retake Photo button
                ButtonWidgets(
                  title: 'Retake Photo',
                  backgroundColor: AppColor.appWhiteColor,
                  color: AppColor.appBlackColor,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
