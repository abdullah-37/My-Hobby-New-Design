import 'dart:convert';

ClubTotalPointsModel clubTotalPointsModelFromJson(String str) => ClubTotalPointsModel.fromJson(json.decode(str));

String clubTotalPointsModelToJson(ClubTotalPointsModel data) => json.encode(data.toJson());

class ClubTotalPointsModel {
  final bool success;
  final TotalPoints data;

  ClubTotalPointsModel({
    required this.success,
    required this.data,
  });

  factory ClubTotalPointsModel.fromJson(Map<String, dynamic> json) => ClubTotalPointsModel(
    success: json["success"],
    data: TotalPoints.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
  };
}

class TotalPoints {
  final int totalPoints;

  TotalPoints({
    required this.totalPoints,
  });

  factory TotalPoints.fromJson(Map<String, dynamic> json) => TotalPoints(
    totalPoints: json["totalPoints"],
  );

  Map<String, dynamic> toJson() => {
    "totalPoints": totalPoints,
  };
}
