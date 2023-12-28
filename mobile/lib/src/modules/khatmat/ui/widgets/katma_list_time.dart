import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kawtharuna/src/core/constants/app_dimens.dart';
import 'package:kawtharuna/src/core/constants/app_radius.dart';
import 'package:kawtharuna/src/core/constants/app_text_style.dart';
import 'package:kawtharuna/src/core/di/di.dart';
import 'package:kawtharuna/src/core/managers/managers.dart';
import 'package:kawtharuna/src/core/utils/utils_collection.dart';
import 'package:kawtharuna/src/core/widgets/common/app_inkwell_widget.dart';
import 'package:kawtharuna/src/core/widgets/common/horizontal_padding.dart';
import 'package:kawtharuna/src/core/widgets/image/app_image_widget.dart';
import 'package:kawtharuna/src/modules/khatmat/domain/entity/khatma_entity.dart';
import 'package:provider/provider.dart';

class KhatmaListItem extends StatelessWidget {
  final KhatmaEntity khatma;

  const KhatmaListItem({
    super.key,
    required this.khatma,
  });

  @override
  Widget build(BuildContext context) {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(context);

    final width = DeviceUtils.getScaledWidth(context, 0.25);
    final height = DeviceUtils.getScaledHeight(context, 0.25);
    final imgSize = min(width, height);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimens.space8,
        horizontal: AppDimens.space16,
      ),
      child: AppInkWellWidget(
        onTap: () {
          navigator.pushNamed(
            Routes.khatmaDetailsScreen,
            arguments: BaseNavigationArg(
              data: khatma,
            ),
          );
        },
        child: Row(
          children: [
            AppImageWidget(
              path: khatma.reciter?.image,
              width: imgSize,
              height: imgSize,
              borderRadius: AppRadius.radius12,
              boxFit: BoxFit.cover,
            ),
            HorizontalTextPadding.with8(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppUtils.localizedPlatform(context, khatma.name),
                    maxLines: 3,
                    style: appTextStyle.semiBold16.copyWith(
                      color: themeStore.appColors.textColor,
                    ),
                  ),
                  Text(
                    translate.by_sheikh(AppUtils.localizedPlatform(
                        context, khatma.reciter?.name)),
                    style: appTextStyle.regular14.copyWith(
                      color: themeStore.appColors.textColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
