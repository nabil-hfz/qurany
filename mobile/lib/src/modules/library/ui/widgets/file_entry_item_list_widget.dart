import 'package:flutter/material.dart';
import 'package:kawtharuna/src/core/constants/app_icon_size.dart';
import 'package:kawtharuna/src/core/constants/app_text_style.dart';
import 'package:kawtharuna/src/core/managers/theme/app_them_manager.dart';
import 'package:kawtharuna/src/core/widgets/common/horizontal_padding.dart';
import 'package:kawtharuna/src/core/widgets/image/app_image_widget.dart';
import 'package:kawtharuna/src/modules/library/domain/entity/library_entity.dart';
import 'package:provider/provider.dart';

class FileEntryItemListWidget extends StatelessWidget {
  const FileEntryItemListWidget({required this.file, super.key});

  final FileEntryEntity file;

  @override
  Widget build(BuildContext context) {
    AppThemeManager appTheme = Provider.of<AppThemeManager>(
      context,
      listen: true,
    );
    // final height = DeviceUtils.getScaledHeight(context, 1);
    // final width = DeviceUtils.getScaledWidth(context, 1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: AppImageWidget(
            path: file.thumbnail,
            boxFit: BoxFit.cover,
          ),
        ),
        Row(
          children: [
            HorizontalTextPadding.with2(),
            Text(
              file.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: appTextStyle.semiBold16.copyWith(
                color: appTheme.appColors.textColor,
              ),
            ),
          ],
        ),
        Row(
          children: [
            //
            Icon(
              Icons.visibility_rounded,
              color: appTheme.appColors.iconGreyColor,
              size: AppIconSize.size_20,
            ),
            HorizontalTextPadding.with2(),
            Text(
              '${file.totalViews}',
              style: appTextStyle.medium14.copyWith(
                color: appTheme.appColors.textGrey2Color,
              ),
            ),
            HorizontalTextPadding.with8(),
            Container(
              decoration: BoxDecoration(
                color: appTheme.appColors.textGrey2Color,
              ),
              width: 3,
              height: 3,
            ),
            HorizontalTextPadding.with8(),
            Icon(
              Icons.file_download_sharp,
              color: appTheme.appColors.iconGreyColor,
              size: AppIconSize.size_20,
            ),
            HorizontalTextPadding.with2(),
            Text(
              '${file.totalDownloads}',
              style: appTextStyle.medium14.copyWith(
                color: appTheme.appColors.textGrey2Color,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
