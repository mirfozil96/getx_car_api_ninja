// settings_controller.dart
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class SettingsController extends GetxController {
  final GetStorage box = GetStorage();

  // Reactive variables for theme and language
  var isDarkTheme = false.obs;
  var selectedLanguage = 'uz'.obs;

  @override
  void onInit() {
    super.onInit();
    // Load saved theme and language from storage
    isDarkTheme.value = box.read('isDarkTheme') ?? false;
    selectedLanguage.value = box.read('selectedLanguage') ?? 'uz';

    // Apply theme and language
    Get.changeThemeMode(isDarkTheme.value ? ThemeMode.dark : ThemeMode.light);
    Get.updateLocale(Locale(selectedLanguage.value));
  }

  void toggleTheme(bool value) {
    isDarkTheme.value = value;
    box.write('isDarkTheme', isDarkTheme.value);
    Get.changeThemeMode(isDarkTheme.value ? ThemeMode.dark : ThemeMode.light);
  }

  void changeLanguage(String languageCode) {
    selectedLanguage.value = languageCode;
    box.write('selectedLanguage', selectedLanguage.value);
    Get.updateLocale(Locale(selectedLanguage.value));
  }
}
