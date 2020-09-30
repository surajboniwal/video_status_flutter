import 'dart:convert';

List<Category> categoryFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    this.id,
    this.title,
    this.featured,
  });

  int id;
  String title;
  String featured;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        title: json["title"],
        featured: json["featured"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "featured": featured,
      };
}
