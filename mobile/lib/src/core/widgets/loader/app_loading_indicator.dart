// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kawtharuna/src/core/managers/managers.dart';

// Package imports:
import 'package:provider/provider.dart';

enum AppLoaderSize {
  microscopic,
  tiny,
  small,
  normal,
}

class AppLoader extends StatelessWidget {
  final AppLoaderSize size;
  final Color? iconColor;

  const AppLoader({
    super.key,
    this.size = AppLoaderSize.small,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(context);
    double size = 40;
    if (this.size == AppLoaderSize.small) size = 40;
    if (this.size == AppLoaderSize.tiny) size = 24;
    if (this.size == AppLoaderSize.microscopic) size = 18;
    return Center(
      child: SpinKitFadingFour(
        size: size,
        color: iconColor ?? themeStore.appColors.loaderColor,
      ),
    );
  }
}

// class AppLoaderWidget extends StatelessWidget {
//   // final String? loadingComment;
//   final LoaderSize? loaderSize;
//   final Color? loaderColor;
//   final LoaderType type;
//
//   const AppLoaderWidget({
//     Key? key,
//     this.loaderColor,
//     this.loaderSize = LoaderSize.normal,
//     this.type = LoaderType.circular,
//   }) : super(key: key);
//
//   factory AppLoaderWidget.small() {
//     return const AppLoaderWidget(
//       loaderSize: LoaderSize.small,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     AppThemeManager themeStore =
//         Provider.of<AppThemeManager>(context, listen: true);
//     Widget loader;
//
//     if (type == LoaderType.horizontal) {
//       loader = SpinKitThreeBounce(
//         color: loaderColor ?? themeStore.appColors.appLoaderColor,
//         size: (loaderSize == LoaderSize.small) ? 38 : 60,
//       );
//     } else if (loaderSize == LoaderSize.small) {
//       loader = SpinKitCircle(
//         duration: const Duration(
//           milliseconds: AppDuration.longAnimationDuration,
//         ),
//         color: loaderColor ?? themeStore.appColors.appLoaderColor,
//         size: 38,
//       );
//     } else if (loaderSize == LoaderSize.tiny) {
//       loader = SpinKitCircle(
//         duration: const Duration(
//           milliseconds: AppDuration.longAnimationDuration,
//         ),
//         color: loaderColor ?? themeStore.appColors.appLoaderColor,
//         size: 35,
//       );
//     } else if (loaderSize == LoaderSize.microscopic) {
//       loader = SpinKitCircle(
//         duration: const Duration(
//           milliseconds: AppDuration.longAnimationDuration,
//         ),
//         color: loaderColor ?? themeStore.appColors.appLoaderColor,
//         size: 24,
//       );
//     } else {
//       loader = SpinKitCircle(
//         duration: const Duration(
//           milliseconds: AppDuration.longAnimationDuration,
//         ),
//         color:
//             loaderColor ?? themeStore.appColors.appLoaderColor.withOpacity(0.7),
//         size: 56,
//       );
//     }
//
//     return Container(
//       // height: DeviceUtils.designHeight,
//       // color: themeStore.appColors.loaderBGColor,
//       child: loader,
//     );
//   }
// }
//
// enum LoaderSize {
//   small,
//   normal,
//   tiny,
//   microscopic,
// }
//
// enum LoaderType {
//   horizontal,
//   circular,
// }
