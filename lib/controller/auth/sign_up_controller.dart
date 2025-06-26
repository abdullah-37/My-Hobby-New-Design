import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/models/auth/registration_model.dart';
import 'package:hobby_club_app/models/raw/response_model.dart';
import 'package:hobby_club_app/repo/auth/register_repo.dart';
import 'package:hobby_club_app/utils/app_strings.dart';
import 'package:hobby_club_app/view/screens/auth/profile_complete_screen.dart';
import 'package:hobby_club_app/view/widgets/custom_snackbar.dart';

class SignUpController extends GetxController {
  RegisterRepo repo = RegisterRepo();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final emailFocus = FocusNode();
  final phoneFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();
  bool isLoading = false;

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    update();
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
    update();
  }

  void register() async {
    isLoading = true;
    update();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    try {
      if (email.isEmpty || phone.isEmpty || password.isEmpty) {
        showCustomSnackBar(AppStrings.error, AppStrings.invalidData);
      } else if (password != confirmPassword) {
        showCustomSnackBar(AppStrings.error, AppStrings.passwordsDoNotMatch);
      } else {
        RegistrationModel registrationModel = RegistrationModel(
          email: email,
          phone: phone,
          password: password,
        );

        ResponseModel response = await repo.registerUser(registrationModel);
        if (response.isSuccess) {
          Get.off(ProfileCompleteScreen());
          showCustomSnackBar(AppStrings.success, response.message);
        } else {
          debugPrint(response.message);
          showCustomSnackBar(AppStrings.error, response.message);
        }
      }
    } catch (e) {
      showCustomSnackBar(AppStrings.error, AppStrings.somethingWentWrong);
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailFocus.dispose();
    phoneFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    super.dispose();
  }
}
