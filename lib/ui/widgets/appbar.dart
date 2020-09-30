import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_status/ui/theme/dimens.dart';
import 'package:video_status/ui/theme/themes.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appTheme.primaryColor,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
        ),
      ],
      centerTitle: true,
      title: Text(
        'Video Status',
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
