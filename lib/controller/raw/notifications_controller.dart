import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationsController extends GetxController {
  RxBool isSubscribed = false.obs;
  @override
  void onInit() {
    initialize();

    super.onInit();
  }

  void initialize() async {
    // String appId = 'd1f939ba-b06b-44fd-aab4-2140a63ea4bf';
    String appId = 'fe12d7bc-0419-455f-bf18-b2a30c859e03';
    String userId = '123456';
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.initialize(appId);
    await OneSignal.Notifications.requestPermission(true);
    await OneSignal.login(userId);

    final oneSignalId = await OneSignal.User.getOnesignalId();
    final oneSignalExternalId = await OneSignal.User.getExternalId();

    print("🔔 OneSignal userId: $oneSignalId");
    print("🔔 OneSignal oneSignalExternalId: $oneSignalExternalId");

    isSubscribed.value = OneSignal.User.pushSubscription.optedIn!;
  }

  Future<void> toggleNotifications(bool value) async {
    const String userId = '123456';
    try {
      if (value) {
        bool permissionGranted = await OneSignal
            .Notifications.requestPermission(true);
        if (permissionGranted) {
          await OneSignal.login(userId);
          await OneSignal.User.pushSubscription.optIn();
          print("subscribing user: $userId");

          isSubscribed.value = true;
        } else {}
      } else {
        print("Logging out and unsubscribing user: $userId");
        await OneSignal.logout();
        await OneSignal.User.pushSubscription.optOut();

        print("User unsubscribed from notifications and logged out.");
        isSubscribed.value = false;
      }

      // final deviceState = await OneSignal.User.getOnesignalId();
      // // print('Logging');
      // print('Logging${OneSignal.User.pushSubscription.op!}');
      // bool isopted = OneSignal.User.pushSubscription.optedIn ?? false;
      // if(isopted){

      // }

      // print(
      // )
    } catch (e) {
      print("Error toggling notifications: $e");
    }
  }
}
