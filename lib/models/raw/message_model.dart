class ChatMessage {
  bool isSent;
  String? message;
  String time;
  String userName;
  String type;
  String? mediaSource;

  ChatMessage({
    required this.isSent,
    this.message,
    required this.time,
    required this.userName,
    required this.type,
    this.mediaSource,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      isSent: json['isSent'] ?? false,
      message: json['message'] ?? '',
      time: json['time'] ?? '',
      userName: json['userName'] ?? '',
      type: json['type'] ?? '',
      mediaSource: json['mediaSource'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isSent': isSent,
      'message': message,
      'time': time,
      'userName': userName,
      'type': type,
      "mediaSource": mediaSource,
    };
  }
}