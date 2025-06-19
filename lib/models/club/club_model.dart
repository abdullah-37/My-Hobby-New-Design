class ClubModel {
  final String message;
  final bool status;
  final List<Club> data;

  ClubModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory ClubModel.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Club> clubsList = list.map((i) => Club.fromJson(i)).toList();

    return ClubModel(
      message: json['message'],
      status: json['status'],
      data: clubsList,
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'status': status,
    'data': data.map((club) => club.toJson()).toList(),
  };
}

class Club {
  final int id;
  final int userId;
  final String title;
  final String desc;
  final String category;
  final String status;
  final String img;
  final int membersCount;

  Club({
    required this.id,
    required this.userId,
    required this.title,
    required this.desc,
    required this.category,
    required this.status,
    required this.img,
    required this.membersCount,
  });

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      desc: json['desc'],
      category: json['category'],
      status: json['status'],
      img: json['img'],
      membersCount: json['members_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'desc': desc,
      'category': category,
      'status': status,
      'img': img,
      'members_count': membersCount,
    };
  }
}

