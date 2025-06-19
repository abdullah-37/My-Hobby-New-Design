import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hobby_club_app/models/create_club_model.dart';
import 'package:hobby_club_app/models/response_model.dart';
import 'package:hobby_club_app/services/api_services.dart';
import 'package:hobby_club_app/utils/api_url.dart';

class CreateClubRepo {
  final ApiServices _api = ApiServices();

  Future<ResponseModel> createClub(
    CreateClubModel createClubModel,
    File image,
  ) async {
    await _api.initToken();
    Map<String, String> map = {
      "title": createClubModel.title ?? "",
      "desc": createClubModel.desc ?? "",
      "category": createClubModel.category ?? "",
    };

    String url = '${ApiUrl.baseUrl}${ApiUrl.createClubEndPoint}';
    ResponseModel responseModel = await _api.uploadMultipartRequest(
      url,
      map,
      file: image,
    );
    debugPrint(responseModel.responseJson);
    return responseModel;
  }
}
