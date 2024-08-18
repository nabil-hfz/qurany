
import 'package:flutter/material.dart';
import 'package:kawtharuna/src/core/constants/app_dimens.dart';
import 'package:kawtharuna/src/core/constants/app_icon_size.dart';
import 'package:kawtharuna/src/core/constants/app_radius.dart';
import 'package:kawtharuna/src/core/constants/app_text_style.dart';
import 'package:kawtharuna/src/core/di/di.dart';
import 'package:kawtharuna/src/core/managers/managers.dart';
import 'package:kawtharuna/src/core/widgets/common/app_inkwell_widget.dart';
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
    return AppInkWellWidget(
      onTap: () {
        navigator.pushNamed(
          Routes.pdfViewScreen,
          arguments: BaseNavigationArg(
            data: file,
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildThumbnail(file),
          _buildFileName(appTheme, file),
          _buildTotalViewAndDownloads(appTheme, file),
          _buildLanguageAndCategories(appTheme, file),
        ],
      ),
    );
  }

  Widget _buildThumbnail(FileEntryEntity file) {
    return Flexible(
      child: AppImageWidget(
        path: file.thumbnail,
        boxFit: BoxFit.cover,
        // color: Colors.red,
      ),
    );
  }

  Widget _buildFileName(AppThemeManager appTheme, FileEntryEntity file) {
    return Row(
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
    );
  }

  Widget _buildTotalViewAndDownloads(
    AppThemeManager appTheme,
    FileEntryEntity file,
  ) {
    return Row(
      children: [
        _buildIconWithText(
          appTheme,
          Icons.visibility_rounded,
          file.totalViews,
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
        _buildIconWithText(
          appTheme,
          Icons.file_download_sharp,
          file.totalDownloads,
        ),
      ],
    );
  }

  Widget _buildIconWithText(
    AppThemeManager appTheme,
    IconData icon,
    int title,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: appTheme.appColors.iconGreyColor,
          size: AppIconSize.size_18,
        ),
        HorizontalTextPadding.with2(),
        Text(
          '$title',
          style: appTextStyle.medium14.copyWith(
            color: appTheme.appColors.textGrey2Color,
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageAndCategories(
    AppThemeManager appTheme,
    FileEntryEntity file,
  ) {
    return Wrap(
      children: [
        if (file.language?.name != null)
          Container(
            padding: EdgeInsets.all(AppDimens.space3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.radius10),
              border: Border.all(
                color: appTheme.appColors.textGrey2Color,
              ),
            ),
            child: Text(
              file.language!.name!,
              style: appTextStyle.medium14.copyWith(
                color: appTheme.appColors.textGrey2Color,
              ),
            ),
          ),
      ],
    );
  }
}
