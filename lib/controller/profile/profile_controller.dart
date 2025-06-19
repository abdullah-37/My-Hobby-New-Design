import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/models/auth/profile_model.dart';
import 'package:hobby_club_app/models/club/club_model.dart';
import 'package:hobby_club_app/models/response_model.dart';
import 'package:hobby_club_app/repo/club/my_clubs_repo.dart';
import 'package:hobby_club_app/view/screens/auth/login_screen.dart';

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
    print(userData);

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
        print('Failed to fetch clubs: ${response.message}');
      }
    } catch (e) {
      print('Error fetching clubs: $e');
    } finally {
      isLoading = false;
      update();
    }
  }
}
