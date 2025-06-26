import 'dart:convert';

ClubEventModel clubEventModelFromJson(String str) => ClubEventModel.fromJson(json.decode(str));

String clubEventModelToJson(ClubEventModel data) => json.encode(data.toJson());

class ClubEventModel {
  final bool success;
  final String message;
  final List<ClubEvent> data;

  ClubEventModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ClubEventModel.fromJson(Map<String, dynamic> json) => ClubEventModel(
    success: json["success"],
    message: json["message"],
    data: List<ClubEvent>.from(json["data"].map((x) => ClubEvent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ClubEvent {
  final int id;
  final int totalParticipations;
  final bool isParticipating;
  final String title;
  final int clubId;
  final String clubTitle;
  final String note;
  final String desc;
  final String shortDesc;
  final String date;
  final String location;
  final String startTime;
  final String endTime;
  final String img;
  final Profile profile;

  ClubEvent({
    required this.id,
    required this.totalParticipations,
    required this.isParticipating,
    required this.title,
    required this.clubId,
    required this.clubTitle,
    required this.note,
    required this.desc,
    required this.shortDesc,
    required this.date,
    required this.location,
    required this.startTime,
    required this.endTime,
    required this.img,
    required this.profile,
  });

  factory ClubEvent.fromJson(Map<String, dynamic> json) => ClubEvent(
    id: json["id"],
    totalParticipations: json["total_participations"],
    isParticipating: json["is_participating"],
    title: json["title"],
    clubId: json["club_id"],
    clubTitle: json["club_title"],
    note: json["note"] ?? '',
    desc: json["desc"] ?? '',
    shortDesc: json["short_desc"],
    date: json["date"],
    location: json["location"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    img: json["img"],
    profile: Profile.fromJson(json["profile"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "total_participations": totalParticipations,
    "is_participating": isParticipating,
    "title": title,
    "club_id": clubId,
    "club_title": clubTitle,
    "note": note,
    "desc": desc,
    "short_desc": shortDesc,
    "date": date,
    "location": location,
    "start_time": startTime,
    "end_time": endTime,
    "img": img,
    "profile": profile.toJson(),
  };
}

class Profile {
  final String userName;
  final String img;

  Profile({
    required this.userName,
    required this.img,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    userName: json["userName"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "userName": userName,
    "img": img,
  };
}