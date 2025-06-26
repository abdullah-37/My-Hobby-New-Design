import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/models/auth/profile_model.dart';
import 'package:hobby_club_app/models/club_feed_model.dart';
import 'package:hobby_club_app/utils/api_url.dart';
import 'package:http/http.dart' as http;

class ClubFeedController extends GetxController {
  final GetStorage storage = GetStorage();
  RxBool isLoading = true.obs;
  RxBool isCommentLoading = false.obs;
  RxBool isPostingFeed = false.obs;
  Rx<ClubFeedsModel?> clubFeedModel = Rx<ClubFeedsModel?>(null);
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

  clubFeed({required String clubId}) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final res = await http.get(
        Uri.parse('${ApiUrl.baseUrl}${ApiUrl.getClubFeed}$clubId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${storage.read('token') ?? ''}',
        },
      );

      debugPrint('BaseURL: ${ApiUrl.baseUrl}${ApiUrl.getClubFeed}$clubId');
      debugPrint('Response status: ${res.statusCode}');
      debugPrint('Response body: ${res.body}');

      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        clubFeedModel.value = clubFeedsFromJson(json.encode(body));
      } else {
        errorMessage.value = 'Failed to load clubFeed (${res.statusCode})';
        if (res.statusCode == 405) {
          errorMessage.value =
          'Server rejected the request. Please check the API endpoint.';
        }
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
      debugPrint('Exception in clubFeed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> clubFeedPost({
    required String clubId,
    required String desc,
    File? imageFile,
  }) async {
    isPostingFeed.value = true;
    errorMessage.value = '';

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${ApiUrl.baseUrl}${ApiUrl.getClubFeedPost}'),
      );

      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer ${storage.read('token') ?? ''}',
      });

      request.fields['club_id'] = clubId;
      request.fields['desc'] = desc;

      if (imageFile != null) {
        var multipartFile = await http.MultipartFile.fromPath(
          'img',
          imageFile.path,
        );
        request.files.add(multipartFile);
      }

      debugPrint('BaseURL: ${ApiUrl.baseUrl}${ApiUrl.getClubFeedPost}');
      debugPrint('Fields: ${request.fields}');
      debugPrint('Files: ${request.files.length}');

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        if (body['status'] == true && body['data'] != null) {
          final newFeedData = body['data'];
          final newFeed = ClubFeed(
            id: newFeedData['id'],
            likes: 0,
            isLike: false,
            image: newFeedData['img'] ?? '',
            desc: newFeedData['desc'],
            updatedAt: DateTime.parse(newFeedData['updated_at']),
            profile: FeedProfile(
              userName: profile.userName ?? '',
              firstName: profile.firstName ?? '',
              lastName: profile.lastName ?? '',
              img: profile.img ?? '',
            ),
            comments: [],
          );

          if (clubFeedModel.value != null) {
            clubFeedModel.value!.data.insert(0, newFeed);
            clubFeedModel.refresh();
          }

          return true;
        } else {
          errorMessage.value = body['message'] ?? 'Failed to create post';
          return false;
        }
      } else {
        errorMessage.value = 'Failed to create post (${response.statusCode})';
        if (response.statusCode == 405) {
          errorMessage.value =
          'Server rejected the request. Please check the API endpoint.';
        }
        return false;
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
      debugPrint('Exception in clubFeedPost: $e');
      return false;
    } finally {
      isPostingFeed.value = false;
    }
  }

  Future<void> clubFeedLike({
    required String clubId,
    required String feedId,
    required bool isCurrentlyLiked,
    required int currentLikes,
    required int feedIndex,
  }) async {
    try {
      if (clubFeedModel.value != null) {
        final newLikeStatus = !isCurrentlyLiked;
        clubFeedModel.value!.data[feedIndex].isLike = newLikeStatus;
        clubFeedModel.value!.data[feedIndex].likes =
        newLikeStatus ? currentLikes + 1 : currentLikes - 1;
        clubFeedModel.refresh();

        final header = {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${storage.read('token') ?? ''}',
        };

        final requestBody = {
          'club_id': clubId,
          'like': newLikeStatus ? '1' : '0',
          'feed_id': feedId
        };

        final res = await http.post(
          Uri.parse('${ApiUrl.baseUrl}${ApiUrl.likePost}'),
          headers: header,
          body: requestBody,
        );

        debugPrint('BaseURL: ${ApiUrl.baseUrl}${ApiUrl.likePost}');
        debugPrint('API body: $requestBody');
        debugPrint('Response status: ${res.statusCode}');
        debugPrint('Response body: ${res.body}');

        if (res.statusCode != 200) {
          clubFeedModel.value!.data[feedIndex].isLike = isCurrentlyLiked;
          clubFeedModel.value!.data[feedIndex].likes = currentLikes;
          clubFeedModel.refresh();
          errorMessage.value = 'Failed to like post (${res.statusCode})';
        }
      }
    } catch (e) {
      if (clubFeedModel.value != null) {
        clubFeedModel.value!.data[feedIndex].isLike = isCurrentlyLiked;
        clubFeedModel.value!.data[feedIndex].likes = currentLikes;
        clubFeedModel.refresh();
      }
      errorMessage.value = 'Error: ${e.toString()}';
      debugPrint('Exception in clubFeedLike: $e');
    }
  }

  Future<bool> clubFeedComment({
    required String clubId,
    required String feedId,
    required String comment,
    required int feedIndex,
  }) async {
    if (clubFeedModel.value == null) return false;

    isCommentLoading.value = true;
    errorMessage.value = '';

    final tempComment = FeedComment(
      id: DateTime.now().millisecondsSinceEpoch,
      comment: comment,
      updatedAt: DateTime.now(),
      userId: storage.read('user_id') ?? 0,
      profile: CommentProfile(
        userName: storage.read('username') ?? 'You',
        img: storage.read('user_img') ?? 'https://picsum.photos/150/150?random=currentuser',
      ),
    );

    clubFeedModel.value!.data[feedIndex].comments.add(tempComment);
    clubFeedModel.refresh();

    try {
      final res = await http.post(
        Uri.parse('${ApiUrl.baseUrl}${ApiUrl.createComment}'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${storage.read('token') ?? ''}',
        },
        body: {'club_id': clubId, 'comment': comment, 'feed_id': feedId},
      );

      debugPrint('BaseURL: ${ApiUrl.baseUrl}${ApiUrl.createComment}');
      debugPrint('Response status: ${res.statusCode}');
      debugPrint('Response body: ${res.body}');

      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);

        if (body['data'] != null) {
          clubFeedModel.value!.data[feedIndex].comments.removeLast();

          final newComment = FeedComment(
            id: body['data']['id'],
            comment: body['data']['comment'],
            updatedAt: DateTime.parse(body['data']['updated_at']),
            userId: body['data']['user_id'],
            profile: CommentProfile(
              userName: storage.read('username') ?? 'You',
              img: storage.read('user_img') ?? 'https://picsum.photos/150/150?random=currentuser',
            ),
          );

          clubFeedModel.value!.data[feedIndex].comments.add(newComment);
          clubFeedModel.refresh();
        }

        isCommentLoading.value = false;
        return true;
      } else {
        clubFeedModel.value!.data[feedIndex].comments.removeLast();
        clubFeedModel.refresh();

        errorMessage.value = 'Failed to post comment (${res.statusCode})';
        if (res.statusCode == 405) {
          errorMessage.value =
          'Server rejected the request. Please check the API endpoint.';
        }
        isCommentLoading.value = false;
        return false;
      }
    } catch (e) {
      clubFeedModel.value!.data[feedIndex].comments.removeLast();
      clubFeedModel.refresh();

      errorMessage.value = 'Error: ${e.toString()}';
      debugPrint('Exception in clubFeedComment: $e');
      isCommentLoading.value = false;
      return false;
    }
  }
}