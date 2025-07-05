import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/controller/common/hide_floating_button_controller.dart';
import 'package:hobby_club_app/models/common/user_model.dart';
import 'package:hobby_club_app/utils/app_strings.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/view/screens/auth/login_screen.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/notification/notifications_controller.dart';
import 'package:hobby_club_app/utils/style.dart';
import 'package:hobby_club_app/view/widgets/custom_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isLoading = true;
  GetStorage storage = GetStorage();
  User? user;

  void _logout() {
    Get.dialog(
      AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
          TextButton(
            onPressed: () async {
              Get.back();
              await storage.remove("user");
              await storage.remove("profile");
              await storage.remove("token");
              Get.offAll(const LoginScreen());
            },
            child: const Text(
              AppStrings.logout,
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadUser() async {
    try {
      final userData = storage.read('user');
      if (userData != null) {
        setState(() {
          user = User.fromJson(userData);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error loading user: $e');
    }
  }

  @override
  void initState() {
    loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final floatingController = Get.find<FloatingButtonController>();
    final notificationsController = Get.find<NotificationsController>();

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Settings',
        centerTitle: true,
        isLeading: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: Dimensions.screenPaddingHorizontal,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Language',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Spacer(),
                      Text('English', style: AppStyles.greysubtitle),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Region',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Spacer(),
                      Text('Pakistan', style: AppStyles.greysubtitle),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => Row(
                      children: [
                        Text(
                          'Notifications',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const Spacer(),
                        CupertinoSwitch(
                          value: notificationsController.isSubscribed.value,
                          onChanged: (bool newValue) {
                            notificationsController.toggleNotifications(
                              value: newValue,
                              userId: user!.id.toString(),
                            );
                          },
                          activeTrackColor: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => Row(
                      children: [
                        Text(
                          'Floating Button',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const Spacer(),
                        CupertinoSwitch(
                          value: floatingController.isVisible.value,
                          onChanged: (bool newValue) {
                            floatingController.toggleVisibility();
                          },
                          activeTrackColor: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          Padding(
            padding: Dimensions.screenPaddingHorizontal.copyWith(
              bottom: 20,
              top: 10,
            ),
            child: CustomElevatedButton(
              title: AppStrings.logout,
              onTap: _logout,
            ),
          ),
        ],
      ),
    );
  }
}
