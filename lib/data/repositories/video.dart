import 'dart:convert';

import 'package:http/http.dart';
import 'package:video_status/data/global/api_constants.dart';
import 'package:video_status/data/models/single_video.dart';
import 'package:video_status/data/models/video.dart';

abstract class VideoRepo {
  Future<List<Video>> getCategoryVideosFromApi(int id);
  Future<SingleVideo> getSingleVideoFromApi(int id);
  Future<bool> makeNewCommentToApi(String comment, int videoId, String user);
}

class VideoRepository implements VideoRepo {
  @override
  Future<List<Video>> getCategoryVideosFromApi(int id) async {
    Response response = await get(ApiConstants.CATEGORY_NODE + '/$id');
    return videoFromJson(response.body);
  }

  @override
  Future<SingleVideo> getSingleVideoFromApi(int id) async {
    Response response = await get(ApiConstants.VIDEO_NODE + '/$id');
    return singleVideoFromJson(response.body);
  }

  Future<bool> makeNewCommentToApi(String comment, int videoId, String user) async {
    Map data = {'videoId': videoId, 'comment': comment, 'user': user};
    String body = jsonEncode(data);
    Response response = await post(
      ApiConstants.COMMENT_NODE,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
