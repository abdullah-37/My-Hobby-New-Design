import 'dart:convert';

PointModel badgeModelFromJson(String str) => PointModel.fromJson(json.decode(str));

String badgeModelToJson(PointModel data) => json.encode(data.toJson());

class PointModel {
  final bool success;
  final List<UserPoints> data;

  PointModel({
    required this.success,
    required this.data,
  });

  factory PointModel.fromJson(Map<String, dynamic> json) => PointModel(
    success: json["success"],
    data: List<UserPoints>.from(json["data"].map((x) => UserPoints.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class UserPoints {
  final int id;
  final String title;
  final int points;
  final String pointType;
  final String createdAt;
  UserPoints({
    required this.id,
    required this.title,
    required this.points,
    required this.pointType,
    required this.createdAt,
  });

  factory UserPoints.fromJson(Map<String, dynamic> json) => UserPoints(
    id: json["point_id"],
    title: json["point_title"],
    pointType: json["point_type"],
    points: json["points"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "point_id": id,
    "point_title": title,
    "point_type": pointType,
    "points": points,
    "created_at": createdAt,
  };
}
