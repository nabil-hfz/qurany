// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:kawtharuna/src/core/constants/app_dimens.dart';
import 'package:kawtharuna/src/core/constants/app_radius.dart';
import 'package:kawtharuna/src/core/constants/app_text_style.dart';
import 'package:kawtharuna/src/core/managers/managers.dart';
import 'package:kawtharuna/src/core/utils/utils_collection.dart';
import 'package:kawtharuna/src/core/widgets/common/vertical_padding.dart';
import 'package:kawtharuna/src/core/widgets/image/app_image_widget.dart';
import 'package:kawtharuna/src/modules/recitations/domain/entity/recitation_entity.dart';
import 'package:kawtharuna/src/modules/recitations/ui/widgets/audio_controllers_overlay.dart';
import 'package:provider/provider.dart';

class RecitationListItem extends StatefulWidget {
  final RecitationEntity recitation;
  final int? index;

  const RecitationListItem({
    super.key,
    required this.recitation,
    required this.index,
  });

  @override
  State<RecitationListItem> createState() => _RecitationListItemState();
}

class _RecitationListItemState extends State<RecitationListItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(context);
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    double size = isPortrait ? 0.3 : 0.48;
    final height = DeviceUtils.getScaledHeight(context, size);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimens.space8,
        horizontal: AppDimens.space16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: height,
            child: Stack(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return AppImageWidget(
                      path: widget.recitation.image,
                      borderRadius: AppRadius.radius6,
                      boxFit: BoxFit.cover,
                      width: constraints.maxWidth,
                      height: height - 8,
                    );
                  },
                ),
                Positioned.fill(
                  child: AudioControlOverlay(
                    recitation: widget.recitation,
                    index: widget.index,
                  ),
                ),
              ],
            ),
          ),
          VerticalTextPadding.with6(),
          Row(
            children: [
              Text(
                AppUtils.localizedPlatform(context, widget.recitation.title),
                style: appTextStyle.semiBold16.copyWith(
                  color: themeStore.appColors.textColor,
                ),
              ),
              // Spacer(),
              // Text(
              //   StringHelper.formatShortDuration(
              //     Duration(seconds: widget.recitation.durationInSecond),
              //   ),
              //   style: appTextStyle.medium12.copyWith(
              //     color: themeStore.appColors.textGreyColor,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
