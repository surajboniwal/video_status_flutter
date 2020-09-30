import 'package:get/get.dart';

enum BottomNavSelection { home, category, favourite, setting }

class BottomNavController extends GetxController {
  BottomNavSelection bottomNavSelection = BottomNavSelection.home;
  setToHome() {
    bottomNavSelection = BottomNavSelection.home;
    update();
  }

  setToCategory() {
    bottomNavSelection = BottomNavSelection.category;
    update();
  }

  setToFavourite() {
    bottomNavSelection = BottomNavSelection.favourite;
    update();
  }

  setToSetting() {
    bottomNavSelection = BottomNavSelection.setting;
    update();
  }
}
