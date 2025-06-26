import 'dart:convert';

import 'package:hobby_club_app/models/auth/profile_model.dart';
import 'package:hobby_club_app/models/raw/user_model.dart';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    String? message,
    bool? status,
    User? user,
    ProfileModel? profile,
    String? token,
  }) {
    _message = message;
    _status = status;
    _user = user;
    _profile = profile;
    _token = token;
  }

  String? _message;
  bool? _status;
  User? _user;
  ProfileModel? _profile;
  String? _token;

  String? get message => _message;
  bool? get status => _status;
  User? get user => _user;
  ProfileModel? get profile => _profile;
  String? get token => _token;

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      message: json['message'],
      status: json['status'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      profile:
          (json['profile'] is Map<String, dynamic>)
              ? ProfileModel.fromJson(json['profile'])
              : null,
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    if (_user != null) map['user'] = _user!.toJson();
    if (_profile != null) map['profile'] = _profile!.toJson();
    map['token'] = _token;
    return map;
  }
}
