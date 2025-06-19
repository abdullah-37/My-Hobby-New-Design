import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/discussions/discussions_controller.dart';
import 'package:hobby_club_app/models/discussions_details_model.dart';
import 'package:hobby_club_app/models/response_model.dart';
import 'package:hobby_club_app/repo/discussin_details_repo.dart';

import 'package:timeago/timeago.dart' as timeago;

class DiscussionDetailsController extends GetxController {
  DiscussionDetailsRepository discussionDetailRepository =
      DiscussionDetailsRepository();
  TextEditingController textReplyController = TextEditingController();

  RxList<DiscussionDetail> discussionReplies = <DiscussionDetail>[].obs;
  DiscussionsController discussionsController =
      Get.find<DiscussionsController>();

  RxBool isLoading = false.obs;

  late final int clubId;
  late final int discussionId;

  @override
  void onInit() {
    // print('initialized');
    clubId = Get.arguments["clubId"];
    discussionId = Get.arguments["discussionId"];

    getDiscussionDetails(clubId: clubId, discussionId: discussionId);
    super.onInit();
  }

  void getDiscussionDetails({
    required int clubId,
    required int discussionId,
  }) async {
    isLoading.value = true;
    try {
      ResponseModel response = await discussionDetailRepository
          .getDiscussionDetails(clubId: clubId, discussionId: discussionId);
      if (response.isSuccess) {
        // print('Discussions ${jsonDecode(response.responseJson)}');

        DiscussionsDetailsModel discussionsDetailsModel =
            DiscussionsDetailsModel.fromJson(jsonDecode(response.responseJson));
        // discussionDe.value = discussionsModel.data;
        discussionReplies.value = discussionsDetailsModel.data;
      }
    } catch (e) {
      // print(e);
    } finally {
      isLoading.value = false;
    }
  }

  //post discussion reply
  void postReply() async {
    try {
      ResponseModel response = await discussionDetailRepository.postReply(
        clubId: clubId.toString(),
        disscussionId: discussionId.toString(),
        reply: textReplyController.text.trim(),
      );
      if (response.isSuccess) {
        print('ppppppp');
        textReplyController.clear();
        getDiscussionDetails(clubId: clubId, discussionId: discussionId);
        discussionsController.getClubDiscussions(clubId);
      }
    } catch (e) {
      print('ppppppp$e');
    }
  }

  String timeAgoSince(String createdAt) {
    try {
      final dateTime = DateTime.parse(createdAt);
      return timeago.format(dateTime, locale: 'en');
    } catch (e) {
      return 'Invalid date';
    }
  }
}
