import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_status/ui/theme/colors.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text(
              'V',
              textAlign: TextAlign.center,
              style: GoogleFonts.shrikhand(
                textStyle: TextStyle(
                  fontSize: 96,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [primaryColor, lightBlue],
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Get.back();
            },
            title: Text('Home'),
          )
        ],
      ),
    );
  }
}
