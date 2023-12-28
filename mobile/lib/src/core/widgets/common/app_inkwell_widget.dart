// Flutter imports:
import 'package:flutter/material.dart';
import 'package:kawtharuna/src/core/constants/app_radius.dart';
import 'package:kawtharuna/src/core/managers/theme/app_them_manager.dart';

// Package imports:
import 'package:provider/provider.dart';

/// General clickable widget used across all the application based on [InkWell]
/// material defined widget.
class AppInkWellWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Color? splashAppInkWellColor;

  const AppInkWellWidget({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.borderRadius,
    this.splashAppInkWellColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    AppThemeManager themeManager = Provider.of<AppThemeManager>(context);
    return Material(
      color: Colors.transparent,
      shadowColor:
          splashAppInkWellColor ?? themeManager.appColors.splashAppInkWellColor,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        splashColor: splashAppInkWellColor ??
            themeManager.appColors.splashAppInkWellColor,
        borderRadius: borderRadius ??
            BorderRadius.circular(
              AppRadius.radiusSelectedAppInkWell12,
            ),
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: child,
        ),
      ),
    );
  }
}
