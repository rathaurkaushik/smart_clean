import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_clean/view/screens/home/home_screen.dart';
import 'package:smart_clean/view/screens/nav/nav_con.dart';
import 'package:smart_clean/view/screens/profile/profile_screen.dart';
import 'package:smart_clean/view/screens/setting_screen/setting_screen.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final theme = Theme.of(context);

    final pages = <Widget>[
      const HomeScreen(),
      ProfileScreen(),
      const SettingScreen(),
    ];

    return Scaffold(
      bottomNavigationBar: Obx(() => NavigationBar(
        onDestinationSelected: controller.changePage,
        indicatorColor: Colors.amber,
        selectedIndex: controller.currentPageIndex.value,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      )),
      body: Obx(() => pages[controller.currentPageIndex.value]),
    );
  }
}
