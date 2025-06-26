import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/models/category_model.dart';
import 'package:hobby_club_app/models/category_model.dart';
import 'package:hobby_club_app/models/my_join_club_model.dart';
import 'package:hobby_club_app/models/trending_club_model.dart';
import 'package:hobby_club_app/utils/api_url.dart';
import 'package:http/http.dart' as http;

class MyJoinClubController extends GetxController {
  final GetStorage storage = GetStorage();
  RxBool isLoading = true.obs;
  Rx<MyJoinClub?> joinClub = Rx<MyJoinClub?>(null);
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    myJoinClub();
  }

  myJoinClub() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final res = await http.get(
        Uri.parse('${ApiUrl.baseUrl}${ApiUrl.getJoinedClub}'),
        headers: {'Accept': 'application/json','Authorization': 'Bearer ${storage.read('token') ?? ''}'},
      );

      debugPrint('BaseURL: ${ApiUrl.baseUrl}${ApiUrl.getCategories}');
      debugPrint('Response status: ${res.statusCode}');
      debugPrint('Response body: ${res.body}');

      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        joinClub.value = myJoinClubFromJson(json.encode(body));
      } else {
        errorMessage.value = 'Failed to load joinClub (${res.statusCode})';
        if (res.statusCode == 405) {
          errorMessage.value = 'Server rejected the request. Please check the API endpoint.';
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