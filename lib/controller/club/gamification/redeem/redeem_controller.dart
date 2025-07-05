import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/models/club/gamification/redeem/redeem_model.dart';
import 'package:hobby_club_app/utils/api_url.dart';
import 'package:http/http.dart' as http;

class RedeemController extends GetxController {
  final GetStorage storage = GetStorage();
  final isLoading = true.obs;
  final errorMessage = ''.obs;
  final clubRedeemModel = Rx<ClubRedeemModel?>(null);

  Future<void> fetchRedeemReward() async {
    try {
      isLoading(true);
      errorMessage('');

      final res = await http.get(
        Uri.parse(
          '${ApiUrl.baseUrl}${ApiUrl.Redeems}',
        ),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${storage.read('token') ?? ''}',
        },
      );

      debugPrint('BaseUrl: ${ApiUrl.baseUrl}${ApiUrl.Redeems}');
      debugPrint('Response status: ${res.statusCode}');
      debugPrint('Response body: ${res.body}');

      if (res.statusCode == 200) {
        final responseData = json.decode(res.body);
        clubRedeemModel.value = ClubRedeemModel.fromJson(responseData);
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

  Future<bool> redeemReward({
    required String rewardId,
    required String points,
  }) async {
    try {
      isLoading(true);
      errorMessage('');

      final header = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${storage.read('token') ?? ''}',
      };

      final body = {
        'id': rewardId,
        'points': points,
      };

      final res = await http.post(
        Uri.parse('${ApiUrl.baseUrl}${ApiUrl.RedeemReward}'),
        headers: header,
        body: body,
      );

      debugPrint('Redeem response: ${res.statusCode} - ${res.body}');

      final response = json.decode(res.body);

      if (res.statusCode == 200 && response['status'] == true) {
        return true;
      } else {
        errorMessage(response['message'] ?? 'Redemption failed');
        return false;
      }
    } catch (e) {
      errorMessage('Error: ${e.toString()}');
      debugPrint('Redeem exception: $e');
      return false;
    } finally {
      isLoading(false);
    }
  }

}