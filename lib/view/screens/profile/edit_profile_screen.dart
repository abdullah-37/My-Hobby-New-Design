import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/profile/edit_profile_controller.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/app_strings.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/utils/theme/theme_helper.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';
import 'package:hobby_club_app/view/widgets/custom_button.dart';
import 'package:hobby_club_app/view/widgets/custom_network_image.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    Get.put(EditProfileController());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.editProfile),
        body: GetBuilder<EditProfileController>(
          builder: (controller) {
            return SingleChildScrollView(
              padding: Dimensions.screenPaddingHV,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                        onTap: controller.pickImage,
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: AppColors.primary.withValues(
                            alpha: 0.3,
                          ),
                          backgroundImage:
                              controller.profileImage != null
                                  ? FileImage(controller.profileImage!)
                                  : null,
                          child:
                              controller.profileImage == null
                                  ? CustomNetworkImage(
                                    size: Dimensions.width80,
                                    imageUrl: controller.profile.img ?? "",
                                  )
                                  : null,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 4,
                        child: GestureDetector(
                          onTap: controller.pickImage,
                          child: Container(
                            width: Dimensions.width30,
                            height: Dimensions.width30,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.edit,
                              color: AppColors.white,
                              size: Dimensions.width15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.height20),

                  Row(
                    spacing: Dimensions.width10,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              hintText: 'Enter your first name',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Second Name',
                              hintText: 'Enter your second name',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.height15),

                  Container(
                    decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        hintText: 'Enter your pnone number',
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.height15),

                  Container(
                    decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.height15),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(AppStrings.selectGender),
                  ),
                  SizedBox(height: Dimensions.height10),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.white,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width20,
                        vertical: Dimensions.height15,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          Dimensions.radius10,
                        ),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    hint: Text(AppStrings.selectGender),
                    value: controller.selectedGender,
                    items:
                        [AppStrings.male, AppStrings.female, AppStrings.other]
                            .map(
                              (gender) => DropdownMenuItem(
                                value: gender,
                                child: Text(gender),
                              ),
                            )
                            .toList(),
                    onChanged: controller.setGender,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.pleaseSelectGender;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: Dimensions.height60),

                  controller.isLoading
                      ? CustomLoadingButton()
                      : CustomButton(
                        text: AppStrings.save,
                        onPressed: controller.saveProfile,
                      ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
