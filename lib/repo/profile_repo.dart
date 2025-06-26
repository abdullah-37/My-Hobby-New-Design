import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hobby_club_app/models/auth/profile_model.dart';
import 'package:hobby_club_app/models/raw/response_model.dart';
import 'package:hobby_club_app/services/api_services.dart';
import 'package:hobby_club_app/utils/api_url.dart';

class ProfileRepo {
  final ApiServices _api = ApiServices();

  Future<ResponseModel> profileComplete(
    ProfileModel profileModel,
    File image,
  ) async {
    Map<String, String> map = {
      "userName": profileModel.userName ?? "",
      "first_name": profileModel.firstName ?? "",
      "last_name": profileModel.lastName ?? "",
      "dob": profileModel.dob ?? "",
      "gender": profileModel.gender?.toLowerCase() ?? "",
    };

    String url = '${ApiUrl.baseUrl}${ApiUrl.profileEndPoint}';
    ResponseModel responseModel = await _api.uploadMultipartRequest(
      url,
      map,
      file: image,
    );
    debugPrint(responseModel.responseJson);
    return responseModel;
  }

  Future<ResponseModel> profileUpdateWithoutImage(
    ProfileModel profileModel,
  ) async {
    Map<String, String> map = {
      "userName": profileModel.userName ?? "",
      "first_name": profileModel.firstName ?? "",
      "last_name": profileModel.lastName ?? "",
      "dob": profileModel.dob ?? "",
      "gender": profileModel.gender?.toLowerCase() ?? "",
    };

    String url = '${ApiUrl.baseUrl}${ApiUrl.profileEndPoint}';
    ResponseModel responseModel = await _api.postRequest(url, map);
    debugPrint(responseModel.responseJson);
    return responseModel;
  }
}
