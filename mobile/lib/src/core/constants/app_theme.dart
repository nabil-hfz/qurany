// Flutter imports:
// Package imports:
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Project imports:

import 'constants.dart';

ThemeData buildLightTheme(AppColors baseColor) {
  late TextTheme googleTheme;
  TextTheme? textTheme;
  try {
    // textTheme = Theme.of(navigator.navigatorKey.currentContext!).textTheme;
  } catch (error, stackTrace) {
    /// TODO : ERROR HERE NABIL
    // appPrint('error is $error \n stackTrace is $stackTrace');
  }

  googleTheme = GoogleFonts.poppinsTextTheme(textTheme);
  // ThemeData(
  //     dialogTheme: DialogTheme(
  //       contentTextStyle: TextStyle(
  //         color: Colors.red, // Set your desired color here
  //       ),
  //     ),
  final iconTheme = MaterialStateProperty.resolveWith<IconThemeData>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return IconThemeData(
          color: baseColor.textActiveColor,
        );
      }
      return IconThemeData(
        color: baseColor.iconGreyColor,
      );
    },
  );

  final labelTextStyle = MaterialStateProperty.resolveWith<TextStyle>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return appTextStyle.medium14.copyWith(
          color: baseColor.textActiveColor,
        );
      }
      return appTextStyle.medium14.copyWith(
        color: baseColor.textSubTitle,
      );
    },
  );
  final indicatorColor = baseColor.primaryColor.withOpacity(0.3);
  final surfaceTintColor = baseColor.primaryColor.withOpacity(0.3);
  return FlexThemeData.light(
    useMaterial3: !(defaultTargetPlatform == TargetPlatform.iOS),
    textTheme: googleTheme,
    scheme: FlexScheme.material,
    primary: baseColor.primaryColor,
    fontFamily: AppFontFamily.poppins,
    // onPrimary: baseColor.primaryColor,
    appBarBackground: baseColor.appBarColor,
    scaffoldBackground: baseColor.scaffoldBgColor,
    colorScheme: ColorScheme.light(
      primary: baseColor.primaryColor,
    ),
  ).copyWith(
    navigationBarTheme: NavigationBarThemeData(
      elevation: 4,
      iconTheme: iconTheme,
      indicatorColor: indicatorColor,
      surfaceTintColor: surfaceTintColor,
      labelTextStyle: labelTextStyle,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
    ),
    navigationRailTheme: NavigationRailThemeData(
      elevation: 4,
      indicatorColor: baseColor.primaryColor.withOpacity(0.3),
      selectedIconTheme: IconThemeData(
        color: baseColor.iconActiveColor,
      ),
      unselectedIconTheme: IconThemeData(
        color: baseColor.iconGreyColor,
      ),
      selectedLabelTextStyle: appTextStyle.semiBold16.copyWith(
        color: baseColor.textActiveColor,
      ),
      unselectedLabelTextStyle: appTextStyle.light14.copyWith(
        color: baseColor.textGreyColor,
      ),
    ),
    navigationDrawerTheme: NavigationDrawerThemeData(
      elevation: 4,
      iconTheme: iconTheme,
      labelTextStyle: labelTextStyle,
      indicatorColor: indicatorColor,
      surfaceTintColor: surfaceTintColor,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return baseColor.primaryColor;
        }
        return Colors.grey.shade400;
      }),
      side: BorderSide.none,
    ),

    dialogTheme: DialogTheme(
      titleTextStyle: appTextStyle.semiBold18.copyWith(
        color: baseColor.textColor,
      ),
      contentTextStyle: appTextStyle.medium16.copyWith(
        color: baseColor.textColor,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: baseColor.floatingActionButtonColor,
    ),
    // appBarTheme: AppBarTheme(
    // iconTheme: IconThemeData(color: baseColor.iconColor),
    // backgroundColor: baseColor.systemStatusBarColor,
    // systemOverlayStyle: SystemUiOverlayStyle(
    //   // statusBarBrightness: Brightness.dark,
    //   // statusBarIconBrightness: Brightness.dark,
    //   // systemNavigationBarIconBrightness: Brightness.dark,
    //   // statusBarColor: Colors.black,
    //   systemNavigationBarColor: baseColor.systemBottomNavigationBarColor,
    //   systemNavigationBarDividerColor: baseColor.systemDividerColor,
    // ),
    // ),
    // appBarTheme: AppBarTheme(
    //   systemOverlayStyle: SystemUiOverlayStyle(
    //     statusBarBrightness: Brightness.dark,
    //     statusBarIconBrightness: Brightness.light,
    //     systemNavigationBarIconBrightness: Brightness.light,
    //     statusBarColor: baseColor.systemStatusBarColor,
    //     systemNavigationBarColor: baseColor.systemBottomNavigationBarColor,
    //     systemNavigationBarDividerColor: baseColor.systemDividerColor,
    //   ),
    // ),
    tabBarTheme: TabBarTheme(
      labelColor: baseColor.tabBarLabelColor,
      unselectedLabelColor: baseColor.tabBarUnselectedLabelColor,
      unselectedLabelStyle: appTextStyle.regular14.copyWith(
        color: baseColor.textGreyColor,
      ),
      labelStyle: appTextStyle.bold16.copyWith(
        color: baseColor.textColor,
      ),
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: AppDimens.tabBarIndicatorHeight,
            color: baseColor.tabBarIndicatorColor,
          ),
        ),
      ),
    ),
  );
  // return ThemeData(
  //   useMaterial3: true,
  //   textTheme: googleTheme,
  //   brightness: Brightness.light,
  //   fontFamily: AppFontFamily.Regular,
  //   primaryColor: baseColor.primaryColor,
  //   backgroundColor: baseColor.scaffoldBgColor,
  //   scaffoldBackgroundColor: baseColor.scaffoldBgColor,
  //   primarySwatch: Colors.deepOrange,
  //   colorScheme: ColorScheme.light(
  //     error: baseColor.errorColor,
  //     brightness: Brightness.light,
  //     primary: AppColors.appPrimaryColor,
  //     background: baseColor.scaffoldBgColor,
  //   ),
  //   appBarTheme: AppBarTheme(
  //     backgroundColor: baseColor.appBarColor,
  //     iconTheme: IconThemeData(color: baseColor.iconColor),
  //     toolbarTextStyle: appTextStyle.bigTSBasic.copyWith(
  //       color: baseColor.textReversedColor,
  //       background: backgroundPaint,
  //       fontFamily: AppFontFamily.Regular,
  //     ),
  //     systemOverlayStyle: const SystemUiOverlayStyle(
  //       // Status bar brightness (optional)
  //       statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
  //       statusBarBrightness: Brightness.dark, // For iOS (dark icons)
  //       // statusBarColor: Colors.black54,
  //     ),
  //   ),
  //   dividerTheme: DividerThemeData(
  //     color: baseColor.dividerBorderColor,
  //     thickness: 0.8,
  //     endIndent: 16,
  //     indent: 16,
  //   ),
  // );
}

