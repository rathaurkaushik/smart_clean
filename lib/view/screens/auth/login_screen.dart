import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_clean/constants/app_color.dart';
import 'package:smart_clean/view/screens/auth/auth_controller.dart';
import 'package:smart_clean/view/screens/utils/custom_widgets.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return GetBuilder<AuthController>(builder: (ctrl) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.13),
              Image.asset('assets/images/admin_logo.png'),
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.04),
          
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
                        isPassword: true,
                        controller: ctrl.passwordController,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed("/signup");
                            },
                            child: Text.rich(
                              TextSpan(
                                // text: "Don't have an account? ",
                                style: TextStyle(fontSize: 14, color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: "Sign Up",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColor.numberHeighlightedColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {

                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColor.numberHeighlightedColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
          
                      SizedBox(height: screenHeight * 0.02),
          
                      // Login Button
                      Form(
                        // key: ctrl.formKey,
                        child: SizedBox(
                          width: double.infinity,
                          child:
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.appBarColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 5,
                            ),
                            onPressed: () {
                              ctrl.login();
                            },
                            child: ctrl.isLoading.value ?
                            SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: AppColor.appWhiteColor,
                                  valueColor: AlwaysStoppedAnimation<Color>(AppColor.appWhiteColor),
                                  strokeWidth: 2,

                                ))

                            :Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.appWhiteColor),
                            ),
                          ),)
                        ),

          
                      SizedBox(height: screenHeight * 0.02),
          
                      // Already Have an Account? Sign Up

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
