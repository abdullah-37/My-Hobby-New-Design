import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/models/club/categories/category_club_model.dart';
import 'package:hobby_club_app/utils/api_url.dart';
import 'package:http/http.dart' as http;

class CategoryClubController extends GetxController {
  final GetStorage storage = GetStorage();
  RxBool isLoading = true.obs;
  Rx<CategoryClubModel?> categoryClubModel = Rx<CategoryClubModel?>(null);
  RxString errorMessage = ''.obs;

  categoryClub({required String categoryId}) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final res = await http.get(
        Uri.parse('${ApiUrl.baseUrl}${ApiUrl.getAllClub}?cat_id=$categoryId'),
        headers: {'Accept': 'application/json','Authorization': 'Bearer ${storage.read('token') ?? ''}'},
      );

      debugPrint('Base Url: ${ApiUrl.baseUrl}${ApiUrl.getAllClub}?cat_id=$categoryId');
      debugPrint('Response status: ${res.statusCode}');
      debugPrint('Response body: ${res.body}');

      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        categoryClubModel.value = categoryClubModelFromJson(json.encode(body));
      } else {
        errorMessage.value = 'Failed to load category clubs (${res.statusCode})';
        if (res.statusCode == 405) {
          errorMessage.value = 'Server rejected the request. Please check the API endpoint.';
        }
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
      debugPrint('Exception in categoryClub: $e');
    } finally {
      isLoading.value = false;
    }
  }
}