import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/auth/profile_complete_controller.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/app_strings.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/utils/style.dart';
import 'package:hobby_club_app/view/widgets/custom_button.dart';
import 'package:hobby_club_app/view/widgets/custom_text_form_field.dart';

class ProfileCompleteScreen extends StatefulWidget {
  const ProfileCompleteScreen({super.key});

  @override
  State<ProfileCompleteScreen> createState() => _ProfileCompleteScreenState();
}

class _ProfileCompleteScreenState extends State<ProfileCompleteScreen> {
  TextEditingValue formatEditUpdate(TextEditingValue value) {
    var text = value.text.replaceAll(RegExp(r'[^0-9]'), '');

    final buffer = StringBuffer();
    for (int i = 0; i < text.length && i < 8; i++) {
      buffer.write(text[i]);
      if ((i == 3 || i == 5) && i != text.length - 1) {
        buffer.write('/');
      }
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  @override
  void initState() {
    Get.put(ProfileCompleteController());

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: GetBuilder<ProfileCompleteController>(
            builder:
                (controller) => SingleChildScrollView(
                  padding: Dimensions.screenPaddingHorizontal,
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        SizedBox(height: Dimensions.height30),

                        // Profile Picture
                        Column(
                          children: [
                            GestureDetector(
                              onTap: controller.pickImage,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: AppColors.white.withValues(
                                  alpha: 0.3,
                                ),
                                backgroundImage:
                                    controller.profileImage != null
                                        ? FileImage(controller.profileImage!)
                                        : null,
                                child:
                                    controller.profileImage == null
                                        ? Icon(
                                          Icons.camera_alt_outlined,
                                          size: Dimensions.icon40,
                                          color: AppColors.primary,
                                        )
                                        : null,
                              ),
                            ),
                            SizedBox(height: Dimensions.height5),
                            Text(
                              AppStrings.uploadProfilePicture,
                              style: AppStyles.greysubtitle,
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.height30),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                labelText: AppStrings.firstName,
                                hintText: "John",
                                controller: controller.firstNameController,
                                focusNode: controller.firstNameFocus,
                                nextFocus: controller.lastNameFocus,
                                isRequired: false,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return AppStrings.firstName;
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: Dimensions.width10),
                            Expanded(
                              child: CustomTextFormField(
                                labelText: AppStrings.lastName,
                                hintText: "Doe",
                                controller: controller.lastNameController,
                                focusNode: controller.lastNameFocus,
                                nextFocus: controller.usernameFocus,
                                isRequired: false,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return AppStrings.lastName;
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: Dimensions.height20),

                        // Username
                        CustomTextFormField(
                          labelText: AppStrings.userName,
                          hintText: "johndoe",
                          controller: controller.usernameController,
                          focusNode: controller.usernameFocus,
                          nextFocus: controller.dobFocus,
                          keyboardType: TextInputType.name,
                          isRequired: false,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return AppStrings.pleaseEnterUsername;
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: Dimensions.height20),
                        // Date of Birth
                        CustomTextFormField(
                          labelText: AppStrings.dob,
                          hintText: "YYYY/MM/DD",
                          inputFormatters: [DateInputFormatter()],
                          keyboardType: TextInputType.datetime,
                          controller: controller.dobController,
                          focusNode: controller.dobFocus,
                        ),

                        SizedBox(height: Dimensions.height20),

                        // Gender
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  AppStrings.selectGender,
                                  style: AppStyles.body.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                // Text(
                                //   " *",
                                //   style: AppStyles.body.copyWith(
                                //     color: Colors.red,
                                //   ),
                                // ),
                              ],
                            ),
                            SizedBox(height: 5),
                            DropdownButtonFormField<String>(
                              dropdownColor: const Color.fromARGB(
                                255,
                                65,
                                65,
                                65,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.white.withValues(
                                  alpha: 0.1,
                                ),

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
                              hint: Text(
                                AppStrings.selectGender,
                                style: AppStyles.body,
                              ),
                              value: controller.selectedGender,
                              style: AppStyles.body,
                              items:
                                  [
                                        AppStrings.male,
                                        AppStrings.female,
                                        AppStrings.other,
                                      ]
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
                          ],
                        ),

                        SizedBox(height: Dimensions.height30),

                        CustomButton(
                          isLoading: controller.isLoading,
                          text: AppStrings.save,
                          onPressed: controller.submitProfile,
                        ),

                        SizedBox(height: Dimensions.height20),
                      ],
                    ),
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
