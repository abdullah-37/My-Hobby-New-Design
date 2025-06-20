import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/models/auth/profile_model.dart';
import 'package:hobby_club_app/models/response_model.dart';
import 'package:hobby_club_app/repo/profile_repo.dart';
import 'package:hobby_club_app/utils/app_strings.dart';
import 'package:hobby_club_app/view/widgets/custom_snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfileCompleteController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ProfileRepo profileRepo = ProfileRepo();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final dobController = TextEditingController();

  final FocusNode firstNameFocus = FocusNode();
  final FocusNode lastNameFocus = FocusNode();
  final FocusNode usernameFocus = FocusNode();
  final dobFocus = FocusNode();

  String? selectedGender;
  File? profileImage;
  bool isLoading = false;

  Future<void> getDefaultProfileImageFile(String gender) async {
    final byteData = await rootBundle.load(
      'assets/images/${gender == "male"
          ? "male"
          : gender == "female"
          ? "female"
          : "other"}.jpg',
    );
    final tempDir = await getTemporaryDirectory();
    profileImage = File('${tempDir.path}/male.jpg');
    await profileImage?.writeAsBytes(byteData.buffer.asUint8List());
    print(profileImage);
    update();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      debugPrint("Picked file path: ${pickedFile.path}");
      profileImage = File(pickedFile.path);
      update();
    } else {
      debugPrint("No image selected.");
    }
  }

  void setGender(String? gender) {
    selectedGender = gender;
    update();
  }

  Future<void> submitProfile() async {
    isLoading = true;
    update();
    final username = usernameController.text.trim();
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final dob = dobController.text.trim();
    final gender = selectedGender;
    final profileImage = this.profileImage;
    if (profileImage == null) {
      getDefaultProfileImageFile(gender!.toLowerCase());
    }

    if (formKey.currentState!.validate()) {
      try {
        ProfileModel profileModel = ProfileModel(
          userName: username,
          firstName: firstName,
          lastName: lastName,
          dob: dob,
          gender: gender,
        );

        ResponseModel response = await profileRepo.profileComplete(
          profileModel,
          profileImage!,
        );
        debugPrint(response.responseJson);
        if (response.isSuccess) {
          // Get.offAll(() => CountryLanguageSelectionScreen());
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
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    dobController.dispose();

    firstNameFocus.dispose();
    lastNameFocus.dispose();
    usernameFocus.dispose();
    dobFocus.dispose();

    profileImage = null;
    selectedGender = null;

    super.dispose();
  }
}
