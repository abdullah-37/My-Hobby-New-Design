import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/models/club/categories/category_model.dart';
import 'package:hobby_club_app/utils/api_url.dart';
import 'package:http/http.dart' as http;

class CategoryController extends GetxController {
  final GetStorage storage = GetStorage();
  RxBool isLoading = true.obs;
  Rx<CategoryModel?> categoryModel = Rx<CategoryModel?>(null);
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    categories();
  }

  categories() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final res = await http.get(
        Uri.parse('${ApiUrl.baseUrl}${ApiUrl.getCategories}'),
        headers: {'Accept': 'application/json','Authorization': 'Bearer ${storage.read('token') ?? ''}'},
      );

      debugPrint('BaseURL: ${ApiUrl.baseUrl}${ApiUrl.getCategories}');
      debugPrint('Response status: ${res.statusCode}');
      debugPrint('Response body: ${res.body}');

      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        categoryModel.value = categoryModelFromJson(json.encode(body));
      } else {
        errorMessage.value = 'Failed to load category (${res.statusCode})';
        if (res.statusCode == 405) {
          errorMessage.value = 'Server rejected the request. Please check the API endpoint.';
        }
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
      debugPrint('Exception in category: $e');
    } finally {
      isLoading.value = false;
    }
  }
}