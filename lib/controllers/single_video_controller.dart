import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_status/data/models/single_video.dart';
import 'package:video_status/data/repositories/video.dart';

VideoRepo _videoRepo = VideoRepository();

class SingleVideoController extends GetxController {
  SingleVideo singleVideo;
  bool isFav = false;
  List<int> favourites = [];

  getSingleVideo(int id) async {
    singleVideo = await _videoRepo.getSingleVideoFromApi(id);
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    if (sharedPreference.get('favourites') != null) {
      favourites = favouriteFromJson(sharedPreference.get('favourites'));
    } else {
      favourites = [];
    }
    if (favourites.contains(singleVideo.id)) {
      isFav = true;
    }
    update();
  }

  likeVideo(int id) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    favourites.add(id);
    sharedPreference.setString('favourites', jsonEncode(favourites));
    isFav = true;

    update();
  }

  unlikeVideo(int id) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    favourites.remove(id);
    sharedPreference.setString('favourites', jsonEncode(favourites));
    isFav = false;
    update();
  }

  makeComment(String comment, int videoId, String user) async {
    await _videoRepo.makeNewCommentToApi(comment, videoId, user);
    update();
  }

  List<int> favouriteFromJson(String str) => List<int>.from(json.decode(str).map((x) => x));

  String favouriteToJson(List<int> data) => json.encode(List<dynamic>.from(data.map((x) => x)));
}
