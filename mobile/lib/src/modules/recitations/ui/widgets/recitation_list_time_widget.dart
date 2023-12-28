import 'package:flutter/material.dart';
import 'package:kawtharuna/src/core/constants/app_dimens.dart';
import 'package:kawtharuna/src/core/constants/app_radius.dart';
import 'package:kawtharuna/src/core/constants/app_text_style.dart';
import 'package:kawtharuna/src/core/managers/managers.dart';
import 'package:kawtharuna/src/core/utils/string_helper.dart';
import 'package:kawtharuna/src/core/utils/utils_collection.dart';
import 'package:kawtharuna/src/core/widgets/common/vertical_padding.dart';
import 'package:kawtharuna/src/core/widgets/image/app_image_widget.dart';
import 'package:kawtharuna/src/modules/recitations/domain/entity/recitation_entity.dart';
import 'package:provider/provider.dart';

class RecitationListItem extends StatelessWidget {
  final RecitationEntity recitation;

  const RecitationListItem({
    super.key,
    required this.recitation,
  });

  @override
  Widget build(BuildContext context) {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimens.space8,
        horizontal: AppDimens.space16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          AppImageWidget(
            path: recitation.image,
            borderRadius: AppRadius.radius6,
            boxFit: BoxFit.cover,
            // width: imgSize,
            // height: imgSize,
          ),
          VerticalTextPadding.with8(),
          Row(
            children: [
              Text(
                AppUtils.localizedPlatform(context, recitation.title),
                style: appTextStyle.semiBold16.copyWith(
                  color: themeStore.appColors.textColor,
                ),
              ),
              Spacer(),
              Text(
                StringHelper.formatDuration(
                    Duration(seconds: recitation.durationInSecond)),
                style: appTextStyle.medium12.copyWith(
                  color: themeStore.appColors.textGreyColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
