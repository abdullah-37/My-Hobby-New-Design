import 'package:flutter/material.dart';
import 'package:hobby_club_app/models/response_model.dart';
import 'package:hobby_club_app/services/api_services.dart';
import 'package:hobby_club_app/utils/api_url.dart';

class DiscussionRepository {
  final ApiServices _api = ApiServices();

  Future<ResponseModel> getClubDiscussions(int clubId) async {
    final url = '${ApiUrl.baseUrl}${ApiUrl.getClubDiscussions}/$clubId';
    // print(url);
    ResponseModel responseModel = await _api.getRequest(url, passHeader: true);
    // print(responseModel);

    return responseModel;
  }

  // Craete discussions
  Future<ResponseModel> createDiscussion({
    required String clubId,
    required String title,
    required String description,
  }) async {
    final map = {"club_id": clubId, "title": title, "desc": description};

    String url = '${ApiUrl.baseUrl}${ApiUrl.createClubDiscussions}';
    ResponseModel responseModel = await _api.postRequest(url, map);
    debugPrint(responseModel.responseJson);
    return responseModel;
  }
}
