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

  ClubEventModel copyWith({
    bool? success,
    String? message,
    List<ClubEvent>? data,
  }) {
    return ClubEventModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
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

  ClubEvent copyWith({
    int? id,
    int? totalParticipations,
    bool? isParticipating,
    String? title,
    int? clubId,
    String? clubTitle,
    String? note,
    String? desc,
    String? shortDesc,
    String? date,
    String? location,
    String? startTime,
    String? endTime,
    String? img,
    Profile? profile,
  }) {
    return ClubEvent(
      id: id ?? this.id,
      totalParticipations: totalParticipations ?? this.totalParticipations,
      isParticipating: isParticipating ?? this.isParticipating,
      title: title ?? this.title,
      clubId: clubId ?? this.clubId,
      clubTitle: clubTitle ?? this.clubTitle,
      note: note ?? this.note,
      desc: desc ?? this.desc,
      shortDesc: shortDesc ?? this.shortDesc,
      date: date ?? this.date,
      location: location ?? this.location,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      img: img ?? this.img,
      profile: profile ?? this.profile,
    );
  }
}

class Profile {
  final int userId;
  final String userName;
  final String img;

  Profile({
    required this.userId,
    required this.userName,
    required this.img,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    userId: json["user_id"],
    userName: json["userName"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "userName": userName,
    "img": img,
  };
}