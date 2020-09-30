import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_status/ui/screens/splash/splash_screen.dart';
import 'package:video_status/ui/theme/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Video Status',
      theme: appTheme,
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SystemUiOverlayStyle {}
