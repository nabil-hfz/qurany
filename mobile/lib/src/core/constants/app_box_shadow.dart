import 'package:flutter/cupertino.dart';
import 'package:kawtharuna/src/core/di/di.dart';
import 'package:kawtharuna/src/core/managers/theme/app_them_manager.dart';

class AppBoxShadow {
  AppBoxShadow._();

  static BoxShadow serviceShadow = BoxShadow(
    color: const Color(0xFF000000).withAlpha(21),
    offset: const Offset(0.0, 2.0),
    blurRadius: 12,
    spreadRadius: 0,
  );
  static BoxShadow packageShadow = BoxShadow(
    color: const Color(0xff0BA0D0).withOpacity(0.2),
    offset: const Offset(0, 2),
    blurRadius: 12,
    spreadRadius: 0,
  );
}

class AppGradient {
  AppGradient._();

  static LinearGradient packageBaseGradient = LinearGradient(
    colors: [
      findDep<AppThemeManager>().appColors.packageBaseGradientStartColor,
      findDep<AppThemeManager>().appColors.packageBaseGradientEndColor,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static LinearGradient packageCircleGradient = LinearGradient(
    colors: [
      findDep<AppThemeManager>().appColors.packageCircleGradientStartColor,
      findDep<AppThemeManager>().appColors.packageCircleGradientEndColor,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient serviceDetailsAppBarGradient = LinearGradient(
    colors: [
      findDep<AppThemeManager>()
          .appColors
          .serviceDetailsAppBarGradientStartColor,
      findDep<AppThemeManager>().appColors.serviceDetailsAppBarGradientEndColor,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.center,
  );
}
