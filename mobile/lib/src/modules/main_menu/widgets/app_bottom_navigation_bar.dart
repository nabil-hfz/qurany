import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kawtharuna/src/core/constants/app_icon_size.dart';
import 'package:kawtharuna/src/core/constants/app_text_size.dart';
import 'package:kawtharuna/src/core/constants/app_text_style.dart';
import 'package:kawtharuna/src/core/generated_files/assets/assets.gen.dart';
import 'package:kawtharuna/src/core/managers/managers.dart';
import 'package:kawtharuna/src/core/widgets/audio/app_player.dart';
import 'package:kawtharuna/src/core/widgets/image/app_image_widget.dart';
import 'package:kawtharuna/src/modules/main_menu/screens/main_menu_screen.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(
      context,
      listen: true,
    );
    return ValueListenableBuilder(
      valueListenable: playerExpandProgress,
      builder: (context, height, child) {
        final value = percentageFromValueInRange(
          min: playerMinHeight,
          max: playerMaxHeight,
          value: height,
        );

        var opacity = 1 - value;
        if (opacity < 0) opacity = 0;
        if (opacity > 1) opacity = 1;
        return SizedBox(
          height: appBottomNavigationBarHeight -
              appBottomNavigationBarHeight * value,
          child: Transform.translate(
            offset: Offset(0.0, appBottomNavigationBarHeight * value * 0.5),
            child: Opacity(
              opacity: opacity,
              child: OverflowBox(
                maxHeight: appBottomNavigationBarHeight,
                child: child,
              ),
            ),
          ),
        );
      },
      child: ValueListenableBuilder(
        valueListenable: currentIndex,
        builder: (context, index, child) {
          return BottomNavigationBar(
            backgroundColor:
                themeStore.appColors.backgroundBottomNavigationBarColor,
            selectedItemColor:
                themeStore.appColors.selectedIconBottomNavigationBarColor,
            unselectedItemColor:
                themeStore.appColors.unselectedIconBottomNavigationBarColor,
            selectedLabelStyle: appTextStyle.bold14.copyWith(
              color: themeStore.appColors.textColor,
            ),
            unselectedLabelStyle: appTextStyle.medium14.copyWith(
              color: themeStore.appColors.textColor,
            ),
            selectedFontSize: AppTextSize.size_16,
            unselectedFontSize: AppTextSize.size_14,
            type: BottomNavigationBarType.shifting,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex: index,
            onTap: (newIndex) {
              currentIndex.value = newIndex;
            },
            items: <BottomNavigationBarItem>[
              _buildItem(
                themeStore,
                Assets.icons.quran.path,
                translate.quran,
                0 == index,
              ),
              _buildItem(
                themeStore,
                Assets.icons.library.path,
                translate.library,
                1 == index,
              ),
            ],
          );
        },
      ),
    );
  }

  BottomNavigationBarItem _buildItem(
    AppThemeManager themeStore,
    String path,
    String title,
    bool isSelected,
  ) {
    return BottomNavigationBarItem(
      icon: AppImageWidget(
        path: path,
        width: isSelected ? AppIconSize.size_24 : AppIconSize.size_20,
        height: isSelected ? AppIconSize.size_24 : AppIconSize.size_20,
        color: isSelected
            ? themeStore.appColors.selectedIconBottomNavigationBarColor
            : themeStore.appColors.unselectedIconBottomNavigationBarColor,
      ),
      label: title,
    );
  }
}
