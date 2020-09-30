import 'package:flutter/material.dart';
import 'package:video_status/ui/layouts/bottomnav/bottomnav_layout.dart';
import 'package:video_status/ui/widgets/appbar.dart';
import 'package:video_status/ui/widgets/drawer.dart';

class DrawerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(),
      drawer: CustomDrawer(),
      body: BottomNavLayout(),
    );
  }
}
