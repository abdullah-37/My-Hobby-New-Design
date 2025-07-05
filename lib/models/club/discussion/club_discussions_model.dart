import 'dart:convert';

ClubDiscussionModel clubDiscussionModelFromJson(String str) => ClubDiscussionModel.fromJson(json.decode(str));

String clubDiscussionModelToJson(ClubDiscussionModel data) => json.encode(data.toJson());

class ClubDiscussionModel {
  final String message;
  final bool status;
  final List<ClubDiscussion> data;

  ClubDiscussionModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory ClubDiscussionModel.fromJson(Map<String, dynamic> json) => ClubDiscussionModel(
    message: json["message"],
    status: json["status"],
    data: List<ClubDiscussion>.from(json["data"].map((x) => ClubDiscussion.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ClubDiscussion {
  final int id;
  final String title;
  final String image;
  final String desc;
  final String tag;
  final DateTime createdAt;
  final DateTime? latestReply;
  final int repliesCount;

  ClubDiscussion({
    required this.id,
    required this.title,
    required this.image,
    required this.desc,
    required this.tag,
    required this.createdAt,
    this.latestReply,
    required this.repliesCount,
  });

  factory ClubDiscussion.fromJson(Map<String, dynamic> json) => ClubDiscussion(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    desc: json["desc"],
    tag: json["tag"],
    createdAt: DateTime.parse(json["created_at"]),
    latestReply: json["latest_reply"] != null
        ? DateTime.parse(json["latest_reply"])
        : null,
    repliesCount: json["replies_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "desc": desc,
    "tag": tag,
    "created_at": createdAt.toIso8601String(),
    "latest_reply": latestReply?.toIso8601String(),
    "replies_count": repliesCount,
  };
}