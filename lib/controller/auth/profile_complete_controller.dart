import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/models/auth/profile_model.dart';
import 'package:hobby_club_app/repo/profile/profile_repo.dart';
import 'package:hobby_club_app/utils/app_strings.dart';
import 'package:hobby_club_app/view/screens/auth/login_screen.dart';
import 'package:hobby_club_app/view/widgets/custom_snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileCompleteController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ProfileRepo profileRepo = ProfileRepo();

  // Text controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  // Focus nodes
  final FocusNode firstNameFocus = FocusNode();
  final FocusNode lastNameFocus = FocusNode();
  final FocusNode usernameFocus = FocusNode();
  final FocusNode dobFocus = FocusNode();

  // State variables
  String? selectedGender;
  String? profileImagePath;
  bool isLoading = false;
  bool isImageLoading = false;

  Future<void> pickImage() async {
    try {
      final status = await Permission.storage.request();

      if (status.isGranted) {
        isImageLoading = true;
        update();

        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);

        if (pickedFile != null) {
          profileImagePath = pickedFile.path;
          debugPrint("Selected image path: $profileImagePath");
        } else {
          debugPrint("No image selected.");
        }
      } else if (status.isDenied) {
        Get.snackbar('Permission Required', 'Storage permission is needed to select profile picture');
      } else if (status.isPermanentlyDenied) {
        openAppSettings();
      }
    } catch (e) {
      debugPrint("Image picker error: ${e.toString()}");
      Get.snackbar('Error', 'Failed to pick image');
    } finally {
      isImageLoading = false;
      update();
    }
  }

  void setProfileImage(String path) {
    profileImagePath = path;
    update();
  }

  void setGender(String? gender) {
    selectedGender = gender;
    update();
  }

  Future<void> getDefaultProfileImage() async {
    try {
      isImageLoading = true;
      update();

      final gender = selectedGender?.toLowerCase() ?? 'other';
      final byteData = await rootBundle.load(
        'assets/images/${gender == "male" ? "male" : gender == "female" ? "female" : "other"}.jpg',
      );

      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/profile_$gender.jpg');
      await file.writeAsBytes(byteData.buffer.asUint8List());

      profileImagePath = file.path;
    } catch (e) {
      debugPrint("Error loading default image: ${e.toString()}");
    } finally {
      isImageLoading = false;
      update();
    }
  }

  Future<void> submitProfile() async {
    if (!formKey.currentState!.validate()) return;

    isLoading = true;
    update();

    try {
      // Use default image if none selected
      if (profileImagePath == null) {
        await getDefaultProfileImage();
        if (profileImagePath == null) {
          throw Exception("Could not set profile picture");
        }
      }

      final profileModel = ProfileModel(
        userName: usernameController.text.trim(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        dob: dobController.text.trim(),
        gender: selectedGender,
      );

      final response = await profileRepo.profileComplete(
        profileModel,
        File(profileImagePath!),
      );

      debugPrint(response.responseJson);

      if (response.isSuccess) {
        Get.offAll(() => LoginScreen());
        showCustomSnackBar(AppStrings.success, response.message);
      } else {
        showCustomSnackBar(AppStrings.error, response.message);
      }
    } catch (e) {
      debugPrint("Profile submission error: ${e.toString()}");
      showCustomSnackBar(AppStrings.error, e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    dobController.dispose();

    firstNameFocus.dispose();
    lastNameFocus.dispose();
    usernameFocus.dispose();
    dobFocus.dispose();

    super.dispose();
  }
}