import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kawtharuna/src/core/constants/app_enums.dart';
import 'package:kawtharuna/src/core/entity/localization/localized_entity.dart';

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

  static String platformStr() {
    if (kIsWeb) {
      return PlatformTargetApp.web.name;
    } else {
      if (Platform.isAndroid) {
        return PlatformTargetApp.android.name;
      } else if (Platform.isIOS) {
        return PlatformTargetApp.iOS.name;
      } else if (Platform.isLinux) {
        return PlatformTargetApp.linux.name;
      } else if (Platform.isMacOS) {
        return PlatformTargetApp.macOs.name;
      } else if (Platform.isWindows) {
        return PlatformTargetApp.windows.name;
      } else {
        return "";
      }
    }
  }

  static String bytesToHex(List<int> bytes) {
    return bytes.map((e) => e.toRadixString(16).padLeft(2, '0')).join('');
  }

  /*
  static showToast({
    required String msg,
    Toast? toastLength,
    Color? backgroundColor,
    Color? textColor,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: AppTextSize.size_16,
    );
  }

  static appShowDialog<T>({
    required BuildContext context,
    required Widget Function(BuildContext context) builder,
  }) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) {
        return builder(context);
      },
    ).then((T? value) {});
  }

  static showSnackBar({
    required BuildContext context,
    required String message,
    TextStyle? style,
    Color? backgroundColor,
  }) {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(context);

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

  static showCustomMessage({
    required BuildContext context,
    String? title,
    String? message,
    Widget? titleText,
    Widget? messageText,
    Color? backgroundColor,
    Color? titleColor,
    FlushbarPosition position = FlushbarPosition.BOTTOM,
    Curve reverseAnimationCurve = Curves.decelerate,
    Curve forwardAnimationCurve = Curves.elasticOut,
    bool isDismissible = false,
    Duration? duration,
    Widget? icon,
    Widget? mainButton,
  }) async {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(context);
    Flushbar(
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

  static showWarningMessage({
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
    AppThemeManager themeStore = Provider.of<AppThemeManager>(context);
    showCustomMessage(
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

  static showErrorMessage({
    required BuildContext context,
    String? title,
    String? message,
    Widget? titleText,
    Widget? messageText,
    Color? titleColor,
    Color? iconColor,
    FlushbarPosition position = FlushbarPosition.BOTTOM,
  }) async {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(context);
    showCustomMessage(
      title: title,
      titleColor: titleColor,
      message: message,
      position: position,
      context: context,
      icon: Icon(
        Icons.error_outline,
        size: AppIconSize.size_16,
        color: iconColor ?? themeStore.appColors.iconColor,
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

  /// A normal email Regular Expression
  /// checks the current email value
  /// if it matches the reg
  static emailValidator(
    String value,
  ) {
    final regex = RegExp(
      r"^[a-zA-Z\d.a-zA-Z\d!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+",
    );
    return regex.hasMatch(value);
  }

  /// Returns a correct value of the current
  /// given values.
  static platform({android, ios}) {
    if (Platform.isIOS) return ios;
    return android;
  }
  */

  /// Returns a generated random color with ends with the white color value.
  static int generateColor() {
    return Random().nextInt(0xffffffff);
  }

  /// Opens current link after checking it
// static openLink({
//   String url = '-',
// }) async {
//   print('openLink ${url}');
//   try {
//     if (await canLaunchUrl(Uri.tryParse(url)!)) {
//       // print('Uri.tryParse(url) is ${Uri.tryParse(url)!}');
//       await launch(
//         url,
//         forceSafariVC: false,
//         forceWebView: false,
//       );
//     } else
//       CustomSnackbarToastDialog.showErrorMsgSnackBar(
//         '${translate.could_not_open_this_link}',
//       );
//   } catch (e) {
//     CustomSnackbarToastDialog.showErrorMsgSnackBar(
//       '${translate.could_not_open_this_link}',
//     );
//   }
// }

  /// Opens current link after checking it
// static clipboard({
//   required String text,
// }) async {
//   try {
//     Clipboard.setData(ClipboardData(text: text)).then((value) {
//       showToast(message: '${translate.copied_to_clipboard}');
//     });
//   } catch (e) {
//     print('clipboard error is $e');
//     // showToast(message: '${translate.no_data_found}');
//   }
// }
//
}

AppUtils appUtils = AppUtils.instance;
