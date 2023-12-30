import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kawtharuna/src/core/constants/app_enums.dart';
import 'package:kawtharuna/src/core/constants/app_icon_size.dart';
import 'package:kawtharuna/src/core/entity/localization/localized_entity.dart';
import 'package:kawtharuna/src/core/managers/managers.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';

enum LogType {
  info,
  warning,
  severe,
}

void appPrint(dynamic value) {
  //if (isProduction)
  {
    // dev.log(
    //     '==================================[TAG]==================================');
    // dev.log('$value', sequenceNumber: 200);
    // dev.log(
    //     '=========================================================================');
  }
}

class AppUtils {
  static AppUtils instance = AppUtils._();

  AppUtils._();

  static void debugPrint(dynamic value) {
    material.debugPrint('\n');
    material.debugPrint('================================ '
        'Start printing'
        ' ================================');
    material.debugPrint("- ${value.toString()}");
    material.debugPrint('================================ '
        'End   printing'
        ' ================================');
    material.debugPrint('\n');
  }

  static void log(dynamic value, {LogType type = LogType.info}) {
    // material.debugPrint(value.toString());
    debugPrint('log info $value');
  }

  static bool notNullOrEmpty(String? value) {
    return value != null && value.isNotEmpty;
  }

  String _lang = AppStrings.langEn;

  void setLang(String? lang) {
    if (notNullOrEmpty(lang)) _lang = lang!;

    dev.log('---------------------Lang--------------:$_lang');
  }

  /// language helper without context
  String getLang() {
    if (_lang == AppStrings.langAr) return AppStrings.langAr;
    return AppStrings.langEn;
  }

  String getLanguageStr({String? langCode}) {
    switch (langCode) {
      case "ar":
        return "العربية";
      case "en":
        return "English";
      default:
        return "";
    }
  }

  static Future<dynamic> parseFileAssetToJson({
    required String assetFile,
  }) async {
    String jsonData = await rootBundle.loadString(assetFile);
    return json.decode(jsonData);
  }

  static String numberFormat(double number) {
    return NumberFormat.decimalPattern().format(number);
  }

  static String strDependOnPlatform({String? androidStr, String? iosStr}) {
    if (defaultTargetPlatform == TargetPlatform.iOS && notNullOrEmpty(iosStr)) {
      return iosStr!;
    } else if (defaultTargetPlatform == TargetPlatform.android &&
        notNullOrEmpty(androidStr)) {
      return androidStr!;
    }
    return "";
  }

  static dynamic languagePlatform(
    material.BuildContext context, {
    dynamic arabic,
    dynamic english,
  }) {
    // if ((defaultTargetPlatform == TargetPlatform.iOS))
    return english;
    // return arabic;
  }

  static String localizedPlatform(
    material.BuildContext context,
    LocalizedEntity? localized,
  ) {
    if (material.Directionality.of(context) == material.TextDirection.ltr) {
      return localized?.en ?? '';
    }
    return localized?.ar ?? '';
  }

  static void funDependOnPlatform({
    VoidCallback? androidFun,
    VoidCallback? iosFun,
    VoidCallback? webFun,
  }) {
    if (defaultTargetPlatform == TargetPlatform.iOS && iosFun != null) {
      iosFun();
    } else if (defaultTargetPlatform == TargetPlatform.android &&
        androidFun != null) {
      androidFun();
    } else if (kIsWeb && webFun != null) {
      webFun();
    }
  }

  static showSnackBar({
    required BuildContext context,
    required String message,
    TextStyle? style,
    Color? backgroundColor,
  }) {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(
      context,
      listen: false,
    );
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: style ??
              appTextStyle.medium16.copyWith(
                color: themeStore.appColors.textReversedColor,
              ),
        ),
        duration: const Duration(milliseconds: AppDuration.snackbarDuration),
        backgroundColor: backgroundColor,
      ),
    );
  }

  static Future<T?> _showCustomMessage<T>({
    required BuildContext context,
    String? title,
    String? message,
    Widget? titleText,
    Widget? messageText,
    Color? backgroundColor,
    Color? titleColor,
    FlushbarPosition position = FlushbarPosition.TOP,
    Curve reverseAnimationCurve = Curves.decelerate,
    Curve forwardAnimationCurve = Curves.elasticOut,
    bool isDismissible = true,
    Duration? duration,
    Widget? icon,
    Widget? mainButton,
  }) async {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(
      context,
      listen: false,
    );

    return Flushbar<T>(
      title: title,
      titleColor: titleColor,
      message: message,
      flushbarPosition: position,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: reverseAnimationCurve,
      forwardAnimationCurve: forwardAnimationCurve,
      backgroundColor:
          backgroundColor ?? themeStore.appColors.flushBarBackground,
      isDismissible: isDismissible,
      duration: duration ??
          const Duration(milliseconds: AppDuration.flushbarDuration),
      icon: icon,
      mainButton: mainButton,
      titleText: titleText,
      messageText: messageText,
    ).show(context);
  }

  static Future<T?> showWarningMessage<T>({
    required BuildContext context,
    String? title,
    String? message,
    Widget? titleText,
    Widget? messageText,
    Duration? duration,
    Color? titleColor,
    Color? iconColor,
    FlushbarPosition position = FlushbarPosition.BOTTOM,
  }) async {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(
      context,
      listen: false,
    );
    return _showCustomMessage(
      title: title,
      titleColor: titleColor,
      message: message,
      position: position,
      context: context,
      duration: duration,
      icon: Icon(
        Icons.warning_amber_rounded,
        size: AppIconSize.size_16,
        color: iconColor ?? themeStore.appColors.iconColor,
      ),
    );
  }

  static Future<T?> showErrorMessage<T>({
    required BuildContext context,
    String? title,
    String? message,
    Widget? titleText,
    Widget? messageText,
    Color? titleColor,
    Color? iconColor,
    FlushbarPosition position = FlushbarPosition.BOTTOM,
  }) async {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(
      context,
      listen: false,
    );
    return _showCustomMessage(
      title: title,
      titleColor: titleColor,
      message: message,
      position: position,
      context: context,
      backgroundColor: themeStore.appColors.flushBarErrorBackground,
      icon: Icon(
        Icons.error_outline,
        size: AppIconSize.size_24,
        color: iconColor ?? themeStore.appColors.iconReversedColor,
      ),
    );
  }

  static Future<T?> showSuccessMessage<T>({
    required BuildContext context,
    String? title,
    String? message,
    Widget? titleText,
    Widget? messageText,
    Color? titleColor,
    Color? iconColor,
    FlushbarPosition position = FlushbarPosition.BOTTOM,
  }) async {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(
      context,
      listen: false,
    );
    return _showCustomMessage(
      title: title,
      titleColor: titleColor,
      message: message,
      position: position,
      context: context,
      backgroundColor: themeStore.appColors.flushBarSuccessBackground,
      icon: Icon(
        Icons.check_circle,
        size: AppIconSize.size_24,
        color: iconColor ?? themeStore.appColors.iconReversedColor,
      ),
    );
  }

  /// dispatches any focus for the current interface
  static unFocus(
    BuildContext context,
  ) {
    var focus = FocusScope.of(context);
    if (focus.hasFocus) focus.unfocus();
  }

  /// Returns a generated random color with ends with the white color value.
  static int generateColor() {
    return Random().nextInt(0xffffffff);
  }
}

AppUtils appUtils = AppUtils.instance;
