import 'dart:convert';

TrendingClubModel trendingClubModelFromJson(String str) => TrendingClubModel.fromJson(json.decode(str));

String trendingClubModelToJson(TrendingClubModel data) => json.encode(data.toJson());

class TrendingClubModel {
  final String message;
  final bool status;
  final List<TrendingClub> data;

  TrendingClubModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory TrendingClubModel.fromJson(Map<String, dynamic> json) => TrendingClubModel(
    message: json["message"],
    status: json["status"],
    data: List<TrendingClub>.from(json["data"].map((x) => TrendingClub.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class TrendingClub {
  final int id;
  final String title;
  final String desc;
  final String img;
  final int totalMembers;
  final int totalFeeds;
  final int totalSchedules;
  final bool isJoined;
  final TrendingProfile profile;
  final List<TrendingFeed> feeds;
  final List<TrendingSchedule> schedules;

  TrendingClub({
    required this.id,
    required this.title,
    required this.desc,
    required this.img,
    required this.totalMembers,
    required this.totalFeeds,
    required this.totalSchedules,
    required this.isJoined,
    required this.profile,
    required this.feeds,
    required this.schedules,
  });

  factory TrendingClub.fromJson(Map<String, dynamic> json) => TrendingClub(
    id: json["id"],
    title: json["title"],
    desc: json["desc"],
    img: json["img"],
    totalMembers: json["total_members"],
    totalFeeds: json["total_feeds"],
    totalSchedules: json["total_schedules"],
    isJoined: json["is_joined"],
    profile: TrendingProfile.fromJson(json["profile"]),
    feeds: List<TrendingFeed>.from(json["feeds"].map((x) => TrendingFeed.fromJson(x))),
    schedules: List<TrendingSchedule>.from(json["schedules"].map((x) => TrendingSchedule.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "desc": desc,
    "img": img,
    "total_members": totalMembers,
    "total_feeds": totalFeeds,
    "total_schedules": totalSchedules,
    "is_joined": isJoined,
    "profile": profile.toJson(),
    "feeds": List<dynamic>.from(feeds.map((x) => x.toJson())),
    "schedules": List<dynamic>.from(schedules.map((x) => x.toJson())),
  };
}

class TrendingFeed {
  final int id;
  final String img;
  final String description;
  final int likeCount;
  final int commentCount;
  final DateTime updatedAt;
  final PostedBy postedBy;

  TrendingFeed({
    required this.id,
    required this.img,
    required this.description,
    required this.likeCount,
    required this.commentCount,
    required this.updatedAt,
    required this.postedBy,
  });

  factory TrendingFeed.fromJson(Map<String, dynamic> json) => TrendingFeed(
    id: json["id"],
    img: json["img"],
    description: json["description"],
    likeCount: json["like_count"],
    commentCount: json["comment_count"],
    updatedAt: DateTime.parse(json["updated_at"]),
    postedBy: PostedBy.fromJson(json["posted_by"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "img": img,
    "description": description,
    "like_count": likeCount,
    "comment_count": commentCount,
    "updatedAt": updatedAt,
    "posted_by": postedBy.toJson(),
  };
}

class PostedBy {
  final String img;
  final String userName;
  final String fullName;

  PostedBy({
    required this.img,
    required this.userName,
    required this.fullName,
  });

  factory PostedBy.fromJson(Map<String, dynamic> json) => PostedBy(
    img: json["img"],
    userName: json["userName"],
    fullName: json["fullName"],
  );

  Map<String, dynamic> toJson() => {
    "img": img,
    "userName": userName,
    "fullName": fullName,
  };
}

class TrendingProfile {
  final String img;
  final String fullName;
  final String userName;

  TrendingProfile({
    required this.img,
    required this.fullName,
    required this.userName,
  });

  factory TrendingProfile.fromJson(Map<String, dynamic> json) => TrendingProfile(
    img: json["img"],
    fullName: json["fullName"],
    userName: json["userName"],
  );

  Map<String, dynamic> toJson() => {
    "img": img,
    "fullName": fullName,
    "userName": userName,
  };
}

class TrendingSchedule {
  final int id;
  final String title;
  final String description;
  final String img;

  TrendingSchedule({
    required this.id,
    required this.title,
    required this.description,
    required this.img,
  });

  factory TrendingSchedule.fromJson(Map<String, dynamic> json) => TrendingSchedule(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "img": img,
  };
}