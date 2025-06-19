class AllClubModel {
  String? message;
  bool? status;
  List<AllClub>? data;

  AllClubModel({this.message, this.status, this.data});

  AllClubModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <AllClub>[];
      json['data'].forEach((v) {
        data!.add(AllClub.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['message'] = message;
    map['status'] = status;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class AllClub {
  int? id;
  String? title;
  String? category;
  String? desc;
  String? img;
  int? totalMembers;
  int? categoryId;
  String? status;

  AllClub({
    this.id,
    this.title,
    this.category,
    this.desc,
    this.img,
    this.categoryId,
    this.totalMembers,
    this.status,
  });

  AllClub.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json["status"];
    category = json['category'];
    categoryId = json['category_id'];
    desc = json['desc'];
    img = json['img'];
    totalMembers = json['total_members'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['title'] = title;
    map['category'] = category;
    map['desc'] = desc;
    map['img'] = img;
    map['total_members'] = totalMembers;
    return map;
  }
}
