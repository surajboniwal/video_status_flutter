
import 'dart:convert';

SingleVideo singleVideoFromJson(String str) => SingleVideo.fromJson(json.decode(str));

String singleVideoToJson(SingleVideo data) => json.encode(data.toJson());

class SingleVideo {
    SingleVideo({
        this.likes,
        this.comments,
        this.id,
        this.categoryId,
        this.title,
        this.featured,
        this.url,
    });

    int likes;
    List<Comment> comments;
    int id;
    int categoryId;
    String title;
    String featured;
    String url;

    factory SingleVideo.fromJson(Map<String, dynamic> json) => SingleVideo(
        likes: json["likes"],
        comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
        id: json["_id"],
        categoryId: json["categoryId"],
        title: json["title"],
        featured: json["featured"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "likes": likes,
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "_id": id,
        "categoryId": categoryId,
        "title": title,
        "featured": featured,
        "url": url,
    };
}

class Comment {
    Comment({
        this.id,
        this.user,
        this.comment,
    });

    int id;
    String user;
    String comment;

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["_id"],
        user: json["user"],
        comment: json["comment"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "comment": comment,
    };
}
