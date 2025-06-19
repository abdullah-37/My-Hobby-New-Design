class RegistrationModel {
  String? phone;
  String? email;
  String? password;

  RegistrationModel({this.phone, this.email, this.password});

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
