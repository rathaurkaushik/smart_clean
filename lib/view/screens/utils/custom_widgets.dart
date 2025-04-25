import 'package:country_code_picker/country_code_picker.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_clean/constants/app_color.dart';

class CustomWidgets {
  int currentYear = DateTime.now().year;
  final String companyName = 'Smart-Waste-Manage';

  //    custom drawer
  Widget CustomDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Profile Section
          Container(
            width: double.infinity,
            child: DrawerHeader(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(color: AppColor.appBarColor),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/man.png'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Kaushik Rathaur',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColor.appWhiteColor),
                    ),
                    Text(
                      '+91 9099544962',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColor.appWhiteColor),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Navigation List Items
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ListView(
                children: [
                  _buildDrawerItem('Home', 'assets/images/home.webp',
                      () => Get.toNamed('/')),
                  _buildDrawerItem('Request', 'assets/images/request.webp',
                      () => Get.toNamed('/requests')),
                  _buildDrawerItem('Stats', 'assets/images/stats.webp',
                      () => Get.toNamed('/stats')),
                  _buildDrawerItem('Profile', 'assets/images/person.webp',
                      () => Get.toNamed('/profile')),
                  _buildDrawerItem('Settings', 'assets/images/setting.webp',
                      () => Get.toNamed('/settings')),
                ],
              ),
            ),
          ),

          // Copyright Section at Bottom
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              '© $currentYear $companyName.\nAll Rights Reserved.',
              style: const TextStyle(fontSize: 12.0, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to build ListTile items
  Widget _buildDrawerItem(String title, String iconPath, VoidCallback onTap) {
    return ListTile(
      // ✅ Correct, no Flexible needed
      leading: Image.asset(iconPath, width: 24, height: 24),
      title: Text(title),
      onTap: onTap,
    );
  }

  // Navigation Widget

  Widget BottomNavigation(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.blue.shade100,
      color: AppColor.appBarColor,
      animationDuration: Duration(milliseconds: 300),
      onTap: (index) {
        switch (index) {
          case 0:
            Get.toNamed('/');
            break;
          case 1:
            Get.toNamed('/search');
            break;
          case 2:
            Get.toNamed('/setting');
            break;
        }
      },
      items: [
        Icon(Icons.home, size: 24, color: Colors.white),
        Icon(Icons.search, size: 24, color: Colors.white),
        Icon(Icons.person, size: 24, color: Colors.white),
      ],
    );
  }

  Widget buildCard({required String title, required List<Widget> children}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Card(
        elevation: 2,
        color: AppColor.appWhiteColor,
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 11),
              ...children,
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for Info Rows
  Widget buildInfoRow(Color iconBackgroundColor,Icon icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(

        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: iconBackgroundColor,
            ),
            child: icon,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      fontSize: 14,
                      color: AppColor.grayTextColor,
                      fontWeight: FontWeight.w700)),
              Text(value,
                  style: TextStyle(
                      fontSize: 14,
                      color: AppColor.appBlackColor,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildNotificationCard(Color iconBackgroundColor, Icon icon, String title,
      String subtitle, bool isEnabled, VoidCallback? onToggle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: iconBackgroundColor,
                ),
                child: icon,
              ),
              const SizedBox(width: 10),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$title\n',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onToggle,
            child: Icon(
              isEnabled
                  ? Icons.toggle_on_outlined
                  : Icons.toggle_off_outlined,
              size: 30,
              color: isEnabled ? Colors.blue : Colors.grey,
            ),
          )
        ],
      ),
    );
  }


  /// Help & Support
  Widget buildHelpSupportCard(
      Color iconBackgroundColor,
      Icon icon,
      String title,
      bool nextPage
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: iconBackgroundColor,
                ),
                child: icon,
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          nextPage == true ?
          const Icon(
            CupertinoIcons.right_chevron,
            color: Colors.grey,
            size: 20,
            shadows: [
              Shadow(color: Colors.grey,offset: Offset.infinite)
            ],
          ) : Spacer()
        ],
      ),
    );
  }

  // Helper method for Buttons
  Widget buildButtonCard(
      BuildContext context,
      IconData icon,
      String buttonText,
      Color? bgColor,
      String showDialogueTitle,
      String showDialogueSubtitle,
      String showDialogueActionButton,
      VoidCallback onNext,
      VoidCallback onTap, {
        Color textColor = Colors.black,
      })

       {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(showDialogueTitle),
            content: Text(
                showDialogueSubtitle),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onNext();

                },
                child: Text(showDialogueActionButton),
              ),
            ],
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Card(
          elevation: 1,
          color: bgColor,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: textColor),
                const SizedBox(width: 5),
                Text(buttonText, style: TextStyle(color: textColor)),
              ],
            ),
          ),
        ),
      ),
    );
  }


  // Helper method for Performance Rows
  Widget buildPerformanceRow(
      String title, String value, Color color, double progress) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: 13)),
              Text(value, style: TextStyle(fontSize: 13)),
            ],
          ),
          SizedBox(height: 4),
          SizedBox(
            height: 6,
            child: LinearProgressIndicator(
              borderRadius: BorderRadius.circular(12),
              value: progress,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable Input Card for TextField
Widget buildInputCard({
  required IconData icon,
  required String hintText,
  IconData? suffixIcon,
  bool isPassword = false,
  required TextEditingController controller,
  String? Function(String?)? validator,
}) {
  if (isPassword) {
    // Only create controller if password field
    final visibilityController = Get.put(InputVisibilityController());
    return GetBuilder<InputVisibilityController>(
      builder: (controllerX) {
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: controller,
            obscureText: !controllerX.isPasswordVisible,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: AppColor.appBarColor),
              suffixIcon: IconButton(
                onPressed: controllerX.toggleVisibility,
                icon: Icon(
                  controllerX.isPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
              hintText: hintText,
              labelStyle:
              TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 18),
            ),
          ),
        );
      },
    );
  } else {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: AppColor.appBarColor),
          suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
          hintText: hintText,
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }
}


// country code

Widget buildInputCardWithCountryCode({
  required String hintText,
  required TextEditingController controller,
}) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        CountryCodePicker(
          onChanged: (country) {
            print("Selected country: ${country.dialCode}");
          },
          initialSelection: 'IN', // Default to India (change as needed)
          favorite: ['+91', 'IN'],
          showFlag: false,
        ),
        SizedBox(width: 10), // Add space between picker and text field

        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    ),
  );
}

///
/// obscure false
class InputVisibilityController extends GetxController {
  bool isPasswordVisible = false;

  void toggleVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }
}