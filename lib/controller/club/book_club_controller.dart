import 'dart:convert';

import 'package:get/get.dart';
import 'package:hobby_club_app/models/club/club_feed_model.dart';
import 'package:hobby_club_app/models/response_model.dart';
import 'package:hobby_club_app/repo/club/book_club_repo.dart';
import 'package:timeago/timeago.dart' as timeago;

class BookClubController extends GetxController {
  bool isLoading = false;
  ClubFeedModel? clubFeedModel;

  Future<void> fetchClubFeed(int id) async {
    try {
      isLoading = true;
      update();

      ResponseModel response = await BookClubRepo().getClubFeed(id);

      if (response.isSuccess) {
        final jsonMap = jsonDecode(response.responseJson);
        clubFeedModel = ClubFeedModel.fromJson(jsonMap);
      } else {
        print('Failed to fetch clubs: ${response.message}');
      }
    } catch (e) {
      print('Error fetching clubs: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  String timeAgoSince(String createdAt) {
    try {
      final dateTime = DateTime.parse(createdAt);
      return timeago.format(dateTime, locale: 'en');
    } catch (e) {
      return '';
    }
  }
}
