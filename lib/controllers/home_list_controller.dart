import 'package:get/get.dart';

class HomeListAnimationController extends GetxController {
  bool isClosed = false;
  setToClose() {
    isClosed = true;
    update();
  }

  setToOpen() {
    isClosed = false;
    update();
  }
}
