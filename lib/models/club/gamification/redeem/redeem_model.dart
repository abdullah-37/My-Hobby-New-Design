import 'dart:convert';

ClubRedeemModel clubRedeemModelFromJson(String str) => ClubRedeemModel.fromJson(json.decode(str));

String clubRedeemModelToJson(ClubRedeemModel data) => json.encode(data.toJson());

class ClubRedeemModel {
  final bool success;
  final List<RewardRedeem> data;

  ClubRedeemModel({
    required this.success,
    required this.data,
  });

  factory ClubRedeemModel.fromJson(Map<String, dynamic> json) => ClubRedeemModel(
    success: json["success"],
    data: List<RewardRedeem>.from(json["data"].map((x) => RewardRedeem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class RewardRedeem {
  final int id;
  final String title;
  final String imageFile;
  final String type;
  final int? voucherQty;
  final int? voucherPoints;
  final String? voucherCode;
  final int? certificateQty;
  final int? certificatePoints;
  final int? giftQty;
  final int? giftPoints;

  RewardRedeem({
    required this.id,
    required this.title,
    required this.imageFile,
    required this.type,
    this.voucherQty,
    this.voucherPoints,
    this.voucherCode,
    this.certificateQty,
    this.certificatePoints,
    this.giftQty,
    this.giftPoints,
  });

  factory RewardRedeem.fromJson(Map<String, dynamic> json) => RewardRedeem(
    id: json["id"],
    title: json["title"],
    imageFile: json["image_file"] ?? '',
    type: json["type"],
    voucherQty: json["voucher_qty"],
    voucherPoints: json["voucher_points"],
    voucherCode: json["voucher_code"],
    certificateQty: json["certificate_qty"],
    certificatePoints: json["certificate_points"],
    giftQty: json["gift_qty"],
    giftPoints: json["gift_points"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image_file": imageFile,
    "type": type,
    "voucher_qty": voucherQty,
    "voucher_points": voucherPoints,
    "voucher_code": voucherCode,
    "certificate_qty": certificateQty,
    "certificate_points": certificatePoints,
    "gift_qty": giftQty,
    "gift_points": giftPoints,
  };
}