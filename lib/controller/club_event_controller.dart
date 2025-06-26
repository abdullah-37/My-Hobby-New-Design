import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/models/auth/profile_model.dart';
import 'package:hobby_club_app/models/club_event_model.dart';
import 'package:hobby_club_app/utils/api_url.dart';
import 'package:http/http.dart' as http;

class ClubEventController extends GetxController {
  final GetStorage storage = GetStorage();
  RxBool isLoading = true.obs;
  RxBool isPostingEvent = false.obs;
  Rx<ClubEventModel?> clubEventModel = Rx<ClubEventModel?>(null);
  RxString errorMessage = ''.obs;
  ProfileModel profile = ProfileModel();

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  getProfile() {
    final userData = storage.read("profile");
    print(userData);

    if (userData != null) {
      profile = ProfileModel.fromJson(userData);
    }
  }

  clubEvent({required String clubId}) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final res = await http.get(
        Uri.parse('${ApiUrl.baseUrl}${ApiUrl.getClubEvent}$clubId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${storage.read('token') ?? ''}',
        },
      );

      debugPrint('BaseURL: ${ApiUrl.baseUrl}${ApiUrl.getClubEvent}$clubId');
      debugPrint('Response status: ${res.statusCode}');
      debugPrint('Response body: ${res.body}');

      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        clubEventModel.value = clubEventModelFromJson(json.encode(body));
      } else {
        errorMessage.value = 'Failed to load clubEvent (${res.statusCode})';
        if (res.statusCode == 405) {
          errorMessage.value =
          'Server rejected the request. Please check the API endpoint.';
        }
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
      debugPrint('Exception in clubEvent: $e');
    } finally {
      isLoading.value = false;
    }
  }

  allClubEvent() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final res = await http.get(
        Uri.parse('${ApiUrl.baseUrl}${ApiUrl.getAllClubEvent}'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${storage.read('token') ?? ''}',
        },
      );

      debugPrint('BaseURL: ${ApiUrl.baseUrl}${ApiUrl.getAllClubEvent}');
      debugPrint('Response status: ${res.statusCode}');
      debugPrint('Response body: ${res.body}');

      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        clubEventModel.value = clubEventModelFromJson(json.encode(body));
      } else {
        errorMessage.value = 'Failed to load allClubEvent (${res.statusCode})';
        if (res.statusCode == 405) {
          errorMessage.value =
          'Server rejected the request. Please check the API endpoint.';
        }
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
      debugPrint('Exception in allClubEvent: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> clubEventPost({
    required String clubId,
    required String title,
    required String shortDesc,
    required String desc,
    required String location,
    required String note,
    required String date,
    required String startTime,
    required String endTime,
    File? imageFile,
  }) async {
    isPostingEvent.value = true;
    errorMessage.value = '';

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${ApiUrl.baseUrl}${ApiUrl.getClubEventPost}'),
      );

      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer ${storage.read('token') ?? ''}',
      });

      request.fields['club_id'] = clubId;
      request.fields['title'] = title;
      request.fields['short_desc'] = shortDesc;
      request.fields['desc'] = desc;
      request.fields['location'] = location;
      request.fields['note'] = note;
      request.fields['date'] = date;
      request.fields['start_time'] = startTime;
      request.fields['end_time'] = endTime;

      if (imageFile != null) {
        var multipartFile = await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
        );
        request.files.add(multipartFile);
      }

      debugPrint('BaseURL: ${ApiUrl.baseUrl}${ApiUrl.getClubEventPost}');
      debugPrint('Fields: ${request.fields}');
      debugPrint('Files: ${request.files.length}');

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
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
      isPostingEvent.value = false;
    }
  }

}