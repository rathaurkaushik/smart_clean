import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_clean/constants/app_color.dart';
import 'package:smart_clean/view/screens/auth/auth_controller.dart';
import 'package:smart_clean/view/screens/profile/profile_controller.dart';
import 'package:smart_clean/view/screens/utils/custom_widgets.dart';
class ResetAccountScreen extends StatelessWidget {
  const ResetAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    double screenHeight = Get.height;

    return GetBuilder<ProfileController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.appBarColor,

          title: Text('Reset',style: TextStyle(color: AppColor.appWhiteColor,fontWeight: FontWeight.bold),),
        leading: IconButton(onPressed: ()=> Get.back(),icon: Icon(Icons.arrow_back_ios,color: AppColor.appWhiteColor,) ,),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: screenHeight * 0.01),

                        buildInputCard(
                          icon: Icons.person_outline,
                          hintText: 'Enter your name',
                          controller: ctrl.nameController,
                        ),
                        SizedBox(height: screenHeight * 0.01),


                        buildInputCardWithCountryCode(
                          hintText: 'Enter your phone number',
                          controller: ctrl.numberController,
                        ),


                        SizedBox(height: screenHeight * 0.01),

                        // Email Field
                        buildInputCard(
                          icon: Icons.email_outlined,
                          hintText: 'Enter your email',
                          controller: ctrl.emailController,
                        ),

                        SizedBox(height: screenHeight * 0.01),

                        // Password Field + Forgot Password
                        buildInputCard(
                          icon: Icons.lock_outline,
                          hintText: 'Enter your password',
                          isPassword: true, controller: ctrl.passwordController,
                        ),
                        SizedBox(height: screenHeight * 0.01),

                        buildInputCard(
                          icon: Icons.lock_outline,
                          hintText: 'Confirm password',
                          isPassword: true, controller: ctrl.confirmPasswordController,
                        ),

                        SizedBox(height: screenHeight * 0.02),

                        // Login Button
                        Form(
                          // key: ctrl.formKey,
                          child: SizedBox(
                            width: double.infinity,
                            child: Obx(() => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.appBarColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 5,
                              ),
                              onPressed: () async {
                                await ctrl.resetAccount(uid); // Wait for sign-up completion

                              },
                              child: ctrl.isLoading.value
                                  ? SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: AppColor.appWhiteColor,
                                  valueColor: AlwaysStoppedAnimation<Color>(AppColor.appWhiteColor),
                                  strokeWidth: 2,
                                ),
                              )
                                  : Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.appWhiteColor,
                                ),
                              ),
                            )),
                          ),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
