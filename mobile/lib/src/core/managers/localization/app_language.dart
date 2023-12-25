import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:kawtharuna/src/core/constants/constants.dart';
import 'package:kawtharuna/src/core/helpers/hlp_shared_preference.dart';
import 'package:kawtharuna/src/core/utils/utils_collection.dart';

///
/// This manager is responsible of holding all required data for language
/// and determines current language.
///
/// TODO NABIL OR OMAR : For first launch of the application it gets the device's lang and
/// tries to see if we have a localized version of device's lang if
/// Yes: it will load it, otherwise by default English lang it will be loaded.
/// Then the application will save any changes to this preference with
/// help of [SharedPreferenceHelper] class.
@Singleton()
class AppLanguageManager extends ChangeNotifier {
  ///
  /// This is a classic class that is used to be like an interface for all
  /// the application that contains all used methods with all features across
  /// the application. This module all the time is
  /// ** injected ** to where it's used.
  late final SharedPreferenceHelper _sharedPreference;

  late Locale _appLocale;

  late String _langCode;

  Locale get appLocal => _appLocale;

  String get appLanguage => _langCode;

  AppLanguageManager(this._sharedPreference) {
    /// todo: uncomment these line when you want to change language working
    // if (_sharedPreference.getString(AppStrings.pref_language_code) == null) {
    //   String deviceLang = await getDeviceLang();
    //   if (deviceLang == AppStrings.LANG_AR) {
    //     _appLocale = const Locale(AppStrings.LANG_AR);
    //     _langCode = AppStrings.LANG_AR;
    //   } else {
    //     _appLocale = const Locale(AppStrings.LANG_EN);
    //     _langCode = AppStrings.LANG_EN;
    //   }
    //
    //   return Null;
    // }
    _sharedPreference.currentLanguage.then((value) {
      _appLocale = Locale(value);
      _langCode = value;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        notifyListeners();
      });
    });
  }

  // TODO OMAR : I think this method should be deleted...
  void fetchLocale() {
    // _sharedPreference.currentLanguage.then((value) {
    //   _appLocale = Locale(value);
    //   _langCode = value;
    //   notifyListeners();
    // });
  }

  Future<void> changeLanguage(String langCode) async {
    if (_langCode == langCode) {
      return;
    } else if (langCode == AppStrings.langAr) {
      _langCode = AppStrings.langAr;
      _appLocale = const Locale(AppStrings.langAr);
      await _sharedPreference.changeLanguage(_langCode);
      appUtils.setLang(_langCode);
    } else {
      _langCode = AppStrings.langEn;
      _appLocale = const Locale(AppStrings.langEn);
      await _sharedPreference.changeLanguage(_langCode);
      appUtils.setLang(_langCode);
    }
    notifyListeners();
  }

  Future<String> getDeviceLang() async {
    String? locale = await Devicelocale.currentLocale;
    String str;
    if (locale.toString().contains("_")) {
      str = locale.toString().substring(0, locale.toString().indexOf('_'));
    } else if (locale.toString().contains("-")) {
      str = locale.toString().substring(0, locale.toString().indexOf('-'));
    } else {
      str = locale.toString();
    }
    AppUtils.debugPrint("GetDeviceLang $str");
    return str;
  }

  /// This method is called from [MyApp] class when the whole app is disposed.
  @disposeMethod
  void disposeManager() {
    super.dispose();
  }
}
