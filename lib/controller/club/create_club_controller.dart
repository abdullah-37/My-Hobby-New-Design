import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/utils/api_url.dart';
import 'package:hobby_club_app/view/screens/home_screen.dart';
import 'package:http/http.dart' as http;

class CreateClubController extends GetxController {
  final GetStorage storage = GetStorage();
  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;

  Future<void> clubEventPost({
    required String title,
    required String desc,
    required String categoryId,
    File? imageFile,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${ApiUrl.baseUrl}${ApiUrl.createClubEndPoint}'),
      );

      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer ${storage.read('token') ?? ''}',
      });

      request.fields['title'] = title;
      request.fields['desc'] = desc;
      request.fields['category_id'] = categoryId;

      if (imageFile != null) {
        var multipartFile = await http.MultipartFile.fromPath(
          'img',
          imageFile.path,
        );
        request.files.add(multipartFile);
      }

      debugPrint('BaseURL: ${ApiUrl.baseUrl}${ApiUrl.createClubEndPoint}');
      debugPrint('Fields: ${request.fields}');
      debugPrint('Files: ${request.files.length}');

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        Get.off(HomeScreen());
      } else {
        errorMessage.value = 'Failed to create Event (${response.statusCode})';
        if (response.statusCode == 405) {
          errorMessage.value =
          'Server rejected the request. Please check the API endpoint.';
        }
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
      debugPrint('Exception in clubEventPost: $e');
    } finally {
      isLoading.value = false;
    }
  }

}