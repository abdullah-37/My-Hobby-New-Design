import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/models/auth/profile_model.dart';
import 'package:hobby_club_app/models/club/all_clubs_model.dart';
import 'package:hobby_club_app/models/club/club_model.dart';
import 'package:hobby_club_app/models/response_model.dart';
import 'package:hobby_club_app/repo/club/joined_club_repo.dart';

class WelcomeController extends GetxController {
  GetStorage storage = GetStorage();

  ProfileModel? profile;

  List<AllClub> clubs = [];
  bool isLoading = false;

  @override
  void onInit() async {
    await getUser();
    fetchClubs();
    super.onInit();
  }

  getUser() async {
    isLoading = true;
    update();

    final userData = await storage.read("profile");

    profile = ProfileModel.fromJson(userData);

    isLoading = false;
    update();
  }

  Future<void> fetchClubs() async {
    try {
      isLoading = true;
      update();

      ResponseModel response = await JoinedClubRepo().getJoinClubs();
      print('ssssssssss${response.responseJson}');

      if (response.isSuccess) {
        final jsonMap = jsonDecode(response.responseJson);
        AllClubModel allClubsModel = AllClubModel.fromJson(jsonMap);
        clubs = allClubsModel.data!;
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
