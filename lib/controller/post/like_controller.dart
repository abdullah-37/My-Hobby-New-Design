import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/models/response_model.dart';
import 'package:hobby_club_app/repo/club/create_club_repo.dart';
import 'package:hobby_club_app/repo/post/like_repo.dart';
import 'package:hobby_club_app/utils/app_strings.dart';
import 'package:hobby_club_app/view/widgets/custom_snackbar.dart';

class LikeController extends GetxController {
  LikeRepo repo = LikeRepo();

  Future<void> likePost(int clubId, int postId, int like) async {
    print("TAPPED");
    try {
      ResponseModel response = await repo.likePost(clubId, postId, like);
      // if (response.isSuccess) {
      //   print("Response: ${response.responseJson}");
      //   Get.back();
      //   showCustomSnackBar(AppStrings.success, response.message);
      // } else {
      //   showCustomSnackBar(AppStrings.error, response.message);
      // }
    } catch (e) {
      debugPrint(e.toString());
      showCustomSnackBar(AppStrings.error, AppStrings.somethingWentWrong);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
