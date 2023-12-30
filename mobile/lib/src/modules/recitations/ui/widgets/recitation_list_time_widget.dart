import 'dart:async';

// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:kawtharuna/src/core/constants/app_animation_duration.dart';
import 'package:kawtharuna/src/core/constants/app_dimens.dart';
import 'package:kawtharuna/src/core/constants/app_radius.dart';
import 'package:kawtharuna/src/core/constants/app_text_style.dart';
import 'package:kawtharuna/src/core/managers/audio/audio_controller.dart';
import 'package:kawtharuna/src/core/managers/managers.dart';
import 'package:kawtharuna/src/core/utils/string_helper.dart';
import 'package:kawtharuna/src/core/utils/utils_collection.dart';
import 'package:kawtharuna/src/core/widgets/audio/app_player.dart';
import 'package:kawtharuna/src/core/widgets/common/vertical_padding.dart';
import 'package:kawtharuna/src/core/widgets/image/app_image_widget.dart';
import 'package:kawtharuna/src/modules/recitations/domain/entity/recitation_entity.dart';
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
  late AudioController _audioController;
  late StreamSubscription _playerSubscription;
  bool _isCurrentPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioController = Provider.of<AudioController>(context, listen: false);

    // _playerSubscription = _audioController.songListener.listen((event) {
    //   final isPlaying = event == PlayerState.playing &&
    //       _audioController.currentlyPlayingUrl == widget.recitation.audio;
    //   setState(() {
    //     _isCurrentPlaying = isPlaying;
    //   });
    // });
  }

  @override
  void dispose() {
    _playerSubscription.cancel();
    super.dispose();
  }

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
          Stack(
            children: [
              AppImageWidget(
                path: widget.recitation.image,
                borderRadius: AppRadius.radius6,
                boxFit: BoxFit.cover,
                // width: imgSize,
                // height: imgSize,
              ),
              Positioned.fill(
                child: AudioControlOverlay(
                  isCurrentPlaying: _isCurrentPlaying,
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

class AudioControlOverlay extends StatefulWidget {
  const AudioControlOverlay({
    super.key,
    required this.recitation,
    this.isCurrentPlaying = false,
  });

  final bool isCurrentPlaying;

  final RecitationEntity recitation;

  @override
  State<AudioControlOverlay> createState() => _AudioControlOverlayState();
}

class _AudioControlOverlayState extends State<AudioControlOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void didUpdateWidget(covariant AudioControlOverlay oldWidget) {
    if (widget.isCurrentPlaying != oldWidget.isCurrentPlaying) {
      _onAnimate();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: AppDuration.mediumAnimationDuration,
      ),
    );
    animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(controller);
    // ifcontext.read<AudioController>().musicPlayer.source as UrlSource?;
    // context.read<AudioController>().songListener.listen((event) {
    //   // if (event.index == PlayerState.completed) {}
    // });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(context);
    // final isPlaying = Provider.of<AudioController>(context)._isCurrentPlaying;
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(AppRadius.radius6),
      ),
      child: IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.play_pause,
          progress: animation,
          semanticLabel: 'Show menu',
          color: themeStore.appColors.iconReversedColor,
          size: 64.0,
        ),
        onPressed: () {
          _togglePlayPause();
          _onAnimate();
        },
      ),
    );
  }

  void _togglePlayPause() {
    final audio = widget.recitation.audio;
    if (audio != null) {
      final audioController = context.read<AudioController>();
      audioController.playAudioFromUrl(audio);
      currentlyPlaying.value = AudioObject(
        audio: audio,
        image: widget.recitation.image,
        title: widget.recitation.title,
      );
    }
  }

  void _onAnimate() {
    if (animation.status == AnimationStatus.completed) {
      controller.reverse();
    } else {
      controller.forward();
    }
  }
}
