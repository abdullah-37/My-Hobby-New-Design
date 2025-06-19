import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/models/club/all_clubs_model.dart';
import 'package:hobby_club_app/models/response_model.dart';
import 'package:hobby_club_app/repo/club/all_club_repo.dart';

class ClubsController extends GetxController {
  TextEditingController searchController = TextEditingController();

  List<AllClub> allClubs = [];
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    fetchClubs();
  }

  Future<void> fetchClubs() async {
    try {
      isLoading = true;
      update();

      ResponseModel response = await AllClubRepo().getAllClubs();
      print('clubssssss${response.responseJson}');

      if (response.isSuccess) {
        final jsonMap = jsonDecode(response.responseJson);
        print(jsonMap);
        AllClubModel allClubsModel = AllClubModel.fromJson(jsonMap);
        allClubs = allClubsModel.data!;
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

  void onSearchChanged() {
    String query = searchController.text.toLowerCase();
    allClubs =
        allClubs
            .where((club) => club.title!.toLowerCase().contains(query))
            .toList();
    update();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
