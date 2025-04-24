import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_clean/view/firebase_opt.dart';
import 'package:smart_clean/view/screens/auth/auth_binding.dart';
import 'package:smart_clean/view/screens/auth/login_screen.dart';
import 'package:smart_clean/view/screens/auth/signup_screen.dart';
import 'package:smart_clean/view/screens/home/home_binding.dart';
import 'package:smart_clean/view/screens/home/home_screen.dart';
import 'package:smart_clean/view/screens/nav/nav_binding.dart';
import 'package:smart_clean/view/screens/nav/nav_con.dart';
import 'package:smart_clean/view/screens/nav/nav_screen.dart';
import 'package:smart_clean/view/screens/home/home_controller.dart';
import 'package:smart_clean/view/screens/profile/profile_binding.dart';
import 'package:smart_clean/view/screens/profile/profile_controller.dart';
import 'package:smart_clean/view/screens/profile/profile_screen.dart';


void main() async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(options: firebaseOptions);
  Get.put(GetMaterialController());
  Get.put(HomeController());
  Get.put(ProfileController());
  Get.put(NavigationController());
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final isLoggedIn = FirebaseAuth.instance.currentUser != null;

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: isLoggedIn ? "/" : "/signup",
      initialBinding: NavigationBinding(),
      getPages: [
        GetPage(
            name: "/",
            page: () => NavigationScreen(),
            binding: NavigationBinding()),
        GetPage(
          name: "/login",
          page: () => LoginScreen(),
        ),
        GetPage(
          name: "/signup",
          page: () => SignupScreen(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: "/home",
          page: () => HomeScreen(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: "/profile",
          page: () => ProfileScreen(),
          binding: ProfileBinding(),
        ),
      ],

    );
  }
}

