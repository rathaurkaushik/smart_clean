import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_clean/constants/app_color.dart';
import 'package:smart_clean/view/screens/profile/profile_controller.dart';
import 'package:smart_clean/view/screens/profile/resetAccount.dart';
import 'package:smart_clean/view/screens/utils/custom_widgets.dart';
import 'package:smart_clean/view/screens/utils/first_letter.dart';
class ProfileScreen extends StatelessWidget {

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController ctrl = Get.put(ProfileController());

    /// Get uid from firebase Auth
    final String uid = FirebaseAuth.instance.currentUser!.uid;

    /// fetch user data
    ctrl.getUsersData(uid);

    ///
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.blue.shade600, Colors.green.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          ),
        ),

      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              // Profile Section
              Container(
                width: screenWidth,
                height: screenHeight * 0.25,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade600, Colors.green.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Image.asset('assets/images/man.png'),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      ctrl.user.value!.name ?? "No Name",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      ctrl.user.value!.email ?? "No Name",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 50),

              // Personal Info Card
              CustomWidgets().buildCard(
                title: "Personal Information",
                children: [
                  CustomWidgets().buildInfoRow(
                      Colors.deepPurple[200]!,
                      Icon(
                        Icons.email_outlined,
                        color: Colors.deepPurple,
                      ),
                      "Email",
                      ctrl.user.value!.email ?? "Not Available"),
                  CustomWidgets().buildInfoRow(
                      Colors.yellow[200]!,
                      Icon(
                        Icons.call,
                        color: Colors.amberAccent,
                      ),
                      "Phone",
                      ctrl.user.value!.phone ?? "Not Available"),
                ],
              ),

              /// Notification
              ///
              // CustomWidgets().buildCard(
              //   title: "Notification",
              //   children: [
              //     CustomWidgets().buildNotificationCard(
              //       Colors.lightBlue[200]!,
              //       Icon(CupertinoIcons.bell, color: Colors.blue),
              //       'Push Notification',
              //       'For new requests and updates',
              //       false,
              //
              //       ///on toggle
              //       () {
              //         // toggle logic
              //       },
              //     ),
              //     // CustomWidgets().buildNotificationCard(
              //     //   Colors.lightGreen[200]!,
              //     //   Icon(CupertinoIcons.mail, color: Colors.green),
              //     //   'Summary',
              //     //   'Daily summary and report',
              //     //   false,
              //     //
              //     //   ///on toggle
              //     //   () {
              //     //     // toggle logic
              //     //   },
              //     // ),
              //   ],
              // ),

              ///  Help and Support
              ///
              CustomWidgets().buildCard(
                title: "Help & Support",
                children: [
                  CustomWidgets().buildHelpSupportCard(
                    Colors.red[100]!,
                    Icon(CupertinoIcons.exclamationmark_circle,
                        color: Colors.red),
                    'FaQs and support ',
                    true
                  ),
                  CustomWidgets().buildHelpSupportCard(
                    Colors.grey[200]!,
                    Icon(CupertinoIcons.question_circle, color: Colors.black),
                    'Version 1.0.0',
                  false
                  ),
                ],
              ),

              /// Reset Account Button
              CustomWidgets().buildButtonCard(
                  context,
                  CupertinoIcons.delete,
                  "Reset Account",
                  Colors.grey[300],
                  "Reset Account",
                  "Are you sure you want to reset your account? This cannot be undone.",
                  "Reset", () {
                // reset account screen
                Get.to(()=> ResetAccountScreen());
              }, () {}, textColor: Colors.black),

              // Logout Button
              CustomWidgets().buildButtonCard(
                  context, Icons.logout, "Logout", Colors.red, "Logout",
                  "Are you sure you want to logout your account?",
                  "Logout", () {
                ctrl.logout();
              }, () {}, textColor: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade700,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
