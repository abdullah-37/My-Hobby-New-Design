import 'dart:convert';

/// title : "Study Club"
/// desc : "This is the club which shows electric solution so everyone can find a way to solve issues themselves :)"
/// category : "electric"

CreateClubModel createClubModelFromJson(String str) =>
    CreateClubModel.fromJson(json.decode(str));
String createClubModelToJson(CreateClubModel data) =>
    json.encode(data.toJson());

class CreateClubModel {
  CreateClubModel({String? title, String? desc, String? category}) {
    _title = title;
    _desc = desc;
    _category = category;
  }

  CreateClubModel.fromJson(dynamic json) {
    _title = json['title'];
    _desc = json['desc'];
    _category = json['category'];
  }
  String? _title;
  String? _desc;
  String? _category;
  CreateClubModel copyWith({String? title, String? desc, String? category}) =>
      CreateClubModel(
        title: title ?? _title,
        desc: desc ?? _desc,
        category: category ?? _category,
      );
  String? get title => _title;
  String? get desc => _desc;
  String? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['desc'] = _desc;
    map['category'] = _category;
    return map;
  }
}
