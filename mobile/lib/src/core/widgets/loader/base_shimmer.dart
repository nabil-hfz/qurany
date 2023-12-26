// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

// Project imports:
import 'package:salon_app/core/managers/theme/app_them_manager.dart';

class BaseShimmerWidget extends StatelessWidget {
  final Widget? child;

  const BaseShimmerWidget({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(context);
    return Shimmer.fromColors(
      baseColor: themeStore.appColors.shimmerBaseColor,
      highlightColor: themeStore.appColors.shimmerHighlightColor,
      child: child!,
    );
  }
}
