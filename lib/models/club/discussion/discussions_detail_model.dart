import 'dart:convert';

DiscussionDetailModel discussionDetailModelFromJson(String str) => DiscussionDetailModel.fromJson(json.decode(str));

String discussionDetailModelToJson(DiscussionDetailModel data) => json.encode(data.toJson());

class DiscussionDetailModel {
  final String message;
  final bool status;
  final List<DiscussionDetail> data;

  DiscussionDetailModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory DiscussionDetailModel.fromJson(Map<String, dynamic> json) => DiscussionDetailModel(
    message: json["message"],
    status: json["status"],
    data: List<DiscussionDetail>.from(json["data"].map((x) => DiscussionDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DiscussionDetail {
  final int id;
  final String title;
  final String image;
  final String desc;
  final DateTime createdAt;
  final List<DiscussionReply> replies;
  final DiscussionProfile profile;

  DiscussionDetail({
    required this.id,
    required this.title,
    required this.image,
    required this.desc,
    required this.createdAt,
    required this.replies,
    required this.profile,
  });

  factory DiscussionDetail.fromJson(Map<String, dynamic> json) => DiscussionDetail(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    desc: json["desc"],
    createdAt: DateTime.parse(json["created_at"]),
    replies: List<DiscussionReply>.from(json["replies"].map((x) => DiscussionReply.fromJson(x))),
    profile: DiscussionProfile.fromJson(json["profile"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "desc": desc,
    "created_at": createdAt.toIso8601String(),
    "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
    "profile": profile.toJson(),
  };
}

class DiscussionProfile {
  final String userName;
  final String img;

  DiscussionProfile({
    required this.userName,
    required this.img,
  });

  factory DiscussionProfile.fromJson(Map<String, dynamic> json) => DiscussionProfile(
    userName: json["userName"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "userName": userName,
    "img": img,
  };
}

class DiscussionReply {
  final int replyId;
  final String reply;
  final DateTime createdAt;
  final String userName;
  final String image;

  DiscussionReply({
    required this.replyId,
    required this.reply,
    required this.createdAt,
    required this.userName,
    required this.image,
  });

  factory DiscussionReply.fromJson(Map<String, dynamic> json) => DiscussionReply(
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