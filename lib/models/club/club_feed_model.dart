import 'dart:convert';

ClubFeedsModel clubFeedsFromJson(String str) => ClubFeedsModel.fromJson(json.decode(str));

String clubFeedsToJson(ClubFeedsModel data) => json.encode(data.toJson());

class ClubFeedsModel {
  final String message;
  final bool status;
  final List<ClubFeed> data;

  ClubFeedsModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory ClubFeedsModel.fromJson(Map<String, dynamic> json) => ClubFeedsModel(
    message: json["message"],
    status: json["status"],
    data: List<ClubFeed>.from(json["data"].map((x) => ClubFeed.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ClubFeed {
  final int id;
  int likes;
  bool isLike;
  final String image;
  final String desc;
  final DateTime updatedAt;
  final FeedProfile profile;
  List<FeedComment> comments;
  final BadgeClass badge;

  ClubFeed({
    required this.id,
    required this.likes,
    required this.isLike,
    required this.image,
    required this.desc,
    required this.updatedAt,
    required this.profile,
    required this.comments,
    required this.badge,
  });

  factory ClubFeed.fromJson(Map<String, dynamic> json) => ClubFeed(
    id: json["id"],
    likes: json["likes"],
    isLike: json["is_like"],
    image: json["image"] ?? '',
    desc: json["desc"] ?? '',
    updatedAt: DateTime.parse(json["updated_at"]),
    profile: FeedProfile.fromJson(json["profile"]),
    comments: List<FeedComment>.from(json["comments"].map((x) => FeedComment.fromJson(x))),
    badge: (json["badge"] is Map<String, dynamic>)
        ? BadgeClass.fromJson(json["badge"])
        : BadgeClass.empty(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "likes": likes,
    "is_like": isLike,
    "image": image,
    "desc": desc,
    "updated_at": updatedAt.toIso8601String(),
    "profile": profile.toJson(),
    "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
    "badge": badge,
  };
}

class FeedComment {
  final int id;
  final String comment;
  final DateTime updatedAt;
  final int userId;
  final CommentProfile profile;

  FeedComment({
    required this.id,
    required this.comment,
    required this.updatedAt,
    required this.userId,
    required this.profile,
  });

  factory FeedComment.fromJson(Map<String, dynamic> json) => FeedComment(
    id: json["id"],
    comment: json["comment"],
    updatedAt: DateTime.parse(json["updated_at"]),
    userId: json["user_id"],
    profile: CommentProfile.fromJson(json["profile"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "comment": comment,
    "updated_at": updatedAt.toIso8601String(),
    "user_id": userId,
    "profile": profile.toJson(),
  };
}

class BadgeClass {
  final int id;
  final String title;
  final String type;
  final String img;
  final DateTime assignedAt;

  BadgeClass({
    required this.id,
    required this.title,
    required this.type,
    required this.img,
    required this.assignedAt,
  });

  factory BadgeClass.fromJson(Map<String, dynamic> json) => BadgeClass(
    id: json["id"],
    title: json["title"],
    type: json["type"],
    img: json["img"],
    assignedAt: DateTime.parse(json["assigned_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "type": type,
    "img": img,
    "assigned_at": assignedAt.toIso8601String(),
  };

  factory BadgeClass.empty() => BadgeClass(
    id: 0,
    title: '',
    type: '',
    img: '',
    assignedAt: DateTime.fromMillisecondsSinceEpoch(0),
  );
}

class CommentProfile {
  final String userName;
  final String img;

  CommentProfile({
    required this.userName,
    required this.img,
  });

  factory CommentProfile.fromJson(Map<String, dynamic> json) => CommentProfile(
    userName: json["userName"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "userName": userName,
    "img": img,
  };
}

class FeedProfile {
  final String userName;
  final String firstName;
  final String lastName;
  final String img;

  FeedProfile({
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.img,
  });

  factory FeedProfile.fromJson(Map<String, dynamic> json) => FeedProfile(
    userName: json["userName"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "userName": userName,
    "first_name": firstName,
    "last_name": lastName,
    "img": img,
  };
}