import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/controller/notifications_controller.dart';
import 'package:hobby_club_app/controller/profile/profile_controller.dart';
import 'package:hobby_club_app/models/user_model.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/app_strings.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/utils/style.dart';
import 'package:hobby_club_app/view/screens/auth/login_screen.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';
import 'package:hobby_club_app/view/widgets/custom_button.dart';
import 'package:hobby_club_app/view/widgets/custom_club_card.dart';
import 'package:hobby_club_app/view/widgets/custom_network_image.dart';

import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GetStorage storage = GetStorage();
  User? user;
  bool isLoading = true;
  String currentScreen = 'Accepted';
  final bool _notificationsEnabled = true;

  @override
  void initState() {
    Get.put(ProfileController());
    loadUser();
    super.initState();
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
      debugPrint('Error loading profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    NotificationsController notificationsController =
        Get.find<NotificationsController>();
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.profile, isLeading: false),
      bottomNavigationBar: Container(
        padding: Dimensions.screenPaddingHV,
        child: CustomButton(
          text: AppStrings.logout,
          color: Colors.redAccent,
          onPressed: () {
            Get.dialog(
              AlertDialog(
                title: const Text("Confirm Logout"),
                content: const Text("Are you sure you want to log out?"),
                actions: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () async {
                      Get.back();
                      await storage.remove("user");
                      await storage.remove("profile");
                      await storage.remove("token");
                      Get.offAll(LoginScreen());
                    },
                    child: const Text(
                      AppStrings.logout,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            );
            // Get.to(EditProfileScreen());
          },
        ),
      ),
      body: GetBuilder<ProfileController>(
        builder:
            (controller) => SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: Dimensions.screenPaddingHV,
                    decoration: BoxDecoration(color: AppColors.background),
                    child: Column(
                      children: [
                        CustomNetworkImage(
                          size: Dimensions.width100,
                          imageUrl: controller.profile.img ?? '',
                        ),
                        Text(
                          '${controller.profile.firstName ?? ''} ${controller.profile.lastName ?? ''}',
                          style: AppStyles.largeHeading.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (controller.profile.userName != null)
                          Text(
                            '@${controller.profile.userName}',
                            style: AppStyles.body.copyWith(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        SizedBox(height: Dimensions.height10),
                        Column(
                          spacing: Dimensions.height10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Profile Details',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(const EditProfileScreen());
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: AppColors.primary,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              spacing: 20,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  spacing: Dimensions.height10,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      spacing: 10,
                                      children: [
                                        Icon(
                                          Icons.email,
                                          color: AppColors.primary,
                                          size: 22,
                                        ),
                                        Text(
                                          user?.email ?? 'Not provided',
                                          style: AppStyles.body.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      spacing: 10,
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          color: AppColors.primary,
                                          size: 22,
                                        ),
                                        Text(
                                          user?.phone ?? 'Not provided',
                                          style: AppStyles.body.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  spacing: Dimensions.height10,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      spacing: 10,
                                      children: [
                                        Icon(
                                          Icons.cake,
                                          color: AppColors.primary,
                                          size: 22,
                                        ),
                                        Text(
                                          controller.profile.dob ??
                                              'Not provided',
                                          style: AppStyles.body.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      spacing: 10,
                                      children: [
                                        Icon(
                                          Icons.transgender,
                                          color: AppColors.primary,
                                          size: 22,
                                        ),
                                        Text(
                                          controller.profile.gender ??
                                              'Not provided',
                                          style: AppStyles.body.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.height5),
                  Padding(
                    padding: Dimensions.screenPaddingH,
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        'My Clubs',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.height5),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    onHorizontalDragEnd: (details) {
                      if (details.primaryVelocity! < 0) {
                        setState(() {
                          currentScreen = 'Accepted';
                        });
                      } else if (details.primaryVelocity! > 0) {
                        setState(() {
                          currentScreen = 'Pending';
                        });
                      }
                    },
                    child: Stack(
                      children: [
                        AnimatedAlign(
                          duration: const Duration(milliseconds: 300),
                          alignment:
                              currentScreen == 'Accepted'
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                          child: Container(
                            width: Get.width * 0.50,
                            height: Get.height * 0.045,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentScreen = 'Accepted';
                                  });
                                },
                                child: Center(
                                  child: buildStatusItem(
                                    title: 'Accepted'.tr,
                                    bgColor: Colors.transparent,
                                    textColor:
                                        currentScreen == 'Accepted'
                                            ? Colors.white
                                            : AppColors.secondary,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentScreen = 'Pending';
                                  });
                                },
                                child: Center(
                                  child: buildStatusItem(
                                    title: 'Pending'.tr,
                                    bgColor: Colors.transparent,
                                    textColor:
                                        currentScreen == 'Pending'
                                            ? Colors.white
                                            : AppColors.secondary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  currentScreen == 'Accepted'
                      ? acceptedClubs(controller: controller)
                      : pendingClubs(controller: controller),
                  SizedBox(height: Dimensions.height5),
                  Padding(
                    padding: Dimensions.screenPaddingH,
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        'Setting',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.height5),
                  Padding(
                    padding: Dimensions.screenPaddingH,
                    child: Column(
                      spacing: 20,
                      children: [
                        Row(
                          children: [
                            Text('Language', style: AppStyles.body),
                            Spacer(),
                            Text('English', style: AppStyles.greysubtitle),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Region', style: AppStyles.body),
                            Spacer(),
                            Text('Pakistan', style: AppStyles.greysubtitle),
                          ],
                        ),
                        Obx(
                          () => Row(
                            children: [
                              Text('Notifications', style: AppStyles.body),
                              const Spacer(),
                              CupertinoSwitch(
                                value:
                                    notificationsController.isSubscribed.value,
                                onChanged: (bool newValue) {
                                  notificationsController.toggleNotifications(
                                    newValue,
                                  );
                                },
                                activeTrackColor: AppColors.primary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }

  Widget acceptedClubs({required ProfileController controller}) {
    return controller.isLoading
        ? Center(child: CircularProgressIndicator())
        : controller.allClubs.isNotEmpty
        ? Padding(
          padding: Dimensions.screenPaddingHV,
          child: Column(
            children: [
              controller.acceptedClubs.isNotEmpty
                  ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppStrings.myClubs, style: AppStyles.largeHeading),
                      SizedBox(height: Dimensions.height10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.acceptedClubs.length,
                        itemBuilder: (context, index) {
                          var data = controller.acceptedClubs[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: Dimensions.padding15,
                            ),
                            child: CustomClubCard(
                              eventsCount: 3,
                              membersCount: data.membersCount.toString(),
                              imageUrl: data.img,
                              title: data.title,
                              subtitle:
                                  "${data.membersCount}. ${AppStrings.members}",
                              status: data.status,
                              desc: data.desc,
                            ),
                          );
                        },
                      ),
                    ],
                  )
                  : Container(),
            ],
          ),
        )
        : Padding(
          padding: Dimensions.screenPaddingHV,
          child: Center(
            child: Text(
              AppStrings.emptyClubMessage,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
  }

  Widget pendingClubs({required ProfileController controller}) {
    return controller.isLoading
        ? Center(child: CircularProgressIndicator())
        : controller.allClubs.isNotEmpty
        ? Padding(
          padding: Dimensions.screenPaddingHV,
          child: Column(
            children: [
              controller.pendingClubs.isNotEmpty
                  ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.pendingClubs,
                        style: AppStyles.largeHeading,
                      ),
                      SizedBox(height: Dimensions.height10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.pendingClubs.length,
                        itemBuilder: (context, index) {
                          var data = controller.pendingClubs[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: Dimensions.padding15,
                            ),
                            child: CustomClubCard(
                              eventsCount: 3,
                              membersCount: data.membersCount.toString(),
                              imageUrl: data.img,
                              title: data.title,
                              subtitle:
                                  "${data.membersCount}. ${AppStrings.members}",
                              status: data.status,
                              desc: data.desc,
                            ),
                          );
                        },
                      ),
                    ],
                  )
                  : Container(),
            ],
          ),
        )
        : Padding(
          padding: Dimensions.screenPaddingHV,
          child: Center(
            child: Text(
              AppStrings.emptyClubMessage,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
  }

  Widget buildStatusItem({
    required String title,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
