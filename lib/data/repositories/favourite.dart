import 'dart:convert';

List<int> favouriteFromJson(String str) => List<int>.from(json.decode(str).map((x) => x));

String favouriteToJson(List<int> data) => json.encode(List<dynamic>.from(data.map((x) => x)));
