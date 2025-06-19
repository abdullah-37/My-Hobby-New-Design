import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/models/create_club_model.dart';
import 'package:hobby_club_app/models/response_model.dart';
import 'package:hobby_club_app/repo/club/create_club_repo.dart';
import 'package:hobby_club_app/utils/app_strings.dart';
import 'package:hobby_club_app/view/widgets/custom_snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CreateClubController extends GetxController {
  CreateClubRepo repo = CreateClubRepo();

  final formKey = GlobalKey<FormState>();

  final clubNameController = TextEditingController();
  final clubCategoryController = TextEditingController();
  final descriptionController = TextEditingController();

  final clubNameFocus = FocusNode();
  final clubCategoryFocus = FocusNode();
  final descriptionFocus = FocusNode();

  File? imageFile;
  File? selectedAvatar;

  bool submitLoading = false;
  bool uploadAvatarLoading = false;
  bool uploadImageLoading = false;

  Future<void> assetToFile(String assetPath) async {
    uploadAvatarLoading = true;
    update();

    // Load asset as byte data
    final byteData = await rootBundle.load(assetPath);

    // Get temporary directory
    final tempDir = await getTemporaryDirectory();
    selectedAvatar = File('${tempDir.path}/${assetPath.split('/').last}');

    // Write bytes to the file
    await selectedAvatar?.writeAsBytes(byteData.buffer.asUint8List());
    uploadAvatarLoading = false;
    update();
  }

  void selectAvatar(String avatarPath) {
    String avatar = avatarPath;
    imageFile = null;
    assetToFile(avatar);
    update();
    Get.back();
  }

  void pickImage() async {
    uploadImageLoading = true;
    update();
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      imageFile = File(picked.path);
      selectedAvatar = null;
      uploadImageLoading = false;
      update();
    }
  }

  Future<void> createClub() async {
    if (formKey.currentState!.validate()) {
      if (imageFile == null && selectedAvatar == null) {
        showCustomSnackBar(
          AppStrings.imageRequired,
          AppStrings.imageRequiredMessage,
        );
      } else {
        submitLoading = true;
        update();
        final clubName = clubNameController.text.trim();
        final clubCategory = clubCategoryController.text.trim();
        final description = descriptionController.text;
        try {
          CreateClubModel createClubModel = CreateClubModel(
            title: clubName,
            category: clubCategory,
            desc: description,
          );
          ResponseModel response = await repo.createClub(
            createClubModel,
            imageFile != null ? imageFile! : selectedAvatar!,
          );
          if (response.isSuccess) {
            print("Response: ${response.responseJson}");
            Get.back();
            showCustomSnackBar(AppStrings.success, response.message);
          } else {
            showCustomSnackBar(AppStrings.error, response.message);
          }
        } catch (e) {
          debugPrint(e.toString());
          showCustomSnackBar(AppStrings.error, AppStrings.somethingWentWrong);
        } finally {
          submitLoading = false;
          update();
        }
      }
    }
  }

  @override
  void onClose() {
    clubNameController.dispose();
    clubCategoryController.dispose();
    descriptionController.dispose();

    clubNameFocus.dispose();
    clubCategoryFocus.dispose();
    descriptionFocus.dispose();
    super.onClose();
  }
}
