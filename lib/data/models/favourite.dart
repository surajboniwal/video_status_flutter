import 'dart:convert';

List<Favourite> favouriteFromJson(String str) => List<Favourite>.from(json.decode(str).map((x) => Favourite.fromJson(x)));

String favouriteToJson(List<Favourite> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Favourite {
  Favourite({
    this.id,
  });

  int id;

  factory Favourite.fromJson(Map<String, dynamic> json) => Favourite(
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
      };
}
