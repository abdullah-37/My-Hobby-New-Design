import 'package:get/get.dart';
import 'package:hobby_club_app/services/notification_service.dart';
import 'package:hobby_club_app/view/screens/home_screen.dart';

class NotificationPermissionController extends GetxController {
  NotificationService notificationService = NotificationService();

  /// Call this from your button’s onPressed.
  Future<void> requestNotificationPermission() async {
    await notificationService.initialize();
    // 3. Navigate to the next screen
    //    Replace '/home' with your real route name or widget.
    // Get.offNamed('/home');
    Get.to(() => HomeScreen());
  }
}
