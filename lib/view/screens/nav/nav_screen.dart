import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:smart_clean/constants/app_color.dart';
import 'package:smart_clean/view/screens/request/request_screen.dart';
import 'package:smart_clean/view/screens/home/home_screen.dart';
import 'package:smart_clean/view/screens/nav/nav_con.dart';
import 'package:smart_clean/view/screens/profile/profile_screen.dart';import 'package:smart_clean/view/screens/waste_collaction/waste_collection_status_screen.dart';
import 'package:smart_clean/view/screens/waste_collaction/waste_verification_screen.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final theme = Theme.of(context);

    final pages = <Widget>[
      const HomeScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      bottomNavigationBar: Obx(() => NavigationBar(
        backgroundColor: AppColor.appWhiteColor,
        onDestinationSelected: controller.changePage,
        height: 60,
        animationDuration: Duration(seconds: 1),
        indicatorColor: AppColor.appBarColor,
        selectedIndex: controller.currentPageIndex.value,
        destinations: <Widget>[
          const NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Settings',
          ),
        ],
      )),
      body: Obx(() => pages[controller.currentPageIndex.value]),
    );
  }
}
