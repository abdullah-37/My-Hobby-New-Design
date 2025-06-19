import 'package:intl/intl.dart';

/// Top‐level response model
class ClubEventsModel {
  final bool success;
  final String message;
  final List<EventModel> data;

  ClubEventsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ClubEventsModel.fromJson(Map<String, dynamic> json) {
    return ClubEventsModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => EventModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data.map((e) => e.toJson()).toList(),
  };
}

/// Individual event/schedule
class EventModel {
  final int id;
  final bool isPrticipated;
  final int totalParticipants;
  final String title;
  final String clubName;
  final int clubId;
  final String note;
  final String desc;
  final DateTime date;
  final String location;
  final String startTime;
  final String endTime;
  final String img;
  final Profile profile;

  EventModel({
    required this.id,
    required this.title,
    required this.clubName,
    required this.isPrticipated,
    required this.totalParticipants,
    required this.clubId,
    required this.note,
    required this.desc,
    required this.date,
    required this.location,
    required this.startTime,
    required this.endTime,
    required this.img,
    required this.profile,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    // The incoming date string is like "08-June-2025".
    // We use DateFormat('dd-MMMM-yyyy') to parse it.
    final rawDate = json['date'] as String;
    final parsedDate = DateFormat('dd-MMMM-yyyy').parse(rawDate);

    return EventModel(
      id: json['id'] as int,
      title: json['title'] as String,
      totalParticipants: json['total_participations'],
      isPrticipated: json['is_participating'] as bool,
      clubName: json['club_title'] as String,

      clubId: json['club_id'] as int,
      note: json['note'] as String,
      desc: json['desc'] as String,
      date: parsedDate,
      location: json['location'] as String,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      img: json['img'] as String,
      profile: Profile.fromJson(json['profile'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    // If you want to convert back to the same string format:
    final dateFormatter = DateFormat('dd-MMMM-yyyy');
    return {
      'id': id,
      'title': title,
      'club_id': clubId,
      'note': note,
      'desc': desc,
      'date': dateFormatter.format(date),
      'location': location,
      'start_time': startTime,
      'end_time': endTime,
      'img': img,
      'profile': profile.toJson(),
    };
  }
}

/// Nested profile object
class Profile {
  final String userName;
  final String img;

  Profile({required this.userName, required this.img});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      userName: json['userName'] as String,
      img: json['img'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'userName': userName, 'img': img};
}

/// DateRange inside Meta
// class DateRange {
//   final DateTime from;
//   final DateTime to;
//   final int days;

//   DateRange({required this.from, required this.to, required this.days});

//   factory DateRange.fromJson(Map<String, dynamic> json) {
//     // The incoming strings are like "5-June-2025" and "12-June-2025".
//     final rawFrom = json['from'] as String;
//     final rawTo = json['to'] as String;

//     final formatter = DateFormat('d-MMMM-yyyy');
//     // Note: 'd' instead of 'dd' because "5-June-2025" has no leading zero.
//     final parsedFrom = formatter.parse(rawFrom);
//     final parsedTo = formatter.parse(rawTo);

//     return DateRange(from: parsedFrom, to: parsedTo, days: json['days'] as int);
//   }

//   Map<String, dynamic> toJson() {
//     final formatter = DateFormat('d-MMMM-yyyy');
//     return {
//       'from': formatter.format(from),
//       'to': formatter.format(to),
//       'days': days,
//     };
//   }
// }
