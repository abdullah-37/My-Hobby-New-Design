import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends GetxController {
  static const _localeKey = 'selected_locale';

  // Observable current locale
  var currentLocale = const Locale('en', 'US').obs;

  // Supported locales
  final supportedLocales = const [Locale('en', 'US')];

  @override
  void onInit() {
    super.onInit();
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLocale = prefs.getString(_localeKey);
    if (savedLocale != null) {
      final parts = savedLocale.split('_');
      if (parts.length == 2) {
        final locale = Locale(parts[0], parts[1]);
        if (supportedLocales.contains(locale)) {
          currentLocale.value = locale;
          Get.updateLocale(locale);
        }
      }
    }
  }

  Future<void> changeLocale(Locale locale) async {
    currentLocale.value = locale;
    Get.updateLocale(locale);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _localeKey,
      '${locale.languageCode}_${locale.countryCode}',
    );
    // await initializeDateFormatting(locale.toLanguageTag(), '');
  }

  String getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'zh':
        return '中文';
      case 'es':
        return 'Español';
      case 'fr':
        return 'Français';
      case 'de':
        return 'Deutsch';
      case 'ja':
        return '日本語';
      case 'ko':
        return '한국어';
      case 'ru':
        return 'Русский';
      case 'pt':
        return 'Português';
      case 'it':
        return 'Italiano';
      default:
        return locale.languageCode.toUpperCase();
    }
  }

  String getLanguageCode(Locale locale) =>
      '${locale.languageCode}-${locale.countryCode}';
  bool isRTL(Locale locale) =>
      locale.languageCode == 'ur' || locale.languageCode == 'ar';
  String get currentLanguageName => getLanguageName(currentLocale.value);
  String get currentLanguageCode => getLanguageCode(currentLocale.value);
  bool get isCurrentRTL => isRTL(currentLocale.value);
}
