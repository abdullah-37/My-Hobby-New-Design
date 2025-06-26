import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/controller/raw/hide_floating_button_controller.dart';
import 'package:hobby_club_app/controller/raw/notifications_controller.dart';
import 'package:hobby_club_app/controller/profile/profile_controller.dart';
import 'package:hobby_club_app/controller/raw/theme_controller.dart';
import 'package:hobby_club_app/models/raw/user_model.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/app_strings.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/utils/style.dart';
import 'package:hobby_club_app/view/screens/auth/login_screen.dart';
import 'package:hobby_club_app/view/widgets/custom_button.dart';
import 'package:hobby_club_app/view/widgets/custom_club_card.dart';
import 'package:hobby_club_app/view/widgets/custom_network_image.dart';
import 'package:hobby_club_app/view/widgets/header_widget.dart';

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
  String currentScreen = '1';
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

  String currentView = 'Monthly'; // Changed from currentScreen to currentView

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.find<ThemeController>();
    final floatingController = Get.find<FloatingButtonController>();

    NotificationsController notificationsController =
        Get.find<NotificationsController>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
          ),
        ),
      ),

      body: GetBuilder<ProfileController>(
        builder: (controller) {
          final isDark = themeController.themeMode.value == ThemeMode.dark;

          return Stack(
            children: [
              SizedBox(
                height: 100,
                child: HeaderWidget(100, false, Icons.person),
              ),
              Padding(
                padding: Dimensions.screenPaddingHorizontal,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        // padding: Dimensions.screenPaddingHV,
                        // decoration: BoxDecoration(color: AppColors.background),
                        child: Column(
                          children: [
                            CustomNetworkImage(
                              size: Dimensions.width100,
                              imageUrl:
                                  controller.profile.img ??
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuADwPMLnjDQoHaeflMfxpDvSV1hUYxmTcoELxjPF34XVVN6-I9GjPc-kk60zdyfrTWmmr0VqCv85bEzPmEH6uRdnEJzsEff9wknyuv1jbuCRa_rDTgAsoGw-xGHzl_sktSiN97lMvbisMky4u8btqG2bqta5YZrS7gpJexqRXNSSkjxFSvruF_I85dAPh3QnHzZ5O2pOM774DFzRlwU7CgJM6gBn2w6sbAO8kF8A8lwot-cpnKdsLQUpu4PUujOyxesvZSRkhqGkgsu',
                            ),
                            SizedBox(height: Dimensions.height20),

                            Text(
                              'Muhammad Abdullah',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),

                            SizedBox(height: Dimensions.height20),
                            SingleChildScrollView(
                              child: Column(
                                spacing: Dimensions.height10,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Profile Details',
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.titleMedium,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        spacing: Dimensions.height10,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                style:
                                                    Theme.of(
                                                      context,
                                                    ).textTheme.labelLarge,
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
                                                style:
                                                    Theme.of(
                                                      context,
                                                    ).textTheme.labelLarge,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        spacing: Dimensions.height10,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                style:
                                                    Theme.of(
                                                      context,
                                                    ).textTheme.labelLarge,
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
                                                style:
                                                    Theme.of(
                                                      context,
                                                    ).textTheme.labelLarge,
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
                          ],
                        ),
                      ),
                      // SizedBox(height: Dimensions.height10),
                      // //edit profile button
                      // Container(
                      //   decoration: ThemeHelper().buttonBoxDecoration(context),
                      //   child: ElevatedButton(
                      //     style: ThemeHelper().buttonStyle(),
                      //     child: Padding(
                      //       padding: EdgeInsets.only(),
                      //       child: Text(
                      //         'Edit Profile'.toUpperCase(),
                      //         style: TextStyle(
                      //           fontSize: 20,
                      //           fontWeight: FontWeight.bold,
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //     ),
                      //     onPressed: () {
                      //       Get.to(() => EditProfileScreen());
                      //       // //After successful login we will redirect to profile page. Let's create profile page now
                      //       // Navigator.pushReplacement(
                      //       //   context,
                      //       //   MaterialPageRoute(
                      //       //     builder: (context) => ProfilePage(),
                      //       //   ),
                      //       // );
                      //     },
                      //   ),
                      // ),
                      SizedBox(height: Dimensions.height20),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          'My Clubs',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      SizedBox(height: Dimensions.height10),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 10,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: Get.height * 0.055,
                            decoration: BoxDecoration(
                              color:
                                  isDark
                                      ? Colors.grey.withValues(alpha: 0.3)
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      isDark
                                          ? Colors.transparent
                                          : Colors.grey.withValues(alpha: 0.3),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0,
                                    vertical: 4,
                                  ),
                                  child: AnimatedAlign(
                                    duration: const Duration(milliseconds: 300),
                                    alignment:
                                        currentView == '1'
                                            ? Alignment.centerLeft
                                            : Alignment.centerRight,
                                    child: Container(
                                      width: Get.width * 0.4,
                                      // height: 100,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            currentView = '1';
                                          });
                                        },
                                        child: Center(
                                          child: buildStatusItem(
                                            title: 'Accepted',
                                            bgColor: Colors.transparent,
                                            textColor:
                                                currentView == '1'
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
                                            currentView = '0';
                                          });
                                        },
                                        child: Center(
                                          child: buildStatusItem(
                                            title: 'Pending',
                                            bgColor: Colors.transparent,
                                            textColor:
                                                currentView == '0'
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
                        ),
                      ),
                      currentScreen == '1'
                          ? acceptedClubs(controller: controller)
                          : pendingClubs(controller: controller),
                      SizedBox(height: Dimensions.height5),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          'Settings',
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium!.copyWith(fontSize: 28),
                        ),
                      ),
                      SizedBox(height: Dimensions.height10),
                      Column(
                        spacing: 20,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Language',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Spacer(),
                              Text('English', style: AppStyles.greysubtitle),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Region',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Spacer(),
                              Text('Pakistan', style: AppStyles.greysubtitle),
                            ],
                          ),
                          Obx(
                            () => Row(
                              children: [
                                Text(
                                  'Notifications',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const Spacer(),
                                CupertinoSwitch(
                                  value:
                                      notificationsController
                                          .isSubscribed
                                          .value,
                                  onChanged: (bool newValue) {
                                    notificationsController.toggleNotifications(
                                      newValue,
                                    );
                                  },
                                  activeTrackColor:
                                      Theme.of(context).primaryColor,
                                ),
                              ],
                            ),
                          ),
                          // disable floating button
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
                                  activeTrackColor:
                                      Theme.of(context).primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      CustomElevatedButton(
                        title: AppStrings.logout,
                        onTap: () {
                          Get.dialog(
                            AlertDialog(
                              title: const Text("Confirm Logout"),
                              content: const Text(
                                "Are you sure you want to log out?",
                              ),
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
                    ],
                  ),
                ),
              ),
            ],
          );
        },
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
                          return CustomClubCard(
                            eventsCount: 3,
                            membersCount: data.membersCount.toString(),
                            imageUrl: data.img,
                            title: data.title,
                            subtitle:
                                "${data.membersCount}. ${AppStrings.members}",
                            status: data.status,
                            desc: data.desc,
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
