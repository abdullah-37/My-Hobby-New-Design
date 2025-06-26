import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/auth/profile_complete_controller.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/app_strings.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/utils/style.dart';
import 'package:hobby_club_app/utils/theme/theme_helper.dart';
import 'package:hobby_club_app/view/widgets/custom_button.dart';
import 'package:hobby_club_app/view/widgets/header_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileCompleteScreen extends StatefulWidget {
  const ProfileCompleteScreen({super.key});

  @override
  State<ProfileCompleteScreen> createState() => _ProfileCompleteScreenState();
}

class _ProfileCompleteScreenState extends State<ProfileCompleteScreen> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    Get.put(ProfileCompleteController());
    super.initState();
  }

  Future<void> _pickImage() async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      try {
        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          Get.find<ProfileCompleteController>().setProfileImage(image.path);
          setState(() {});
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to pick image: ${e.toString()}');
      }
    } else if (status.isDenied) {
      Get.snackbar('Permission Required', 'Storage permission is needed to select profile picture');
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: GetBuilder<ProfileCompleteController>(
          builder: (controller) => Stack(
            children: [
              SizedBox(
                height: 150,
                child: HeaderWidget(
                  150,
                  false,
                  Icons.person_add_alt_1_rounded,
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  width: 1,
                                  color: Theme.of(context).primaryColor,
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 20,
                                    offset: const Offset(5, 5),
                                  ),
                                ],
                              ),
                              child: controller.profileImagePath != null
                                  ? CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(
                                  File(controller.profileImagePath!),
                                ),
                              )
                                  : Icon(
                                Icons.person,
                                color: Colors.grey.shade300,
                                size: 110,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Form(
                        key: controller.formKey,
                        child: Padding(
                          padding: EdgeInsetsGeometry.all(20),
                          child: Column(
                            children: [
                              Text(
                                AppStrings.uploadProfilePicture,
                                style: AppStyles.greysubtitle,
                              ),
                              SizedBox(height: Dimensions.height30),
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: Dimensions.height20),
                                    decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Field is empty';
                                        }
                                        return null;
                                      },
                                      controller: controller.firstNameController,
                                      keyboardType: TextInputType.name,
                                      focusNode: controller.firstNameFocus,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        labelText: 'First Name',
                                        hintText: 'Enter your first name',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: Dimensions.height20),
                                    decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Field is empty';
                                        }
                                        return null;
                                      },
                                      controller: controller.lastNameController,
                                      keyboardType: TextInputType.name,
                                      focusNode: controller.lastNameFocus,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.person_outline,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        labelText: 'Last Name',
                                        hintText: 'Enter your last name',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: Dimensions.height20),
                                    decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Field is empty';
                                        }
                                        return null;
                                      },
                                      controller: controller.usernameController,
                                      keyboardType: TextInputType.name,
                                      focusNode: controller.usernameFocus,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.alternate_email,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        labelText: 'Username',
                                        hintText: 'Enter your username',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: Dimensions.height20),
                                    decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Field is empty';
                                        }
                                        return null;
                                      },
                                      controller: controller.dobController,
                                      keyboardType: TextInputType.datetime,
                                      focusNode: controller.dobFocus,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.calendar_today,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        labelText: 'Date of Birth',
                                        hintText: 'DD/MM/YYYY',
                                      ),
                                      onTap: () async {
                                        FocusScope.of(context).requestFocus(FocusNode());
                                        final date = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime.now(),
                                        );
                                        if (date != null) {
                                          final formattedDate =
                                              "${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}";
                                          controller.dobController.text = formattedDate;
                                          debugPrint('date :: $formattedDate'); // moved here
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: Dimensions.height20),
                                    decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                    child: DropdownButtonFormField<String>(
                                      dropdownColor: AppColors.white,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.transgender,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: Dimensions.width15,
                                        ),
                                      ),
                                      hint: Text(
                                        AppStrings.selectGender,
                                        style: AppStyles.body,
                                      ),
                                      value: controller.selectedGender,
                                      style: AppStyles.body,
                                      items: [
                                        AppStrings.male,
                                        AppStrings.female,
                                        AppStrings.other,
                                      ].map((gender) => DropdownMenuItem(
                                        value: gender,
                                        child: Text(gender),
                                      )).toList(),
                                      onChanged: controller.setGender,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return AppStrings.pleaseSelectGender;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Dimensions.height30),
                              CustomElevatedButton(
                                title: AppStrings.save,
                                onTap: controller.submitProfile,
                              ),
                              SizedBox(height: Dimensions.height20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (controller.isLoading)
                Container(
                  color: Colors.black.withValues(alpha: 0.5),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}