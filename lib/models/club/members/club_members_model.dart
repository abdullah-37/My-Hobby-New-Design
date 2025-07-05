import 'dart:convert';

ClubMembersModel clubMembersModelFromJson(String str) => ClubMembersModel.fromJson(json.decode(str));

String clubMembersModelToJson(ClubMembersModel data) => json.encode(data.toJson());

class ClubMembersModel {
  final String message;
  final bool status;
  final List<ClubMember> data;

  ClubMembersModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory ClubMembersModel.fromJson(Map<String, dynamic> json) => ClubMembersModel(
    message: json["message"],
    status: json["status"],
    data: List<ClubMember>.from(json["data"].map((x) => ClubMember.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ClubMember {
  final int userId;
  final String userName;
  final String firstName;
  final String lastName;
  final String img;
  final List<MemberBadge> badges;

  ClubMember({
    required this.userId,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.img,
    required this.badges,
  });

  factory ClubMember.fromJson(Map<String, dynamic> json) => ClubMember(
    userId: json["user_id"],
    userName: json["userName"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    img: json["img"],
    badges: List<MemberBadge>.from(json["badges"].map((x) => MemberBadge.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "userName": userName,
    "first_name": firstName,
    "last_name": lastName,
    "img": img,
    "badges": List<dynamic>.from(badges.map((x) => x.toJson())),
  };
}

class MemberBadge {
  final int id;
  final String title;
  final String type;
  final String img;
  final DateTime assignedAt;

  MemberBadge({
    required this.id,
    required this.title,
    required this.type,
    required this.img,
    required this.assignedAt,
  });

  factory MemberBadge.fromJson(Map<String, dynamic> json) => MemberBadge(
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
}
