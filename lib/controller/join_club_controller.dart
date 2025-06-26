import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/utils/api_url.dart';
import 'package:hobby_club_app/view/screens/club/joined_club_detail_screen.dart';
import 'package:http/http.dart' as http;

class JoinClubController extends GetxController {
  final GetStorage storage = GetStorage();
  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;

  joinClub({required String clubId}) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final res = await http.post(
        Uri.parse('${ApiUrl.baseUrl}${ApiUrl.getJoinClub}'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${storage.read('token') ?? ''}',
        },
        body: {'club_id': clubId},
      );

      print('Base Url: ${ApiUrl.baseUrl}${ApiUrl.getJoinClub}');
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');

      if (res.statusCode == 200) {
        final responseJson = jsonDecode(res.body);
        final clubData = responseJson['data']['club'];
        final clubId = clubData['id'];
        final clubName = clubData['title'] ?? '';
        final clubDesc = clubData['desc'] ?? '';
        final clubImage = clubData['img'] ?? '';
        Get.off(
          JoinedClubDetailScreen(
            clubId: clubId.toString(),
            clubImage: clubImage,
            clubName: clubName,
            clubDesc: clubDesc,
          ),
        );
      } else {
        errorMessage.value = 'Failed to load Join clubs (${res.statusCode})';
        if (res.statusCode == 405) {
          errorMessage.value =
              'Server rejected the request. Please check the API endpoint.';
        }
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
      debugPrint('Exception in joinClub: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
