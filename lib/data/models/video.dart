import 'dart:convert';

List<Video> videoFromJson(String str) => List<Video>.from(json.decode(str).map((x) => Video.fromJson(x)));

String videoToJson(List<Video> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Video {
  Video({this.likes, this.comments, this.id, this.categoryId, this.title, this.featured, this.url});

  int likes;
  List<dynamic> comments;
  int id;
  int categoryId;
  String title;
  String featured;
  String url;
  bool isLiked = false;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        likes: json["likes"],
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        id: json["_id"],
        categoryId: json["categoryId"],
        title: json["title"],
        featured: json["featured"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "likes": likes,
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "_id": id,
        "categoryId": categoryId,
        "title": title,
        "featured": featured,
        "url": url,
      };
}
