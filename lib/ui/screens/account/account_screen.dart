import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_status/controllers/account_controller.dart';
import 'package:video_status/ui/layouts/drawer/drawer_layout.dart';
import 'package:video_status/ui/theme/colors.dart';

class AccountScreen extends StatelessWidget {
  final bool isLaunch;
  AccountScreen({this.isLaunch = false});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: primaryColor));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primaryColor, pink],
            ),
          ),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    IconButton(
                      onPressed: () {
                        if (isLaunch) {
                          Get.off(DrawerLayout());
                        } else {
                          Get.back();
                        }
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
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
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildGoogleSignInButton(),
                      SizedBox(height: 18),
                      Text(
                        "Sign in with your Google Account \n to get started!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    signOutGoogle();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Skip',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FlatButton _buildGoogleSignInButton() {
    return FlatButton.icon(
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            print('aaa');
          }
        });
      },
      padding: EdgeInsets.all(2),
      color: Colors.blueAccent,
      icon: Container(
        padding: EdgeInsets.all(12),
        color: Colors.white,
        child: FaIcon(
          FontAwesomeIcons.google,
          color: Colors.blue,
        ),
      ),
      label: Text(
        'Sign in with Google ',
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
