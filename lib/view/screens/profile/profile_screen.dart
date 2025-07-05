import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/controller/profile/profile_controller.dart';
import 'package:hobby_club_app/controller/theme/theme_controller.dart';
import 'package:hobby_club_app/models/auth/profile_model.dart';
import 'package:hobby_club_app/models/common/user_model.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/app_strings.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/view/Settings/settings_screen.dart';
import 'package:hobby_club_app/view/widgets/custom_network_image.dart';
import 'package:hobby_club_app/view/widgets/header_widget.dart';
import 'package:hobby_club_app/view/widgets/image_view.dart';

import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GetStorage storage = GetStorage();
  User? user;
  ProfileModel? profile;
  bool isLoading = true;
  String currentScreen = 'Accepted';

  @override
  void initState() {
    Get.put(ProfileController());
    loadUser();
    loadProfile();
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
      debugPrint('Error loading user: $e');
    }
  }

  Future<void> loadProfile() async {
    try {
      final profileData = storage.read('profile');
      if (profileData != null) {
        setState(() {
          profile = ProfileModel.fromJson(profileData);
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
    ThemeController themeController = Get.find<ThemeController>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(const SettingsScreen());
            },
            icon: const Icon(Icons.settings),
          ),
        ],
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
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => ImageView(image: controller.profile.img!,title: 'Profile Image',));
                            },
                            child: CustomNetworkImage(
                              size: Dimensions.width100,
                              imageUrl:
                                  controller.profile.img ??
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuADwPMLnjDQoHaeflMfxpDvSV1hUYxmTcoELxjPF34XVVN6-I9GjPc-kk60zdyfrTWmmr0VqCv85bEzPmEH6uRdnEJzsEff9wknyuv1jbuCRa_rDTgAsoGw-xGHzl_sktSiN97lMvbisMky4u8btqG2bqta5YZrS7gpJexqRXNSSkjxFSvruF_I85dAPh3QnHzZ5O2pOM774DFzRlwU7CgJM6gBn2w6sbAO8kF8A8lwot-cpnKdsLQUpu4PUujOyxesvZSRkhqGkgsu',
                            ),
                          ),
                          SizedBox(height: Dimensions.height20),

                          Text(
                            '${profile!.firstName} ${profile!.lastName}',
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
                                        currentScreen == 'Accepted'
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
                                            currentScreen = 'Accepted';
                                          });
                                        },
                                        child: Center(
                                          child: buildStatusItem(
                                            title: 'Accepted',
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
                                            title: 'Pending',
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
                        ),
                      ),
                      currentScreen == 'Accepted'
                          ? acceptedClubs(controller: controller)
                          : pendingClubs(controller: controller),
                      SizedBox(height: Dimensions.height10),
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
        ? Column(
          children: [
            controller.acceptedClubs.isNotEmpty
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          'Visit All',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
                          controller.acceptedClubs.length > 2
                              ? 2
                              : controller.acceptedClubs.length,
                      itemBuilder: (context, index) {
                        var data = controller.acceptedClubs[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: _buildJoinedClubCard(
                            title: data.title,
                            image: data.img,
                            category: data.category,
                            description: data.desc,
                            events: data.totalSchedules,
                            members: data.totalMembers,
                            onTap: () {},
                          ),
                        );
                      },
                    ),
                  ],
                )
                : Container(),
          ],
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
        ? Column(
          children: [
            controller.pendingClubs.isNotEmpty
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        'Visit All',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
                          controller.pendingClubs.length > 2
                              ? 2
                              : controller.pendingClubs.length,
                      itemBuilder: (context, index) {
                        var data = controller.pendingClubs[index];
                        return _buildJoinedClubCard(
                          title: data.title,
                          image: data.img,
                          category: data.category,
                          description: data.desc,
                          events: data.totalSchedules,
                          members: data.totalMembers,
                          onTap: () {},
                        );
                      },
                    ),
                    if (controller.pendingClubs.length > 2)
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Show More (${controller.pendingClubs.length - 2})',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                  ],
                )
                : Container(),
          ],
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

  Widget _buildJoinedClubCard({
    required String image,
    required String category,
    required String title,
    required String description,
    required int members,
    required int events,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: const TextStyle(
                      color: Color(0xFF5C748A),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(title, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Color(0xFF5C748A),
                      fontSize: 14,
                    ),
                    maxLines: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Members: $members',
                        style: const TextStyle(
                          color: Color(0xFF5C748A),
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Events: $events',
                        style: const TextStyle(
                          color: Color(0xFF5C748A),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: AspectRatio(
                aspectRatio: 10 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildErrorImage();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorImage({double size = double.infinity}) {
    return Container(
      color: Colors.grey[800],
      width: size,
      height: size,
      child: const Icon(Icons.broken_image, color: Colors.white),
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
