import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/models/auth/profile_model.dart';
import 'package:hobby_club_app/models/club/discussion/club_discussions_model.dart';
import 'package:hobby_club_app/utils/api_url.dart';
import 'package:http/http.dart' as http;

class ClubDiscussionsController extends GetxController {
  final GetStorage storage = GetStorage();
  RxBool isLoading = true.obs;
  RxList<ClubDiscussion> discussions = <ClubDiscussion>[].obs;
  RxString errorMessage = ''.obs;
  ProfileModel profile = ProfileModel();
  int id = 0;

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  getProfile() {
    final userData = storage.read("profile");
    if (userData != null) {
      profile = ProfileModel.fromJson(userData);
    }
  }

  Future<void> clubDiscussion({required String clubId}) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final res = await http.get(
        Uri.parse('${ApiUrl.baseUrl}${ApiUrl.getClubDiscussions}$clubId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${storage.read('token') ?? ''}',
        },
      );

      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        final model = clubDiscussionModelFromJson(json.encode(body));
        discussions.assignAll(model.data);
        id = int.parse(clubId);
      } else {
        errorMessage.value = 'Failed to load discussions (${res.statusCode})';
        if (res.statusCode == 405) {
          errorMessage.value = 'Server rejected the request. Please check the API endpoint.';
        }
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getClubDiscussions(int clubId) async {
    await clubDiscussion(clubId: clubId.toString());
  }

  String timeAgoSince(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} years ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  Future<bool> createDiscussion({
    required int clubId,
    required String title,
    required String description,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('${ApiUrl.baseUrl}${ApiUrl.createClubDiscussions}'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${storage.read('token') ?? ''}',
        },
        body: {
          'club_id': clubId.toString(),
          'title': title,
          'desc': description,
        },
      );

      if (res.statusCode == 200) {
        await getClubDiscussions(clubId);
        return true;
      } else {
        errorMessage.value = 'Failed to create discussion (${res.statusCode})';
        return false;
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
      return false;
    }
  }
}
