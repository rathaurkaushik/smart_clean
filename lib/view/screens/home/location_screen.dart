import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_clean/constants/app_color.dart';
import 'package:smart_clean/view/screens/home/location_controller.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(LocationController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        title: const Text(
          "Location",
          style: TextStyle(
            color: AppColor.appWhiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_new, color: AppColor.appWhiteColor),
        ),
        // centerTitle: true,
      ),
      body: Obx(() {
        final latLng = ctrl.currentLatLng.value;
        final address = ctrl.currentAddress.value;

        if (latLng == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              spacing: 10,
              children: [
                // Google Map in a fixed height container
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: GoogleMap(
                      compassEnabled: true,
                      zoomControlsEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: latLng,
                        zoom: 160,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId("current_location"),
                          position: latLng,
                          infoWindow: const InfoWindow(title: "You are here"),
                        ),
                      },
                      onMapCreated: ctrl.onMapCreated,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                    ),
                  ),
                ),
                // Address & refresh
                Container(
                  // margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on, color: Colors.green),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Current Location",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(address ?? "Fetching address..."),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh, color: Colors.green),
                        onPressed: ctrl.refreshLocation,
                      ),
                    ],
                  ),
                ),

                ///status info
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.appWhiteColor,
                  boxShadow: [
                    BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                  ],
                  ),
                  padding: EdgeInsets.all(16),

                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Tracking Status",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade200,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "Active",
                              style: TextStyle(
                                color: AppColor.appBarColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.circle,
                            color: Colors.green,
                            size: 10,
                          ),
                          const SizedBox(width: 8),
                          const Text("Tracking Status: High"),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.circle,
                            color: Colors.green,
                            size: 10,
                          ),
                          const SizedBox(width: 8),
                          const Text("GPS signal: Strong "),
                        ],
                      ),
                    ],
                  ),
                ),
                /// confirm button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back(result: address );
                    },
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        AppColor.appBarColor,
                      ),
                    ),
                    child: Text(
                      'Confirm Location',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.appWhiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
