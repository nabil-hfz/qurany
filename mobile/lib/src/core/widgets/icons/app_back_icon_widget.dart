// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:salon_app/core/constants/app_icon_size.dart';
import 'package:salon_app/core/constants/app_radius.dart';
import 'package:salon_app/core/generated_files/assets/assets.gen.dart';
import 'package:salon_app/core/managers/localization/app_language.dart';
import 'package:salon_app/core/managers/theme/app_them_manager.dart';
import 'package:salon_app/core/widgets/image/app_image_widget.dart';

class AppBackIconWidget extends StatelessWidget {
  const AppBackIconWidget({
    Key? key,
    this.color,
    this.withBgColor = true,
    this.onPressed,
  }) : super(key: key);
  final bool withBgColor;
  final Color? color;
  final Function()? onPressed;

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
    Key? key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.iconSize,
  }) : super(key: key);
  final Widget icon;
  final Function()? onPressed;
  final Color? backgroundColor;
  final double? iconSize;

  factory AppIconButton.search({
    required Function() onPressed,
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
    required Function() onPressed,
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
    required Function() onPressed,
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
    required Function() onPressed,
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
    required Function() onPressed,
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

  factory AppIconButton.map({
    required Function() onPressed,
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
          path: Assets.icons.mapCodicon.path,
          height: AppIconSize.size_20,
          width: AppIconSize.size_20,
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
