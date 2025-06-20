import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/club/create_club_controller.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/app_strings.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/utils/style.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';
import 'package:hobby_club_app/view/widgets/custom_button.dart';
import 'package:hobby_club_app/view/widgets/custom_text_form_field.dart';

class CreateClubScreen extends StatefulWidget {
  const CreateClubScreen({super.key});

  @override
  State<CreateClubScreen> createState() => _CreateClubScreenState();
}

class _CreateClubScreenState extends State<CreateClubScreen> {
  @override
  void initState() {
    Get.put(CreateClubController());

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.createClub),
      bottomNavigationBar: Padding(
        padding: Dimensions.screenPaddingHV,
        child: GetBuilder<CreateClubController>(
          builder:
              (controller) => CustomElevatedButton(
                title: AppStrings.createClub,
                onTap: controller.createClub,
              ),
        ),
      ),
      body: GetBuilder<CreateClubController>(
        builder:
            (controller) => SingleChildScrollView(
              padding: Dimensions.screenPaddingHV,
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: controller.pickImage,
                          child: CircleAvatar(
                            radius: Dimensions.radius50,
                            backgroundColor: AppColors.primary.withValues(
                              alpha: 0.2,
                            ),
                            backgroundImage:
                                controller.imageFile != null
                                    ? FileImage(controller.imageFile!)
                                    : null,
                            child:
                                controller.imageFile == null
                                    ? Icon(
                                      CupertinoIcons.camera_fill,
                                      size: Dimensions.icon36,
                                      color: AppColors.primary,
                                    )
                                    : null,
                          ),
                        ),
                        SizedBox(width: Dimensions.width10),
                        GestureDetector(
                          onTap: () {
                            final List imagesAvatar = [
                              "assets/images/football.png",
                              "assets/images/reading-book.png",
                              "assets/images/art.png",
                              "assets/images/drive.png",
                              "assets/images/cooking.png",
                              "assets/images/photography.png",
                              "assets/images/music.png",
                              "assets/images/travel.png",
                              "assets/images/atom.png",
                            ];
                            Get.defaultDialog(
                              backgroundColor: Colors.white,
                              title: AppStrings.select,
                              titleStyle: AppStyles.largeHeading,
                              content: Container(
                                height: Get.height / 2.8,
                                padding: EdgeInsets.all(Dimensions.padding20),
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: Dimensions.width30,
                                        crossAxisSpacing: Dimensions.width30,
                                        childAspectRatio: 1,
                                      ),
                                  itemCount: imagesAvatar.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        controller.selectAvatar(
                                          imagesAvatar[index],
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                          imagesAvatar[index],
                                          color: AppColors.primary,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: Dimensions.radius50,
                            backgroundColor: AppColors.primary.withValues(
                              alpha: 0.2,
                            ),
                            backgroundImage:
                                controller.selectedAvatar == null
                                    ? AssetImage(
                                      "assets/images/avatar_club_create.png",
                                    )
                                    : null,
                            child:
                                controller.selectedAvatar != null
                                    ? Container(
                                      padding: EdgeInsets.all(
                                        Dimensions.padding10,
                                      ),
                                      child:
                                          controller.uploadAvatarLoading
                                              ? Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                              : Image.file(
                                                controller.selectedAvatar!,
                                              ),
                                    )
                                    : null,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.height20),

                    CustomTextFormField(
                      labelText: AppStrings.clubName,
                      hintText: AppStrings.enterClubName,
                      controller: controller.clubNameController,
                      focusNode: controller.clubNameFocus,
                      nextFocus: controller.clubCategoryFocus,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.enterClubName;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: Dimensions.height15),

                    CustomTextFormField(
                      labelText: AppStrings.clubCategory,
                      hintText: AppStrings.enterClubCategory,
                      controller: controller.clubCategoryController,
                      focusNode: controller.clubCategoryFocus,
                      nextFocus: controller.descriptionFocus,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.enterClubCategory;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: Dimensions.height15),

                    CustomTextFormField(
                      labelText: AppStrings.description,
                      hintText: AppStrings.writeAboutYourClub,
                      controller: controller.descriptionController,
                      focusNode: controller.descriptionFocus,
                      maxLines: 4,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.writeAboutYourClub;
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
