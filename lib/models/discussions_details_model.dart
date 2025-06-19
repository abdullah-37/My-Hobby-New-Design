import 'dart:convert';

class DiscussionsDetailsModel {
  String message;
  bool status;
  List<DiscussionDetail> data;

  DiscussionsDetailsModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory DiscussionsDetailsModel.fromRawJson(String str) =>
      DiscussionsDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DiscussionsDetailsModel.fromJson(Map<String, dynamic> json) =>
      DiscussionsDetailsModel(
        message: json["message"],
        status: json["status"],
        data: List<DiscussionDetail>.from(
          json["data"].map((x) => DiscussionDetail.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DiscussionDetail {
  int id;
  String title;
  String desc;
  DateTime createdAt;
  List<DiscussionReply> replies;
  Profile profile;

  DiscussionDetail({
    required this.id,
    required this.title,
    required this.desc,
    required this.createdAt,
    required this.replies,
    required this.profile,
  });

  factory DiscussionDetail.fromRawJson(String str) =>
      DiscussionDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DiscussionDetail.fromJson(Map<String, dynamic> json) =>
      DiscussionDetail(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
        createdAt: DateTime.parse(json["created_at"]),
        replies: List<DiscussionReply>.from(
          json["replies"].map((x) => DiscussionReply.fromJson(x)),
        ),
        profile: Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "desc": desc,
    "created_at": createdAt.toIso8601String(),
    "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
    "profile": profile.toJson(),
  };
}

class Profile {
  String userName;
  String img;

  Profile({required this.userName, required this.img});

  factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Profile.fromJson(Map<String, dynamic> json) =>
      Profile(userName: json["userName"], img: json["img"]);

  Map<String, dynamic> toJson() => {"userName": userName, "img": img};
}

class DiscussionReply {
  int replyId;
  String reply;
  DateTime createdAt;
  String userName;
  String image;

  DiscussionReply({
    required this.replyId,
    required this.reply,
    required this.createdAt,
    required this.userName,
    required this.image,
  });

  factory DiscussionReply.fromRawJson(String str) =>
      DiscussionReply.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DiscussionReply.fromJson(Map<String, dynamic> json) =>
      DiscussionReply(
        replyId: json["reply_id"],
        reply: json["reply"],
        createdAt: DateTime.parse(json["created_at"]),
        userName: json["userName"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
    "reply_id": replyId,
    "reply": reply,
    "created_at": createdAt.toIso8601String(),
    "userName": userName,
    "image": image,
  };
}
