class Message {
  Message({List<String>? error, List<String>? success}) {
    _error = error;
    _success = success;
  }

  Message.fromJson(dynamic json) {
    _error = json['error'] != null ? json['error'].cast<String>() : [];
    _success = json['success'] != null ? json['success'].cast<String>() : [];
  }
  List<String>? _error;
  List<String>? _success;

  List<String>? get error => _error;
  List<String>? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['success'] = _success;
    return map;
  }
}
