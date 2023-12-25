import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:kawtharuna/src/core/constants/constants.dart';
import 'package:kawtharuna/src/core/managers/managers.dart';
import 'package:kawtharuna/src/core/widgets/buttons/app_back_button.dart';

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EmptyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Size get preferredSize => Size.zero;
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final String? titleString;
  final Widget? leading;
  final bool? automaticallyImplyLeading;
  final bool? centerTitle;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final double? elevation;
  final double? height;
  final PreferredSizeWidget? bottom;
  final SystemUiOverlayStyle? systemOverlayStyle;

  const CustomAppBar({
    super.key,
    this.title,
    this.leading,
    this.backgroundColor,
    this.height,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.elevation = 0,
    this.centerTitle,
    this.titleString,
    this.bottom,
    this.systemOverlayStyle,
  });

  @override
  Widget build(BuildContext context) {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(
      context,
      listen: true,
    );
    return AppBar(
      elevation: elevation,
      // systemOverlayStyle: systemOverlayStyle ??
      //     (!_themeStore.darkMode
      //         ? SystemUiOverlayStyle.dark
      //         : SystemUiOverlayStyle.light),
      backgroundColor: backgroundColor ?? themeStore.appColors.appBarColor,
      leading: automaticallyImplyLeading != null
          ? (automaticallyImplyLeading! ? AppBackButton() : leading)
          : null,
      iconTheme: Theme.of(context).appBarTheme.iconTheme!.copyWith(
            color: themeStore.appColors.iconColor,

            // iconTheme: IconThemeData(
            //   color: baseColor.iconColor,
            // ),
          ),
      actionsIconTheme:
          Theme.of(context).appBarTheme.actionsIconTheme!.copyWith(
                color: themeStore.appColors.iconColor,

                // iconTheme: IconThemeData(
                //   color: baseColor.iconColor,
                // ),
              ),
      title: titleString != null
          ? Text(
              titleString!,
              style: appTextStyle.medium18.copyWith(
                color: themeStore.appColors.textColor,
                fontWeight: AppFontWeight.bold,
              ),
            )
          : title ?? Container(),
      centerTitle: centerTitle ?? false,
      automaticallyImplyLeading: false,
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size(
        double.infinity,
        height ?? kToolbarHeight + (bottom != null ? kToolbarHeight * .75 : 0),
      );
}
