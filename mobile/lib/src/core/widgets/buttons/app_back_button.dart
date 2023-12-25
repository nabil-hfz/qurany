import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:kawtharuna/src/core/constants/app_icon_size.dart';
import 'package:kawtharuna/src/core/managers/managers.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    Key? key,
    this.onBackPressed,
    this.color,
  }) : super(key: key);
  final void Function()? onBackPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(
      context,
      listen: true,
    );
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        size: AppIconSize.size_20,
        color: color ?? themeStore.appColors.iconColor,
      ),
      onPressed: onBackPressed ?? GoRouter.of(context).pop,
    );
  }
}
