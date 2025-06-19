import 'dart:convert';

class DiscussionsModel {
  String message;
  bool status;
  List<Discussions> data;

  DiscussionsModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory DiscussionsModel.fromRawJson(String str) =>
      DiscussionsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DiscussionsModel.fromJson(Map<String, dynamic> json) =>
      DiscussionsModel(
        message: json["message"],
        status: json["status"],
        data: List<Discussions>.from(
          json["data"].map((x) => Discussions.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Discussions {
  int id;
  String title;
  String desc;
  DateTime createdAt;
  int repliesCount;

  Discussions({
    required this.id,
    required this.title,
    required this.desc,
    required this.createdAt,
    required this.repliesCount,
  });

  factory Discussions.fromRawJson(String str) =>
      Discussions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Discussions.fromJson(Map<String, dynamic> json) => Discussions(
    id: json["id"],
    title: json["title"],
    desc: json["desc"],
    repliesCount: json["replies_count"],

    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,

    "title": title,
    "desc": desc,
    "replies_count": repliesCount,
    "created_at": createdAt.toIso8601String(),
  };
}
