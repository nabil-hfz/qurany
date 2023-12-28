// Flutter imports:
import 'package:flutter/material.dart';
import 'package:kawtharuna/src/core/constants/app_icon_size.dart';
import 'package:kawtharuna/src/core/constants/app_radius.dart';
import 'package:kawtharuna/src/core/generated_files/assets/assets.gen.dart';
import 'package:kawtharuna/src/core/managers/managers.dart';
import 'package:kawtharuna/src/core/widgets/image/app_image_widget.dart';

// Package imports:
import 'package:provider/provider.dart';

class AppBackIconWidget extends StatelessWidget {
  const AppBackIconWidget({
    super.key,
    this.color,
    this.withBgColor = true,
    this.onPressed,
  });
  final bool withBgColor;
  final Color? color;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    AppThemeManager themeManager = Provider.of<AppThemeManager>(context);
    AppLanguageManager languageManager =
        Provider.of<AppLanguageManager>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                withBgColor ? themeManager.appColors.iconReversedColor : null,
          ),
          child: AppIconButton(
            onPressed: onPressed,
            icon: RotatedBox(
              quarterTurns: languageManager.appLanguage == "ar" ? 2 : 0,
              child: AppImageWidget(
                width: AppIconSize.size_18,
                height: AppIconSize.size_18,
                path: Assets.icons.arrowBack.path,
                color: color ?? themeManager.appColors.iconColor,
                // color: isSilverCollapsed.value ? AppColors.black : AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Icon(
// Icons.search,
// color: appTheme.appColors.iconColor,
// ),
// )
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.iconSize,
  });
  final Widget icon;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final double? iconSize;

  factory AppIconButton.search({
    required void Function()? onPressed,
    Color? color,
    Color? backgroundColor,
  }) {
    return AppIconButton(
      backgroundColor: backgroundColor,
      icon: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Icon(
          Icons.search,
          color: color,
        ),
      ),
      onPressed: onPressed,
    );
  }

  factory AppIconButton.filter({
    required void Function()? onPressed,
    Color? color,
    Color? backgroundColor,
  }) {
    return AppIconButton(
      backgroundColor: backgroundColor,
      icon: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Icon(
          Icons.filter_list_rounded,
          color: color,
          size: 12,
        ),
      ),
      onPressed: onPressed,
    );
  }

  factory AppIconButton.options({
    required void Function()? onPressed,
    Color? color,
    Color? backgroundColor,
  }) {
    // AppIconSize.size_20,
    return AppIconButton(
      backgroundColor: backgroundColor,
      icon: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Icon(
          Icons.adaptive.more,
          color: color,
          size: AppIconSize.size_20,
        ),
      ),
      onPressed: onPressed,
    );
  }

  factory AppIconButton.phone({
    required void Function()? onPressed,
    Color? color,
    Color? backgroundColor,
  }) {
    // AppIconSize.size_20,
    return AppIconButton(
      backgroundColor: backgroundColor,
      icon: Padding(
        padding: const EdgeInsets.all(0.0),
        child: AppImageWidget(
          color: color,
          path: Assets.icons.phoneNumber.path,
          height: AppIconSize.size_20,
          width: AppIconSize.size_20,
        ),
      ),
      onPressed: onPressed,
    );
  }

  factory AppIconButton.share({
    required void Function()? onPressed,
    Color? color,
    Color? backgroundColor,
  }) {
    // AppIconSize.size_20,
    return AppIconButton(
      backgroundColor: backgroundColor,
      icon: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Icon(
          Icons.share_outlined,
          size: AppIconSize.size_20,
          color: color,
        ),
      ),
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    // AppThemeManager themeManager = Provider.of<AppThemeManager>(context);
    return IconButton(
      iconSize: iconSize,
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      splashRadius: AppRadius.radius20,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: MaterialStateProperty.all(backgroundColor),
      ),
      icon: icon,
    );
  }
}
