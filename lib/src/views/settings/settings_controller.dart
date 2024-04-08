import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/common/read_write_storage.dart';

class SettingsController extends GetxController {
  final _themeMode = Rx<ThemeMode>(ThemeMode.system);
  ThemeMode get themeMode => _themeMode.value;

  Locale _currentLocale = const Locale('en', '');
  Locale get currentLocale => _currentLocale;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  Future<void> loadSettings() async {
    _themeMode.value = await readThemeMode();
    _currentLocale = await readLocale();
    update();
  }

  Future<void> updateThemeMode(ThemeMode newThemeMode) async {
    if (newThemeMode == _themeMode.value) return;
    _themeMode.value = newThemeMode;
    update();
    await write(StorageKeys.currentThemeKey, newThemeMode.toString().split('.').last);
    if(_themeMode.value==ThemeMode.system){
      if (Get.isPlatformDarkMode) {
        Get.changeTheme(ThemeData.dark());
      } else {
        Get.changeTheme(ThemeData.light());
      }
    }
    else if(_themeMode.value == ThemeMode.light)
    {
      Get.changeTheme(ThemeData.light());
    }
    else if(_themeMode.value == ThemeMode.dark){
      Get.changeTheme(ThemeData.dark());
    }
    update();
  }

  Future<void> changeLocale(Locale newLocale) async {
    if (newLocale == _currentLocale) return;
    _currentLocale = newLocale;
    log('currentLocale == $currentLocale');
    await write(StorageKeys.currentLanguageKey, newLocale.languageCode.toString());
    Get.updateLocale(_currentLocale);
    update();
  }

  Future<ThemeMode> readThemeMode() async {
    final themeModeString = await read(StorageKeys.currentThemeKey) =='' ?'system':await read(StorageKeys.currentThemeKey);
    if (themeModeString == 'system') {
      return ThemeMode.system;
    } else if (themeModeString == 'light') {
      return ThemeMode.light;
    } else {
      return ThemeMode.dark;
    }
  }

  Future<Locale> readLocale() async {
    final languageCode = await read(StorageKeys.currentLanguageKey)==''? 'en':await read(StorageKeys.currentLanguageKey);
    return Locale(languageCode);
  }
}
