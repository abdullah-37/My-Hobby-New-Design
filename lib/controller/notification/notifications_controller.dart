import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/utils/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationsController extends GetxController {
  RxBool isSubscribed = false.obs;
  final storage = GetStorage();
  bool isLoading = false;

  @override
  void onInit() {
    initialize();
    super.onInit();
  }

  void initialize({String? userId}) async {
    if (userId!.isEmpty) {
      debugPrint("🔔 Error: User ID is empty");
      return;
    }

    String appId = 'fe12d7bc-0419-455f-bf18-b2a30c859e03';
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.initialize(appId);
    await OneSignal.Notifications.requestPermission(true);
    await OneSignal.login(userId);

    final oneSignalId = await OneSignal.User.getOnesignalId();
    final oneSignalExternalId = await OneSignal.User.getExternalId();

    debugPrint("🔔 OneSignal userId: $oneSignalId");
    debugPrint("🔔 OneSignal oneSignalExternalId: $oneSignalExternalId");

    saveNotificationID(userId: userId, playerId: oneSignalId.toString());

    isSubscribed.value = OneSignal.User.pushSubscription.optedIn!;
  }

  Future<void> toggleNotifications({
    required bool value,
    required String userId,
  }) async {
    try {
      if (value) {
        bool permissionGranted = await OneSignal
            .Notifications.requestPermission(true);
        if (permissionGranted) {
          await OneSignal.login(userId);
          await OneSignal.User.pushSubscription.optIn();
          debugPrint("subscribing user: $userId");

          isSubscribed.value = true;
        } else {}
      } else {
        debugPrint("Logging out and unsubscribing user: $userId");
        await OneSignal.logout();
        await OneSignal.User.pushSubscription.optOut();

        debugPrint("User unsubscribed from notifications and logged out.");
        isSubscribed.value = false;
      }
    } catch (e) {
      debugPrint("Error toggling notifications: $e");
    }
  }

  void saveNotificationID({
    required String userId,
    required String playerId,
  }) async {
    isLoading = true;
    update();
    try {
      final body = {'id': userId, 'player_id': playerId};
      final header = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${storage.read('token') ?? ''}',
      };

      final response = await http.post(
        Uri.parse('${ApiUrl.baseUrl}${ApiUrl.SavePlayerId}'),
        headers: header,
        body: body,
      );

      if (response.statusCode == 200) {
      } else {
        debugPrint(response.body);
      }
    } catch (e) {
      debugPrint('error in saveNotificationID: $e');
    } finally {
      isLoading = false;
      update();
    }
  }
}
