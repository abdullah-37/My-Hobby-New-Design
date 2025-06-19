import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  // Use ThemeMode.system as default
  Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  bool get isDarkMode =>
      themeMode.value == ThemeMode.dark ||
      (themeMode.value == ThemeMode.system &&
          MediaQuery.of(Get.context!).platformBrightness == Brightness.dark);

  void toggleTheme() {
    if (isDarkMode) {
      themeMode.value = ThemeMode.light;
    } else {
      themeMode.value = ThemeMode.dark;
    }
  }
}
