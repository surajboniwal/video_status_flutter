import 'package:get/get.dart';

class ShareController extends GetxController {
  bool isDownloading = false;

  downloadAndShare(String url) async {
    isDownloading = true;
    update();

    await Future.delayed(Duration(seconds: 3));

    isDownloading = false;
    update();
  }
}
