import 'dart:convert';

ReferralModel referralModelFromJson(String str) => ReferralModel.fromJson(json.decode(str));

String referralModelToJson(ReferralModel data) => json.encode(data.toJson());

class ReferralModel {
  final bool success;
  final Referrals data;

  ReferralModel({
    required this.success,
    required this.data,
  });

  factory ReferralModel.fromJson(Map<String, dynamic> json) => ReferralModel(
    success: json["success"],
    data: Referrals.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
  };
}

class Referrals {
  final String referralCode;
  final int totalReferrals;
  final List<Referral> referrals;

  Referrals({
    required this.referralCode,
    required this.totalReferrals,
    required this.referrals,
  });

  factory Referrals.fromJson(Map<String, dynamic> json) => Referrals(
    referralCode: json["referral_code"] ?? '',
    totalReferrals: json["total_referrals"],
    referrals: List<Referral>.from(json["referrals"].map((x) => Referral.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "referral_code": referralCode,
    "total_referrals": totalReferrals,
    "referrals": List<dynamic>.from(referrals.map((x) => x.toJson())),
  };
}

class Referral {
  final String image;
  final String fullname;
  final String email;
  final String joinDate;

  Referral({
    required this.image,
    required this.fullname,
    required this.email,
    required this.joinDate,
  });

  factory Referral.fromJson(Map<String, dynamic> json) => Referral(
    image: json["image"],
    fullname: json["fullname"],
    email: json["email"],
    joinDate: json["join_date"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "fullname": fullname,
    "email": email,
    "join_date": joinDate,
  };
}