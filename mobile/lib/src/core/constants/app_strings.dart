class AppStrings {
  AppStrings._();

  //General
  static const appName = 'Kawtharuna';
  static const String langAr = "ar";
  static const String english = "English";
  static const String arabic = "العربية";
  static const String langEn = "en";

  /// Preference Keys
  static const String prefIsLoggedIn = "pref_is_logged_in";
  static const String prefAuthToken = "pref_auth_token";
  static const String prefIsDarkMode = "pref_is_dark_mode";
  static const String prefColorMode = "pref_color_mode";
  static const String prefBrightnessStatus = "pref_brightness_status";
  static const String prefThemeMode = "pref_theme_mode";
  static const String prefIsFirstLoad = "pref_is_first_load";
  static const String prefCurrentLanguage = "pref_current_language";

  static const IMAGE_PLACE_HOLDER =
      'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg';

  static var failedToGet = "failedToGet";
  static var dioErrorLevel = "Dio-Error-Level";
  static var firebaseErrorLevel = "Firebase-Error-Level";
  static var socialMediaAuthControllerErrorLevel =
      "SocialMediaAuthController-Error-Level";
  static var baseRepositoryErrorLevel = "BaseRepository-Error-Level";
}
