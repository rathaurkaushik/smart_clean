import 'package:get/get.dart';

class NavigationController extends GetxController {
  var currentPageIndex = 0.obs;

  void changePage(int index) {
    currentPageIndex.value = index;
  }
}
