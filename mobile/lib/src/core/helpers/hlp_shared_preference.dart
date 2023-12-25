import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';

@Singleton()
class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // General Method ------------------------------------------------------------

  Future<bool> removeValue(String key) {
    return _sharedPreference.remove(key);
  }

  Future<bool> _saveString(String key, String value) {
    return _sharedPreference.setString(key, value);
  }

  String? _getString(String key) => _sharedPreference.getString(key);

  Future<bool> _saveBool(String key, bool value) {
    return _sharedPreference.setBool(key, value);
  }

  bool? _getBool(String key) => _sharedPreference.getBool(key);

  Future<bool> _saveInt(String key, int value) {
    return _sharedPreference.setInt(key, value);
  }

  int? _getInt(String key) => _sharedPreference.getInt(key);

  // Auth Methods: ----------------------------------------------------------
  Future<String?> get authToken async {
    return _getString(AppStrings.prefAuthToken);
  }

  Future<bool> saveAuthToken(String authToken) async {
    return _saveString(AppStrings.prefAuthToken, authToken);
  }

  Future<bool> removeAuthToken() async {
    return removeValue(AppStrings.prefAuthToken);
  }

  // Login:---------------------------------------------------------------------
  Future<bool> get isLoggedIn async {
    return _getBool(AppStrings.prefIsLoggedIn) ?? false;
  }

  Future<bool> saveLoginStatus(bool value) async {
    return _saveBool(AppStrings.prefIsLoggedIn, value);
  }

  // Theme:------------------------------------------------------
  Future<bool> get isDarkMode async {
    return _getBool(AppStrings.prefIsDarkMode) ?? false;
  }

  Future<bool> changeMode(bool value) async {
    return _saveBool(AppStrings.prefIsDarkMode, value);
  }

  Future<String?> get getThemeMode async {
    return Future.value(_getString(AppStrings.prefThemeMode));
  }

  Future<bool> changeTheme(String value) async {
    return _saveString(AppStrings.prefThemeMode, value);
  }

  Future<int?> get getColor async {
    return Future.value(_getInt(AppStrings.prefColorMode));
  }

  Future<bool> changeColor(int? value) async {
    if (value == null) {
      return removeValue(AppStrings.prefColorMode);
    }
    return _saveInt(AppStrings.prefColorMode, value);
  }

  Future<String?> get getBrightnessStatus async {
    return Future.value(_getString(AppStrings.prefBrightnessStatus));
  }

  Future<bool> changeBrightnessStatus(String value) async {
    return _saveString(AppStrings.prefBrightnessStatus, value);
  }

  // App First launch:---------------------------------------------
  Future<bool> get isFirstLoad async {
    return Future.value(_getBool(AppStrings.prefIsFirstLoad) ?? true);
  }

  Future<bool> changeFirstLoadStatus(bool value) async {
    return await _saveBool(AppStrings.prefIsFirstLoad, value);
  }

  // Language:---------------------------------------------------
  Future<String> get currentLanguage async {
    return _getString(AppStrings.prefCurrentLanguage) ?? AppStrings.langEn;
  }

  Future<bool> changeLanguage(String language) async {
    return _saveString(AppStrings.prefCurrentLanguage, language);
  }
}