ThemeData buildDarkTheme(AppColors baseColor) {
  late TextTheme googleTheme;
  TextTheme? textTheme;
  try {
    googleTheme = GoogleFonts.poppinsTextTheme(textTheme);
    // textTheme = Theme.of(navigator.navigatorKey.currentContext!).textTheme;
  } catch (error, stackTrace) {
    // appPrint('error is $error \n stackTrace is $stackTrace');
  }
  final iconTheme = MaterialStateProperty.resolveWith<IconThemeData>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return IconThemeData(
          color: baseColor.textActiveColor,
        );
      }
      return IconThemeData(
        color: baseColor.iconGreyColor,
      );
    },
  );

  final labelTextStyle = MaterialStateProperty.resolveWith<TextStyle>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return appTextStyle.medium14.copyWith(
          color: baseColor.textActiveColor,
        );
      }
      return appTextStyle.medium14.copyWith(
        color: baseColor.textSubTitle,
      );
    },
  );
  final indicatorColor = baseColor.primaryColor.withOpacity(0.3);
  final surfaceTintColor = baseColor.primaryColor.withOpacity(0.3);
  return FlexThemeData.dark(
    useMaterial3: !(defaultTargetPlatform == TargetPlatform.iOS),
    textTheme: googleTheme,
    scheme: FlexScheme.material,
    primary: baseColor.primaryColor,
    fontFamily: AppFontFamily.poppins,
    // onPrimary: baseColor.primaryColor,
    appBarBackground: baseColor.appBarColor,
    scaffoldBackground: baseColor.scaffoldBgColor,
    colorScheme: ColorScheme.dark(
      primary: baseColor.primaryColor,
    ),
  ).copyWith(
    navigationBarTheme: NavigationBarThemeData(
      elevation: 4,
      iconTheme: iconTheme,
      indicatorColor: indicatorColor,
      surfaceTintColor: surfaceTintColor,
      labelTextStyle: labelTextStyle,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
    ),
    navigationRailTheme: NavigationRailThemeData(
      elevation: 4,
      indicatorColor: baseColor.primaryColor.withOpacity(0.3),
      selectedIconTheme: IconThemeData(
        color: baseColor.iconActiveColor,
      ),
      unselectedIconTheme: IconThemeData(
        color: baseColor.iconGreyColor,
      ),
      selectedLabelTextStyle: appTextStyle.semiBold16.copyWith(
        color: baseColor.textActiveColor,
      ),
      unselectedLabelTextStyle: appTextStyle.light14.copyWith(
        color: baseColor.textGreyColor,
      ),
    ),
    navigationDrawerTheme: NavigationDrawerThemeData(
      elevation: 4,
      iconTheme: iconTheme,
      labelTextStyle: labelTextStyle,
      indicatorColor: indicatorColor,
      surfaceTintColor: surfaceTintColor,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return baseColor.primaryColor;
        }
        return Colors.grey.shade400;
      }),
      side: BorderSide.none,
    ),
    dialogTheme: DialogTheme(
      titleTextStyle: appTextStyle.semiBold18.copyWith(
        color: baseColor.textColor,
      ),
      contentTextStyle: appTextStyle.medium16.copyWith(
        color: baseColor.textColor,
      ),
    ),
    // appBarTheme: AppBarTheme(
    //   systemOverlayStyle: SystemUiOverlayStyle(
    //     statusBarBrightness: Brightness.dark,
    //     statusBarIconBrightness: Brightness.light,
    //     systemNavigationBarIconBrightness: Brightness.light,
    //     statusBarColor: baseColor.systemStatusBarColor,
    //     systemNavigationBarColor: baseColor.systemBottomNavigationBarColor,
    //     systemNavigationBarDividerColor: baseColor.systemDividerColor,
    //   ),
    // ),
    // appBarTheme: AppBarTheme(
    //   iconTheme: IconThemeData(color: baseColor.iconColor),
    //   backgroundColor: baseColor.systemStatusBarColor,
    //   systemOverlayStyle: SystemUiOverlayStyle(
    //     statusBarBrightness: Brightness.dark,
    //     statusBarIconBrightness: Brightness.light,
    //     systemNavigationBarIconBrightness: Brightness.light,
    //     statusBarColor: baseColor.systemStatusBarColor,
    //     systemNavigationBarColor: baseColor.systemBottomNavigationBarColor,
    //     systemNavigationBarDividerColor: baseColor.systemDividerColor,
    //   ),
    // ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: baseColor.floatingActionButtonColor,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: baseColor.tabBarLabelColor,
      unselectedLabelColor: baseColor.tabBarUnselectedLabelColor,
      unselectedLabelStyle: appTextStyle.regular14.copyWith(
        color: baseColor.textGreyColor,
      ),
      labelStyle: appTextStyle.bold16.copyWith(
        color: baseColor.textColor,
      ),
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: AppDimens.tabBarIndicatorHeight,
            color: baseColor.tabBarIndicatorColor,
          ),
        ),
      ),
    ),
  );
  // return ThemeData(
  //   textTheme: googleTheme,
  //   fontFamily: AppFontFamily.Regular,
  //   brightness: Brightness.dark,
  //   primaryColor: baseColor.primaryColor,
  //   useMaterial3: true,
  //   primaryColorBrightness: Brightness.dark,
  //   scaffoldBackgroundColor: baseColor.scaffoldBgColor,
  //   backgroundColor: baseColor.scaffoldBgColor,
  //   accentIconTheme: IconThemeData(
  //     color: baseColor.iconColor,
  //   ),
  //   appBarTheme: AppBarTheme(
  //     backgroundColor: baseColor.appBarColor,
  //     iconTheme: IconThemeData(color: baseColor.iconColor),
  //     toolbarTextStyle: appTextStyle.bigTSBasic.copyWith(
  //       color: baseColor.primaryColor,
  //     ),
  //     systemOverlayStyle: const SystemUiOverlayStyle(
  //       // Status bar brightness (optional)
  //       statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
  //       statusBarBrightness: Brightness.light, // For iOS (dark icons)
  //     ),
  //   ),
  //   dividerTheme: DividerThemeData(
  //     color: baseColor.dividerBorderColor,
  //     thickness: 0.8,
  //     endIndent: 16,
  //     indent: 16,
  //   ),
  //   colorScheme: ColorScheme.fromSwatch().copyWith(
  //     primary: AppColors.appPrimaryColor,
  //     brightness: Brightness.dark,
  //   ),
  // );
}
