class ClubFeedModel {
  String message;
  bool status;
  List<Data> data;

  ClubFeedModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory ClubFeedModel.fromJson(Map<String, dynamic> json) {
    return ClubFeedModel(
      message: json['message'],
      status: json['status'],
      data: List<Data>.from(json['data']?.map((x) => Data.fromJson(x)) ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'status': status,
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Data {
  int id;
  int likes;
  bool isLike;
  String? image;
  String desc;
  String updatedAt;
  DataProfile profile;
  List<Comment> comments;

  Data({
    required this.id,
    required this.likes,
    required this.isLike,
    required this.image,
    required this.desc,
    required this.updatedAt,
    required this.profile,
    required this.comments,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      likes: json['likes'],
      isLike: json['is_like'],
      image: json['image'],
      desc: json['desc'],
      updatedAt: json['updated_at'],
      profile: DataProfile.fromJson(json['profile']),
      comments: List<Comment>.from(
        json['comments']?.map((x) => Comment.fromJson(x)) ?? [],
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'likes': likes,
    'is_like': isLike,
    'image': image,
    'desc': desc,
    'updated_at': updatedAt,
    'profile': profile.toJson(),
    'comments': List<dynamic>.from(comments.map((x) => x.toJson())),
  };
}

class Comment {
  int id;
  String comment;
  int userId;
  String updatedAt;
  CommentProfile profile;

  Comment({
    required this.id,
    required this.comment,
    required this.userId,
    required this.updatedAt,
    required this.profile,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      comment: json['comment'],
      userId: json['user_id'],
      updatedAt: json['updated_at'],
      profile: CommentProfile.fromJson(json['profile']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'comment': comment,
    'user_id': userId,
    'updated_at': updatedAt,
    'profile': profile.toJson(),
  };
}

class CommentProfile {
  String userName;
  String img;

  CommentProfile({required this.userName, required this.img});

  factory CommentProfile.fromJson(Map<String, dynamic> json) {
    return CommentProfile(userName: json['userName'], img: json['img']);
  }

  Map<String, dynamic> toJson() => {'userName': userName, 'img': img};
}

class DataProfile {
  String userName;
  String firstName;
  String lastName;
  String img;

  DataProfile({
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.img,
  });

  factory DataProfile.fromJson(Map<String, dynamic> json) {
    return DataProfile(
      userName: json['userName'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      img: json['img'],
    );
  }

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'first_name': firstName,
    'last_name': lastName,
    'img': img,
  };
}
