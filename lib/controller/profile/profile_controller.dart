import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/auth/profile_model.dart';
import '../../models/club/club_model.dart';
import '../../models/common/response_model.dart';
import '../../repo/club/my_clubs_repo.dart';

class ProfileController extends GetxController {
  bool isLoading = false;
  GetStorage storage = GetStorage();
  ProfileModel profile = ProfileModel();

  List<Club> allClubs = [];
  List<Club> acceptedClubs = [];
  List<Club> pendingClubs = [];

  @override
  void onInit() {
    getProfile();
    fetchUserClubs();
    super.onInit();
  }

  getProfile() {
    isLoading = true;
    update();

    final userData = storage.read("profile");
    debugPrint('userData :: $userData');

    if (userData != null) {
      profile = ProfileModel.fromJson(userData);
    }

    isLoading = false;
    update();
  }

  Future<void> fetchUserClubs() async {
    try {
      isLoading = true;
      update();

      ResponseModel response = await MyClubsRepo().getMyClubs();

      if (response.isSuccess) {
        final jsonMap = jsonDecode(response.responseJson);
        ClubModel clubModel = ClubModel.fromJson(jsonMap);
        allClubs = clubModel.data;

        // Filter based on status
        acceptedClubs =
            allClubs.where((club) => club.status == 'accept').toList();
        pendingClubs =
            allClubs.where((club) => club.status == 'pending').toList();
      } else {
        debugPrint('Failed to fetch clubs: ${response.message}');
      }
    } catch (e) {
      debugPrint('Error fetching clubs: $e');
    } finally {
      isLoading = false;
      update();
    }
  }
}
