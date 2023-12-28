import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:kawtharuna/src/core/constants/constants.dart';
import 'package:kawtharuna/src/core/managers/managers.dart';
import 'package:kawtharuna/src/core/widgets/buttons/app_back_button.dart';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kawtharuna/src/core/constants/constants.dart';
import 'package:kawtharuna/src/core/managers/theme/app_them_manager.dart';
import 'package:kawtharuna/src/core/widgets/icons/app_back_icon_widget.dart';

// Package imports:
import 'package:provider/provider.dart';

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EmptyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Size get preferredSize => Size.zero;
}

/// [CustomAppBar] General appbar used across the app.
///
/// For appbar title it will add [CustomAppBarTextWidget] in case there is not
/// [customTitle] widget provided.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.customTitle,
    this.statusBarColor,
    this.backgroundColor,
    this.arrowBackColor,
    this.systemOverlayStyle,
    this.toolbarHeight,
    this.bottom,
    this.titleColor,
    this.onBackPressed,
    this.elevation = 0.0,
    this.centerTitle = false,
    this.automaticallyImplyLeading = true,
  });

  final String? title;
  final bool centerTitle;
  final double? elevation;
  final double? toolbarHeight;
  final void Function()? onBackPressed;

  final Widget? leading;
  final Widget? customTitle;
  final List<Widget>? actions;
  final Color? statusBarColor;
  final Color? backgroundColor;
  final Color? arrowBackColor;
  final Color? titleColor;
  final bool automaticallyImplyLeading;
  final PreferredSizeWidget? bottom;
  final SystemUiOverlayStyle? systemOverlayStyle;

  @override
  Widget build(BuildContext context) {
    double leftPadding = automaticallyImplyLeading ? 0.0 : AppDimens.space4;
    AppThemeManager themeManager = Provider.of<AppThemeManager>(context);

    Widget? title;
    Widget? leading;
    if (automaticallyImplyLeading) {
      leading = AppBackIconWidget(
        onPressed: onBackPressed ?? Navigator.of(context).pop,
        color: arrowBackColor ?? themeManager.appColors.iconColor,
      );
      // IconButton(
      // onPressed: onBackPressed ?? Navigator.of(context).pop,
      // icon: AppBackIconWidget(
      //
      //   color: arrowBackColor ?? themeManager.appColors.iconColor,
      // )

      // RotatedBox(
      //   quarterTurns: languageManager.appLanguage == "ar" ? 2 : 0,
      //   child: AppImageWidget(
      //     width: AppIconSize.size_16,
      //     height: AppIconSize.size_16,
      //     path: Assets.icons.arrowBack.path,
      //     color: arrowBackColor ?? themeManager.appColors.iconColor,
      //   ),
      // ),
      // );
    } else if (this.leading != null) {
      leading = this.leading;
    }
    if (customTitle != null) {
      title = customTitle;
    } else {
      title = CustomAppBarTextWidget(
        title: this.title ?? '',
        titleColor: titleColor ?? themeManager.appColors.textColor,
      );
    }
    return AppBar(
      title: title,
      toolbarHeight: preferredSize.height,
      bottom: bottom,
      leading: leading,
      actions: actions,
      elevation: elevation,
      centerTitle: centerTitle,
      titleSpacing: leftPadding,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        toolbarHeight ??
            (customTitle == null
                ? (kToolbarHeight + (bottom != null ? kTextTabBarHeight : 0))
                : 65),
      );
}

class CustomAppBarTextWidget extends StatelessWidget {
  const CustomAppBarTextWidget(
      {super.key, required this.title, this.titleColor});

  final String title;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<AppThemeManager>(context);
    List<Widget> titleColumn = [
      Text(
        title,
        style: appTextStyle.bold18.copyWith(
          color: titleColor ?? theme.appColors.textColor,
        ),
      ),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: titleColumn,
    );
  }
}
