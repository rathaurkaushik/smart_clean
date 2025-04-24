import 'package:flutter/material.dart';
import 'package:smart_clean/constants/app_color.dart';

Widget buildInputCard({
  required IconData icon,
  required String hintText,
  bool isPassword = false,
  // required TextEditingController controller,
}) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: TextField(
      // controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColor.appBarColor),
        hintText: hintText,
        labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        border: InputBorder.none,
        contentPadding:
        EdgeInsets.symmetric(vertical: 18), // Controls vertical centering
      ),
    ),
  );
}