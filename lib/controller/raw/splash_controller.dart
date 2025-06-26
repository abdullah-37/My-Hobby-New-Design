import 'dart:async';

import 'package:get/get.dart';
import 'package:hobby_club_app/services/api_services.dart';
import 'package:hobby_club_app/view/screens/auth/login_screen.dart';
import 'package:hobby_club_app/view/screens/home_screen.dart';

class SplashController extends GetxController {
  final ApiServices api = ApiServices();

  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    await api.initToken();
    if (api.token.isEmpty) {
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }
}