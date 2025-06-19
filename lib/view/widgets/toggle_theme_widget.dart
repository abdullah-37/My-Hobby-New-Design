import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/theme_controller.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Obx(() {
      final isDark = themeController.themeMode.value == ThemeMode.dark;

      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return RotationTransition(
            turns: Tween(begin: 0.40, end: 1.0).animate(animation),
            child: FadeTransition(
              opacity: animation,
              child: ScaleTransition(scale: animation, child: child),
            ),
          );
        },
        child: IconButton(
          key: ValueKey<bool>(isDark), // Important for AnimatedSwitcher
          icon:
              isDark
                  ? const Icon(Icons.wb_sunny, color: Colors.yellow, size: 32)
                  : const Icon(
                    Icons.nightlight_round,
                    color: Colors.indigo,
                    size: 32,
                  ),
          tooltip: 'Toggle Theme',
          onPressed: () {
            themeController.toggleTheme();
          },
        ),
      );
    });
  }
}
