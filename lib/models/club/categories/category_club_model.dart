import 'dart:convert';

CategoryClubModel categoryClubModelFromJson(String str) => CategoryClubModel.fromJson(json.decode(str));

String categoryClubModelToJson(CategoryClubModel data) => json.encode(data.toJson());

class CategoryClubModel {
  final String message;
  final bool status;
  final List<CategoryClub> data;

  CategoryClubModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory CategoryClubModel.fromJson(Map<String, dynamic> json) => CategoryClubModel(
    message: json["message"],
    status: json["status"],
    data: List<CategoryClub>.from(json["data"].map((x) => CategoryClub.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CategoryClub {
  final int id;
  final String title;
  final String desc;
  final String img;
  final int totalMembers;
  final int totalFeeds;
  final int totalSchedules;
  final bool isJoined;
  final CategoryClubProfile profile;
  final List<CategoryClubFeed> feeds;
  final List<CategoryClubSchedule> schedules;

  CategoryClub({
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

  factory CategoryClub.fromJson(Map<String, dynamic> json) => CategoryClub(
    id: json["id"],
    title: json["title"],
    desc: json["desc"],
    img: json["img"],
    totalMembers: json["total_members"],
    totalFeeds: json["total_feeds"],
    totalSchedules: json["total_schedules"],
    isJoined: json["is_joined"],
    profile: CategoryClubProfile.fromJson(json["profile"]),
    feeds: List<CategoryClubFeed>.from(json["feeds"].map((x) => CategoryClubFeed.fromJson(x))),
    schedules: List<CategoryClubSchedule>.from(json["schedules"].map((x) => CategoryClubSchedule.fromJson(x))),
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

class CategoryClubFeed {
  final int id;
  final String img;
  final String description;
  final int likeCount;
  final int commentCount;
  final DateTime updatedAt;
  final CategoryClubPostedBy postedBy;

  CategoryClubFeed({
    required this.id,
    required this.img,
    required this.description,
    required this.likeCount,
    required this.commentCount,
    required this.updatedAt,
    required this.postedBy,
  });

  factory CategoryClubFeed.fromJson(Map<String, dynamic> json) => CategoryClubFeed(
    id: json["id"],
    img: json["img"] ?? '',
    description: json["description"] ?? '',
    likeCount: json["like_count"],
    commentCount: json["comment_count"],
    updatedAt: DateTime.parse(json["updated_at"]),
    postedBy: CategoryClubPostedBy.fromJson(json["posted_by"]),
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

class CategoryClubPostedBy {
  final String img;
  final String userName;
  final String fullName;

  CategoryClubPostedBy({
    required this.img,
    required this.userName,
    required this.fullName,
  });

  factory CategoryClubPostedBy.fromJson(Map<String, dynamic> json) => CategoryClubPostedBy(
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

class CategoryClubProfile {
  final String img;
  final String fullName;
  final String userName;

  CategoryClubProfile({
    required this.img,
    required this.fullName,
    required this.userName,
  });

  factory CategoryClubProfile.fromJson(Map<String, dynamic> json) => CategoryClubProfile(
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

class CategoryClubSchedule {
  final int id;
  final String title;
  final String description;
  final String img;

  CategoryClubSchedule({
    required this.id,
    required this.title,
    required this.description,
    required this.img,
  });

  factory CategoryClubSchedule.fromJson(Map<String, dynamic> json) => CategoryClubSchedule(
    id: json["id"],
    title: json["title"],
    description: json["description"] ?? '',
    img: json["img"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "img": img,
  };
}