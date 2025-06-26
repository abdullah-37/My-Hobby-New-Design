import 'dart:convert';

import 'package:hobby_club_app/models/auth/registration_model.dart';
import 'package:hobby_club_app/models/raw/response_model.dart';
import 'package:hobby_club_app/services/api_services.dart';
import 'package:hobby_club_app/utils/api_url.dart';

class RegisterRepo {
  final ApiServices _api = ApiServices();

  Future<ResponseModel> registerUser(
    RegistrationModel registrationModel,
  ) async {
    Map<String, String> map = {
      'email': registrationModel.email ?? '',
      'phone': registrationModel.phone ?? '',
      'password': registrationModel.password ?? '',
    };
    String url = '${ApiUrl.baseUrl}${ApiUrl.registrationEndPoint}';
    ResponseModel response = await _api.postRequest(
      url,
      map,
      passHeader: true,
      isOnlyAcceptType: true,
    );
    if (response.isSuccess) {
      final data = response.responseJson;
      final decoded = jsonDecode(data);
      final token = decoded['token'];
      final tokenType = decoded['token_type'] ?? 'Bearer';

      if (token != null) {
        await _api.saveToken(token, type: tokenType);
      }
    }
    return response;
  }
}
