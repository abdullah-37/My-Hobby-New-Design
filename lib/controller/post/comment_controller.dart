import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/repo/club/create_club_repo.dart';
import 'package:hobby_club_app/utils/app_strings.dart';
import 'package:hobby_club_app/view/widgets/custom_snackbar.dart';

class CreateCommentController extends GetxController {
  CreateClubRepo repo = CreateClubRepo();

  final commentController = TextEditingController();

  final commentFocus = FocusNode();

  Future<void> createClub() async {
    final comment = commentController.text.trim();
    try {
      // CreateClubModel createClubModel = CreateClubModel(
      //   title: clubName,
      //   category: clubCategory,
      //   desc: description,
      // );
      // ResponseModel response = await repo.createClub(
      //   createClubModel,
      // );
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
    commentController.dispose();

    commentFocus.dispose();
    super.onClose();
  }
}
