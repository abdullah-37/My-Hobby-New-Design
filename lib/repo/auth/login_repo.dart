import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/models/response_model.dart';
import 'package:hobby_club_app/services/api_services.dart';
import 'package:hobby_club_app/utils/api_url.dart';

class LoginRepo {
  final ApiServices _api = ApiServices();
  final GetStorage storage = GetStorage();

  Future<ResponseModel> loginUser({
    required String email,
    required String password,
  }) async {
    Map<String, String> map = {'email': email, 'password': password};
    String url = '${ApiUrl.baseUrl}${ApiUrl.loginEndPoint}';
    ResponseModel response = await _api.postRequest(url, map);

    if (response.isSuccess) {
      final data = response.responseJson;
      final decoded = jsonDecode(data);
      final token = decoded['token'];
      final tokenType = decoded['token_type'] ?? 'Bearer';

      if (token != null) {
        // Save token in GetStorage
        await storage.write('token', token);
        await storage.write('token_type', tokenType);
      }
    }

    return response;
  }
}
