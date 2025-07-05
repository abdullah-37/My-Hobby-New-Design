import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/models/club/gamification/points/total_point_model.dart';
import 'package:hobby_club_app/utils/api_url.dart';
import 'package:http/http.dart' as http;

class TotalPointController extends GetxController {
  final GetStorage storage = GetStorage();
  final isLoading = true.obs;
  final errorMessage = ''.obs;
  final clubTotalPointsModel = Rx<ClubTotalPointsModel?>(null);

  Future<void> fetchTotalPoints({
    required String clubId,
  }) async {
    try {
      isLoading(true);
      errorMessage('');

      final res = await http.get(
        Uri.parse(
          '${ApiUrl.baseUrl}${ApiUrl.UserClubAllPoints}?club_id=$clubId',
        ),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${storage.read('token') ?? ''}',
        },
      );

      debugPrint('BaseUrl: ${ApiUrl.baseUrl}${ApiUrl.UserClubAllPoints}?club_id=$clubId');
      debugPrint('Response status: ${res.statusCode}');
      debugPrint('Response body: ${res.body}');

      if (res.statusCode == 200) {
        final responseData = json.decode(res.body);
        clubTotalPointsModel.value = ClubTotalPointsModel.fromJson(responseData);
      } else {
        errorMessage('Failed to load User total Points (${res.statusCode})');
        if (res.statusCode == 405) {
          errorMessage('Server rejected the request. Please check the API endpoint.');
        }
      }
    } catch (e) {
      errorMessage('Error: ${e.toString()}');
      debugPrint('Exception in User total Points: $e');
    } finally {
      isLoading(false);
    }
  }
}