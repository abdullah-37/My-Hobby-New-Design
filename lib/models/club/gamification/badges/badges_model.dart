import 'dart:convert';

BadgeModel badgeModelFromJson(String str) => BadgeModel.fromJson(json.decode(str));

String badgeModelToJson(BadgeModel data) => json.encode(data.toJson());

class BadgeModel {
  final bool success;
  final List<Badges> data;

  BadgeModel({
    required this.success,
    required this.data,
  });

  factory BadgeModel.fromJson(Map<String, dynamic> json) => BadgeModel(
    success: json["success"],
    data: List<Badges>.from(json["data"].map((x) => Badges.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Badges {
  final int id;
  final String title;
  final String type;
  final String image;

  Badges({
    required this.id,
    required this.title,
    required this.type,
    required this.image,
  });

  factory Badges.fromJson(Map<String, dynamic> json) => Badges(
    id: json["id"],
    title: json["title"],
    type: json["type"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "type": type,
    "image": image,
  };
}
