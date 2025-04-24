
import 'package:get/get.dart';
import 'package:smart_clean/view/screens/nav/nav_con.dart';

class NavigationBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<NavigationController>(()=> NavigationController());
  }
}