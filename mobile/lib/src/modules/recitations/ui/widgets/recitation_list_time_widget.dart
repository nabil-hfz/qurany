// import 'package:audioplayers/audioplayers.dart';
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
import 'package:kawtharuna/src/modules/recitations/ui/widgets/audio_control_overlay.dart';
import 'package:provider/provider.dart';

class RecitationListItem extends StatefulWidget {
  final RecitationEntity recitation;

  const RecitationListItem({
    super.key,
    required this.recitation,
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

    double size = isPortrait ? 0.3 : 0.46;
    final height = DeviceUtils.getScaledHeight(context, size);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimens.space8,
        horizontal: AppDimens.space16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return AppImageWidget(
                    path: widget.recitation.image,
                    borderRadius: AppRadius.radius6,
                    boxFit: BoxFit.cover,
                    width: constraints.maxWidth,
                    height: height,
                  );
                },
              ),
              Positioned.fill(
                child: AudioControlOverlay(
                  recitation: widget.recitation,
                ),
              ),
            ],
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
              Spacer(),
              Text(
                StringHelper.formatShortDuration(
                  Duration(seconds: widget.recitation.durationInSecond),
                ),
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
