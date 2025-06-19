import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/controller/localization_controller.dart';
import 'package:hobby_club_app/controller/notifications_controller.dart';
import 'package:hobby_club_app/controller/theme_controller.dart';
import 'package:hobby_club_app/firebase_options.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/app_translations.dart';
import 'package:hobby_club_app/utils/theme/darktheme/dark_theme.dart';
import 'package:hobby_club_app/utils/theme/lighttheme/light_theme.dart';
import 'package:hobby_club_app/view/screens/auth/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  (() => SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppColors.background,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.background,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  ))();
  await GetStorage.init();
  Get.put(NotificationsController());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());
    LocaleController localeController = Get.put(LocaleController());

    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: AppTranslations(),
        fallbackLocale: const Locale('en', 'US'),
        locale: localeController.currentLocale.value,

        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeController.themeMode.value, // Dynamic mode
        // themeMode: ThemeMode.light,
        builder: (context, child) {
          return Stack(
            children: [
              Obx(() {
                final isDark = themeController.isDarkMode;

                return FloatingDraggableWidget(
                  autoAlign: true,
                  dx: 1,
                  dy: 70,
                  floatingWidget: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                          ),
                          color: Colors.white.withValues(alpha: 0.1),

                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            themeController.toggleTheme();
                          },
                          child:
                              isDark
                                  ? const Icon(
                                    Icons.wb_sunny,
                                    color: Colors.yellow,
                                    size: 30,
                                  )
                                  : const Icon(
                                    Icons.nightlight_round,
                                    size: 30,
                                    color: Colors.indigo,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  floatingWidgetWidth: 50,
                  floatingWidgetHeight: 50,
                  mainScreenWidget: child!, // <- Not used here
                );
              }),
            ],
          );
        },

        home: const LoginScreen(),
      );
    });
  }
}
