import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/auth/notification_permission_controller.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/utils/style.dart';
import 'package:hobby_club_app/view/screens/home_screen.dart';
import 'package:hobby_club_app/view/widgets/custom_button.dart';

class NotificationPermissionScreen extends StatelessWidget {
  const NotificationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationPermissionController controller = Get.put(
      NotificationPermissionController(),
    );
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Image.asset(AppImages.bg2, fit: BoxFit.cover),
          // Container(
          //   decoration: BoxDecoration(
          //     color: Colors.black.withValues(alpha: 0.6),
          //   ),
          // ),
          Padding(
            padding: Dimensions.screenPaddingHorizontal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),

                //bell icon
                Icon(
                  Icons.notifications_active_rounded,
                  color: AppColors.primary,
                  size: 70,
                ),
                // text
                Text(
                  textAlign: TextAlign.center,

                  'Don\'t miss important\n updates',
                  style: AppStyles.extraLargeHeading,
                ),
                SizedBox(height: 5),

                Text(
                  textAlign: TextAlign.center,
                  'Recieve notifications about your clubs, new evets and chats and stay updated with latest activities in your clubs',
                  style: AppStyles.greysubtitle,
                ),
                //
                Spacer(),
                CustomButton(
                  text: 'Allow Notifications',
                  onPressed: () {
                    controller.requestNotificationPermission();
                  },
                ),
                SizedBox(height: 15),

                // create account button
                CustomButton(
                  text: 'Not now',
                  onPressed: () {
                    Get.to(() => HomeScreen());
                  },
                  color: Colors.black.withValues(alpha: 0.3),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
