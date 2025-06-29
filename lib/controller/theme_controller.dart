import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  // Use ThemeMode.system as default
  Rx<ThemeMode> themeMode = ThemeMode.light.obs;

  // bool get isDarkMode => themeMode.value == ThemeMode.dark;

  void toggleTheme() {
    if (themeMode.value == ThemeMode.dark) {
      themeMode.value = ThemeMode.light;
    } else {
      themeMode.value = ThemeMode.dark;
    }
  }
}
