import 'package:flutter/material.dart';
import 'package:hobby_club_app/models/response_model.dart';
import 'package:hobby_club_app/services/api_services.dart';
import 'package:hobby_club_app/utils/api_url.dart';

class DiscussionDetailsRepository {
  final ApiServices _api = ApiServices();

  Future<ResponseModel> getDiscussionDetails({
    required int clubId,
    required int discussionId,
  }) async {
    final url =
        '${ApiUrl.baseUrl}${ApiUrl.getDiscussionsDetails}/$clubId/$discussionId';
    // print(url);
    ResponseModel responseModel = await _api.getRequest(url, passHeader: true);
    // print(responseModel);

    return responseModel;
  }

  // Post Reply on Discussion
  Future<ResponseModel> postReply({
    required String clubId,
    required String disscussionId,
    required String reply,
  }) async {
    final map = {
      "club_id": clubId,
      "disscussion_id": disscussionId,
      "reply": reply,
    };

    String url = '${ApiUrl.baseUrl}${ApiUrl.discussionreply}';
    ResponseModel responseModel = await _api.postRequest(url, map);
    debugPrint(responseModel.responseJson);
    return responseModel;
  }
}
