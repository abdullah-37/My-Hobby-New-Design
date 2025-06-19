import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hobby_club_app/models/create_club_model.dart';
import 'package:hobby_club_app/models/response_model.dart';
import 'package:hobby_club_app/services/api_services.dart';
import 'package:hobby_club_app/utils/api_url.dart';

class LikeRepo {
  final ApiServices _api = ApiServices();

  Future<ResponseModel> likePost(int clubId, int postId, int like) async {
    await _api.initToken();
    Map<String, dynamic> map = {
      "club_id": clubId,
      "feed_id": postId,
      "like": like,
    };

    String url = '${ApiUrl.baseUrl}${ApiUrl.likePost}';
    ResponseModel responseModel = await _api.postRequest(url, map);
    debugPrint("Response Like: ${responseModel.responseJson}");
    return responseModel;
  }
}
