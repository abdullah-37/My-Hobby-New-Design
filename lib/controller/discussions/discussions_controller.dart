import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/models/discussion_model.dart';
import 'package:hobby_club_app/models/response_model.dart';
import 'package:hobby_club_app/repo/discussion_repo.dart';

import 'package:timeago/timeago.dart' as timeago;

class DiscussionsController extends GetxController with WidgetsBindingObserver {
  DiscussionRepository discussionRepository = DiscussionRepository();
  RxList<Discussions> discussions = <Discussions>[].obs;
  RxBool isLoading = false.obs;
  late final int id;

  @override
  void onInit() {
    // print('initialized');
    id = Get.arguments["id"];
    WidgetsBinding.instance.addObserver(this);

    getClubDiscussions(id);
    super.onInit();
  }

  @override
  void onResume() {
    // Called when screen comes back into view
    getClubDiscussions(id);
  }

  String timeAgoSince(String createdAt) {
    try {
      final dateTime = DateTime.parse(createdAt);
      return timeago.format(dateTime, locale: 'en');
    } catch (e) {
      return 'Invalid date';
    }
  }

  void getClubDiscussions(int clubId) async {
    isLoading.value = true;
    try {
      ResponseModel response = await discussionRepository.getClubDiscussions(8);
      if (response.isSuccess) {
        // print('Discussions ${jsonDecode(response.responseJson)}');

        DiscussionsModel discussionsModel = DiscussionsModel.fromJson(
          jsonDecode(response.responseJson),
        );
        discussions.value = discussionsModel.data;
      }
    } catch (e) {
      // print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> createClubDiscussions({
    required String clubId,
    required String title,
    required String description,
  }) async {
    isLoading.value = true;
    try {
      ResponseModel response = await discussionRepository.createDiscussion(
        clubId: clubId,
        title: title,
        description: description,
      );
      print(jsonEncode(response.responseJson));
      if (response.isSuccess) {
        getClubDiscussions(id);
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
}
