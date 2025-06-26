import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/models/auth/login_model.dart';
import 'package:hobby_club_app/models/raw/response_model.dart';
import 'package:hobby_club_app/repo/auth/login_repo.dart';
import 'package:hobby_club_app/utils/app_strings.dart';
import 'package:hobby_club_app/view/screens/auth/profile_complete_screen.dart';
import 'package:hobby_club_app/view/screens/home_screen.dart';
import 'package:hobby_club_app/view/widgets/custom_snackbar.dart';

class LoginController extends GetxController {
  final storage = GetStorage();
  LoginRepo repo = LoginRepo();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  bool obscurePassword = true;
  bool isLoading = false;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    update();
  }

  void login() async {
    isLoading = true;
    update();
    final email = emailController.text.trim();
    final password = passwordController.text;

    try {
      if (email.isEmpty || password.isEmpty) {
        showCustomSnackBar(AppStrings.error, AppStrings.invalidData);
      } else {
        ResponseModel response = await repo.loginUser(
          email: email,
          password: password,
        );

        debugPrint("Login Response: ${response.responseJson}");
        LoginModel loginModel = LoginModel.fromJson(
          json.decode(response.responseJson),
        );

        if (response.isSuccess) {
          await storage.write('profile', loginModel.profile!.toJson());
          await storage.write('user', loginModel.user!.toJson());

          showCustomSnackBar(AppStrings.success, response.message);

          if (loginModel.user?.proStatus == 0) {
            Get.off(ProfileCompleteScreen());
          } else {
            Get.off(HomeScreen());
          }
        } else {
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
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }
}
