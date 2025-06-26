import 'dart:convert';

MyJoinClub myJoinClubFromJson(String str) => MyJoinClub.fromJson(json.decode(str));

String myJoinClubToJson(MyJoinClub data) => json.encode(data.toJson());

class MyJoinClub {
  final String message;
  final bool status;
  final List<JoinClub> data;

  MyJoinClub({
    required this.message,
    required this.status,
    required this.data,
  });

  factory MyJoinClub.fromJson(Map<String, dynamic> json) => MyJoinClub(
    message: json["message"],
    status: json["status"],
    data: List<JoinClub>.from(json["data"].map((x) => JoinClub.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class JoinClub {
  final int id;
  final String title;
  final String desc;
  final String img;
  final String status;
  final int categoryId;
  final String category;
  final int totalSchedules;
  final int totalMembers;
  final Badge badge;

  JoinClub({
    required this.id,
    required this.title,
    required this.desc,
    required this.img,
    required this.status,
    required this.categoryId,
    required this.category,
    required this.totalSchedules,
    required this.totalMembers,
    required this.badge,
  });

  factory JoinClub.fromJson(Map<String, dynamic> json) => JoinClub(
    id: json["id"],
    title: json["title"],
    desc: json["desc"],
    img: json["img"],
    status: json["status"],
    categoryId: json["category_id"],
    category: json["category"],
    totalSchedules: json["total_schedules"],
    totalMembers: json["total_members"],
    badge: Badge.fromJson(json["badge"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "desc": desc,
    "img": img,
    "status": status,
    "category_id": categoryId,
    "category": category,
    "total_schedules": totalSchedules,
    "total_members": totalMembers,
    "badge": badge.toJson(),
  };
}

class Badge {
  final int id;
  final String title;
  final String type;
  final String img;

  Badge({
    required this.id,
    required this.title,
    required this.type,
    required this.img,
  });

  factory Badge.fromJson(Map<String, dynamic> json) => Badge(
    id: json["id"],
    title: json["title"],
    type: json["type"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "type": type,
    "img": img,
  };
}