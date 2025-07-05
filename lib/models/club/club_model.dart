import 'dart:convert';

ClubModel clubModelFromJson(String str) => ClubModel.fromJson(json.decode(str));

String clubModelToJson(ClubModel data) => json.encode(data.toJson());

class ClubModel {
  final String message;
  final bool status;
  final List<Club> data;

  ClubModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory ClubModel.fromJson(Map<String, dynamic> json) => ClubModel(
    message: json["message"],
    status: json["status"],
    data: List<Club>.from(json["data"].map((x) => Club.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Club {
  final int categoryId;
  final String category;
  final int id;
  final String title;
  final String desc;
  final String img;
  final int totalMembers;
  final String status;
  final int totalSchedules;
  final Badge badge;

  Club({
    required this.categoryId,
    required this.category,
    required this.id,
    required this.title,
    required this.desc,
    required this.img,
    required this.totalMembers,
    required this.status,
    required this.totalSchedules,
    required this.badge,
  });

  factory Club.fromJson(Map<String, dynamic> json) => Club(
    categoryId: json["category_id"],
    category: json["category"],
    id: json["id"],
    title: json["title"],
    desc: json["desc"],
    img: json["img"],
    totalMembers: json["total_members"],
    status: json["status"],
    totalSchedules: json["total_schedules"],
    badge: Badge.fromJson(json["badge"]),
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category": category,
    "id": id,
    "title": title,
    "desc": desc,
    "img": img,
    "total_members": totalMembers,
    "status": status,
    "total_schedules": totalSchedules,
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