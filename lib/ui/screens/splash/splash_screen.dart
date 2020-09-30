import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_status/ui/layouts/drawer/drawer_layout.dart';
import 'package:video_status/ui/screens/account/account_screen.dart';
import 'package:video_status/ui/theme/colors.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashLoading();
  }
}

class SplashLoading extends StatefulWidget {
  const SplashLoading({
    Key key,
  }) : super(key: key);

  @override
  _SplashLoadingState createState() => _SplashLoadingState();
}

class _SplashLoadingState extends State<SplashLoading> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await Firebase.initializeApp();
    Future.delayed(Duration(milliseconds: 2000)).then((value) {
      if (sharedPreferences.getBool('welcome') == null) {
        sharedPreferences.setBool('welcome', false);
        Get.off(AccountScreen(isLaunch: true));
      } else {
        Get.off(DrawerLayout());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: primaryColor));
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [primaryColor, lightPink],
          ),
        ),
        child: Hero(
          tag: 'introHero',
          child: Material(
            type: MaterialType.transparency,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'V',
                  style: GoogleFonts.shrikhand(
                    textStyle: TextStyle(
                      fontSize: 118,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  "Let's get started!",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
