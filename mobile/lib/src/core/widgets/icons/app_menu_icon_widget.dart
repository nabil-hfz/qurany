import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:kawtharuna/src/core/constants/app_icon_size.dart';
import 'package:kawtharuna/src/core/generated_files/assets/assets.gen.dart';
import 'package:kawtharuna/src/core/managers/managers.dart';

class AppMenuIconWidget extends StatelessWidget {
  const AppMenuIconWidget({this.onDrawerPressed, super.key});

  final void Function()? onDrawerPressed;

  @override
  Widget build(BuildContext context) {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(
      context,
      listen: true,
    );
    return IconButton(
      onPressed: onDrawerPressed,
      icon: SvgPicture.asset(
        Assets.icons.menu.path,
        width: AppIconSize.size_28,
        height: AppIconSize.size_28,
        color: themeStore.appColors.iconColor,
      ),
    );
  }
}
