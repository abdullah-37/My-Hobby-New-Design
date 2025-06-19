class ProfileModel {
  ProfileModel({
    this.id,
    this.userId,
    this.userName,
    this.firstName,
    this.lastName,
    this.dob,
    this.gender,
    this.img,
  });

  int? id;
  int? userId;
  String? userName;
  String? firstName;
  String? lastName;
  String? dob;
  String? gender;
  String? img;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json['id'],
    userId: json['user_id'],
    userName: json['userName'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    dob: json['dob'],
    gender: json['gender'],
    img: json['img'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'userName': userName,
    'first_name': firstName,
    'last_name': lastName,
    'dob': dob,
    'gender': gender,
    'img': img,
  };
}
