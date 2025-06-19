import 'club_model.dart';
import 'club_model.dart';

class ClubResponseModel {
  final String message;
  final bool status;
  final Club? success;
  final Map<String, List<String>>? errors;

  ClubResponseModel({
    required this.message,
    required this.status,
    this.success,
    this.errors,
  });

  factory ClubResponseModel.fromJson(Map<String, dynamic> json) {
    return ClubResponseModel(
      message: json['message'] ?? '',
      status: json['status'] ?? false,
      success:
          json['data'] != null
              ? Club.fromJson(json['data'])
              : null, // still reads from data
      errors:
          json['errors'] != null
              ? (json['errors'] as Map<String, dynamic>).map(
                (key, value) => MapEntry(key, List<String>.from(value)),
              )
              : null,
    );
  }
}
