import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:video_status/controllers/bottomnav_controller.dart';
import 'package:video_status/ui/screens/category/category_screen.dart';
import 'package:video_status/ui/screens/favourite/favourite_screen.dart';
import 'package:video_status/ui/screens/home/home_screen.dart';
import 'package:video_status/ui/screens/setting/setting_screen.dart';
import 'package:video_status/ui/theme/colors.dart';
import 'package:video_status/ui/theme/dimens.dart';

class BottomNavLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(
      init: BottomNavController(),
      builder: (object) => Column(
        children: [
          Expanded(
            child: getScreen(object.bottomNavSelection.toString()),
          ),
          Container(
            height: bottomNavbarHeight,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    object.setToHome();
                  },
                  splashColor: Colors.white,
                  highlightColor: Colors.white,
                  color: getActive(object.bottomNavSelection.toString()) == 1 ? primaryColor : grey,
                  iconSize: getActive(object.bottomNavSelection.toString()) == 1 ? bottomNavActiveIconSize : bottomNavNotActiveIconSize,
                  icon: FaIcon(FontAwesomeIcons.home),
                ),
                IconButton(
                  onPressed: () {
                    object.setToCategory();
                  },
                  splashColor: Colors.white,
                  color: getActive(object.bottomNavSelection.toString()) == 3 ? primaryColor : grey,
                  highlightColor: Colors.white,
                  iconSize: getActive(object.bottomNavSelection.toString()) == 3 ? bottomNavActiveIconSize : bottomNavNotActiveIconSize,
                  icon: FaIcon(FontAwesomeIcons.solidFolder),
                ),
                IconButton(
                  onPressed: () {
                    object.setToFavourite();
                  },
                  splashColor: Colors.white,
                  color: getActive(object.bottomNavSelection.toString()) == 4 ? primaryColor : grey,
                  highlightColor: Colors.white,
                  iconSize: getActive(object.bottomNavSelection.toString()) == 4 ? bottomNavActiveIconSize : bottomNavNotActiveIconSize,
                  icon: FaIcon(FontAwesomeIcons.solidHeart),
                ),
                IconButton(
                  onPressed: () {
                    object.setToSetting();
                  },
                  splashColor: Colors.white,
                  color: getActive(object.bottomNavSelection.toString()) == 5 ? primaryColor : grey,
                  highlightColor: Colors.white,
                  iconSize: getActive(object.bottomNavSelection.toString()) == 5 ? bottomNavActiveIconSize : bottomNavNotActiveIconSize,
                  icon: FaIcon(FontAwesomeIcons.cog),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getScreen(String item) {
    if (item == 'BottomNavSelection.home') {
      return HomeScreen();
    }
    if (item == 'BottomNavSelection.category') {
      return CategoryScreen();
    }
    if (item == 'BottomNavSelection.favourite') {
      return FavouriteScreen();
    }
    if (item == 'BottomNavSelection.setting') {
      return SettingScreen();
    }
    return HomeScreen();
  }

  int getActive(String item) {
    if (item == 'BottomNavSelection.home') {
      return 1;
    }
    if (item == 'BottomNavSelection.trending') {
      return 2;
    }
    if (item == 'BottomNavSelection.category') {
      return 3;
    }
    if (item == 'BottomNavSelection.favourite') {
      return 4;
    }
    if (item == 'BottomNavSelection.setting') {
      return 5;
    }
    return 0;
  }
}
