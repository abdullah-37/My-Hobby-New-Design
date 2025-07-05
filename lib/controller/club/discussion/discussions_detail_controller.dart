import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/models/auth/profile_model.dart';
import 'package:hobby_club_app/models/club/discussion/discussions_detail_model.dart';
import 'package:hobby_club_app/utils/api_url.dart';
import 'package:http/http.dart' as http;

class DiscussionsDetailController extends GetxController {
  final GetStorage storage = GetStorage();
  final isLoading = true.obs;
  final isReplyLoading = false.obs;
  final errorMessage = ''.obs;
  final discussionDetail = Rx<DiscussionDetail?>(null);
  final profile = Rx<ProfileModel?>(null);
  final replies = <DiscussionReply>[].obs;
  final replyController = TextEditingController();
  final scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  @override
  void onClose() {
    replyController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void getProfile() {
    final userData = storage.read("profile");
    if (userData != null) {
      profile.value = ProfileModel.fromJson(userData);
    }
  }

  Future<void> fetchDiscussionDetails({
    required String clubId,
    required String discussionsId
  }) async {
    try {
      isLoading(true);
      errorMessage('');

      final res = await http.get(
        Uri.parse(
          '${ApiUrl.baseUrl}${ApiUrl.getDiscussionsDetails}$clubId/$discussionsId',
        ),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${storage.read('token') ?? ''}',
        },
      );

      debugPrint('Response status: ${res.statusCode}');
      debugPrint('Response body: ${res.body}');

      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        final model = discussionDetailModelFromJson(json.encode(body));

        if (model.data.isNotEmpty) {
          discussionDetail.value = model.data.first;
          replies.assignAll(model.data.first.replies);
        }
      } else {
        errorMessage('Failed to load discussion (${res.statusCode})');
        if (res.statusCode == 405) {
          errorMessage('Server rejected the request. Please check the API endpoint.');
        }
      }
    } catch (e) {
      errorMessage('Error: ${e.toString()}');
      debugPrint('Exception in fetchDiscussionDetails: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<bool> addReply({
    required String clubId,
    required String discussionId,
    required String replyText,
  }) async {
    if (discussionDetail.value == null) return false;
    isReplyLoading.value = true;
    errorMessage.value = '';

    final tempReply = DiscussionReply(
      replyId: DateTime.now().millisecondsSinceEpoch,
      reply: replyText,
      createdAt: DateTime.now(),
      userName: profile.value!.userName ?? 'You',
      image: profile.value!.img ?? 'https://picsum.photos/150/150?random=currentuser',
    );
    replies.insert(0, tempReply);
    replyController.clear();

    try {
      final res = await http.post(
        Uri.parse('${ApiUrl.baseUrl}${ApiUrl.discussionReply}'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${storage.read('token') ?? ''}',
        },
        body: {
          'club_id': clubId,
          'disscussion_id': discussionId,
          'reply': replyText,
        },
      );

      debugPrint('BaseURL: ${ApiUrl.baseUrl}${ApiUrl.discussionReply}');
      debugPrint('Response status: ${res.statusCode}');
      debugPrint('Response body: ${res.body}');

      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);

        if (body['data'] != null) {
          replies.removeAt(0);
          final newReply = DiscussionReply(
            replyId: body['data']['id'],
            reply: body['data']['reply'],
            createdAt: DateTime.now(),
            userName: profile.value!.userName ?? 'You',
            image: profile.value!.img ?? 'https://picsum.photos/150/150?random=currentuser',
          );

          replies.insert(0, newReply);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (scrollController.hasClients) {
              scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          });
        }

        isReplyLoading.value = false;
        return true;
      } else {
        replies.removeAt(0);

        errorMessage.value = 'Failed to post reply (${res.statusCode})';
        if (res.statusCode == 405) {
          errorMessage.value =
          'Server rejected the request. Please check the API endpoint.';
        }
        isReplyLoading.value = false;
        return false;
      }
    } catch (e) {
      replies.removeAt(0);
      errorMessage.value = 'Error: ${e.toString()}';
      debugPrint('Exception in addReply: $e');
      isReplyLoading.value = false;
      return false;
    }
  }

  String formatDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      DateTime now = DateTime.now();
      Duration difference = now.difference(date);

      if (difference.inDays > 0) {
        return '${difference.inDays}d ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}h ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}m ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return 'Unknown';
    }
  }
}