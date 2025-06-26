class User {
  User({this.id, this.email, this.phone, this.proStatus});

  int? id;
  String? email;
  String? phone;
  int? proStatus;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    email: json['email'],
    phone: json['phone'],
    proStatus: json['pro_status'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'phone': phone,
    'pro_status': proStatus,
  };
}
