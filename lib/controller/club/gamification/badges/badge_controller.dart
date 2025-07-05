import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/models/auth/profile_model.dart';
import 'package:hobby_club_app/models/club/gamification/badges/badges_model.dart';
import 'package:hobby_club_app/utils/api_url.dart';
import 'package:http/http.dart' as http;

class BadgeController extends GetxController {
  final GetStorage storage = GetStorage();
  final isLoading = true.obs;
  final errorMessage = ''.obs;
  final badgeModel = Rx<BadgeModel?>(null);
  final profile = Rx<ProfileModel?>(null);

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  void getProfile() {
    final userData = storage.read("profile");
    if (userData != null) {
      profile.value = ProfileModel.fromJson(userData);
    }
  }

  Future<void> fetchBadgesDetails({
    required String clubId,
  }) async {
    try {
      isLoading(true);
      errorMessage('');

      final res = await http.get(
        Uri.parse(
          '${ApiUrl.baseUrl}${ApiUrl.UserBadges}?club_id=$clubId',
        ),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${storage.read('token') ?? ''}',
        },
      );

      debugPrint('BaseUrl: ${ApiUrl.baseUrl}${ApiUrl.UserBadges}?club_id=$clubId');
      debugPrint('Response status: ${res.statusCode}');
      debugPrint('Response body: ${res.body}');

      if (res.statusCode == 200) {
        final responseData = json.decode(res.body);
        badgeModel.value = BadgeModel.fromJson(responseData);
      } else {
        errorMessage('Failed to load User Badges (${res.statusCode})');
        if (res.statusCode == 405) {
          errorMessage('Server rejected the request. Please check the API endpoint.');
        }
      }
    } catch (e) {
      errorMessage('Error: ${e.toString()}');
      debugPrint('Exception in User Badges: $e');
    } finally {
      isLoading(false);
    }
  }
}