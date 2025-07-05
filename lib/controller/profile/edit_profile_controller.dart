import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/models/auth/profile_model.dart';
import 'package:hobby_club_app/models/common/response_model.dart';
import 'package:hobby_club_app/models/common/user_model.dart';
import 'package:hobby_club_app/repo/profile/profile_repo.dart';
import 'package:hobby_club_app/utils/app_strings.dart';
import 'package:hobby_club_app/view/widgets/custom_snackbar.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ProfileRepo profileRepo = ProfileRepo();
  final GetStorage storage = GetStorage();
  ProfileModel profile = ProfileModel();
  User user = User();

  bool isLoading = false;

  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dobController = TextEditingController();

  final usernameFocus = FocusNode();
  final firstNameFocus = FocusNode();
  final lastNameFocus = FocusNode();
  final dobFocus = FocusNode();

  String? selectedGender = "Male";
  File? profileImage;

  @override
  void onInit() {
    getProfile();
    getUser();
    assignProfile();
    super.onInit();
  }

  getProfile() {
    isLoading = true;
    update();

    final userData = storage.read("profile");

    if (userData != null) {
      profile = ProfileModel.fromJson(userData);
    }

    isLoading = false;
    update();
  }

  getUser() {
    isLoading = true;
    update();

    final userData = storage.read("user");

    if (userData != null) {
      user = User.fromJson(userData);
    }

    isLoading = false;
    update();
  }

  assignProfile() async {
    getProfile();
    getUser();
    usernameController.text = profile.userName ?? "";
    firstNameController.text = profile.firstName ?? "";
    lastNameController.text = profile.lastName ?? "";
    dobController.text = profile.dob ?? "";
    update();
  }

  /// Pick image from gallery
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      profileImage = File(picked.path);
      update();
    }
  }

  void setGender(String? gender) {
    selectedGender = gender;
    update();
  }

  Future<void> saveProfile() async {
    final username = usernameController.text.trim();
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final dob = dobController.text.trim();
    final gender = selectedGender;
    final profileImage = this.profileImage;

    if (formKey.currentState!.validate()) {
      isLoading = true;
      update();

      final currentProfile = profile;

      bool shouldUpdate = true;

      shouldUpdate =
          !(currentProfile.userName == username &&
              currentProfile.firstName == firstName &&
              currentProfile.lastName == lastName &&
              currentProfile.dob == dob &&
              currentProfile.gender == gender);

      if (!shouldUpdate) {
        isLoading = false;
        update();
        showCustomSnackBar(
          "No Changes",
          "No profile data has been modified.",
        );
        return;
      }

      try {
        ProfileModel profileModel = ProfileModel(
          userName: username,
          firstName: firstName,
          lastName: lastName,
          dob: dob,
          gender: gender,
        );

        ResponseModel response;
        if (profileImage != null) {
          response = await profileRepo.profileComplete(
            profileModel,
            profileImage,
          );
        } else {
          response = await profileRepo.profileUpdateWithoutImage(profileModel);
        }

        debugPrint(response.responseJson);
        if (response.isSuccess) {
          Get.back();
          showCustomSnackBar(AppStrings.success, response.message);
        } else {
          showCustomSnackBar(AppStrings.error, response.message);
        }
      } catch (e) {
        showCustomSnackBar(AppStrings.error, e.toString());
      } finally {
        isLoading = false;
        update();
      }
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    dobController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    lastNameFocus.dispose();
    usernameFocus.dispose();
    dobFocus.dispose();
    firstNameFocus.dispose();
    super.onClose();
  }
}
