import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_status/data/models/video.dart';
import 'package:video_status/data/repositories/video.dart';

VideoRepo _videoRepo = VideoRepository();

class VideoController extends GetxController {
  List<Video> videos = [];
  bool isLoaded = false;
  List<int> favourites = [];

  getVideos(int id) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    if (sharedPreference.get('favourites') != null) {
      favourites = favouriteFromJson(sharedPreference.get('favourites'));
    } else {
      favourites = [];
    }
    videos = await _videoRepo.getCategoryVideosFromApi(id);
    isLoaded = true;
    update();
  }

  likeVideo(int id) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    favourites.add(id);
    sharedPreference.setString('favourites', jsonEncode(favourites));
    update();
  }

  unlikeVideo(int id) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    favourites.remove(id);
    sharedPreference.setString('favourites', jsonEncode(favourites));
    update();
  }

  checkLike(int id) => favourites.contains(id);
  List<int> favouriteFromJson(String str) => List<int>.from(json.decode(str).map((x) => x));

  String favouriteToJson(List<int> data) => json.encode(List<dynamic>.from(data.map((x) => x)));
}
