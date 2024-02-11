import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kawtharuna/src/core/constants/app_icon_size.dart';
import 'package:kawtharuna/src/core/constants/constants.dart';
import 'package:kawtharuna/src/core/di/di.dart';
import 'package:kawtharuna/src/core/managers/audio/audio_controller.dart';
import 'package:kawtharuna/src/core/managers/audio/common.dart';
import 'package:kawtharuna/src/core/managers/managers.dart';
import 'package:kawtharuna/src/core/utils/string_helper.dart';
import 'package:kawtharuna/src/core/widgets/audio_controllers/src/play_pause_button_widget.dart';
import 'package:kawtharuna/src/core/widgets/common/app_inkwell_widget.dart';
import 'package:kawtharuna/src/modules/recitations/domain/entity/recitation_entity.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

enum AudioControllerOverlayAction {
  seekBackward,
  seekForward,
}

class AudioControlOverlay extends StatefulWidget {
  const AudioControlOverlay({
    super.key,
    required this.recitation,
    this.index,
  });

  final RecitationEntity recitation;
  final int? index;

  @override
  State<AudioControlOverlay> createState() => _AudioControlOverlayState();
}

class _AudioControlOverlayState extends State<AudioControlOverlay>
    with SingleTickerProviderStateMixin {
  bool isPlayed = false;

  final duration = Duration(
    milliseconds: AppDuration.mediumAnimationDuration,
  );
  final audioController = findDep<AudioController>();
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(context);
    return AppInkWellWidget(
      onTap: () {
        timer?.cancel();
        onChange(show: !isPlayed);
        _onChangeDelayed();
      },
      child: AnimatedSwitcher(
        duration: duration,
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: isPlayed
            ? Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: AppDimens.space8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(
                        AppRadius.radius6,
                      ),
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSeekButton(
                          themeStore,
                          AudioControllerOverlayAction.seekBackward,
                        ),
                        PlayPauseButtonWidget(recitation: widget.recitation),
                        _buildSeekButton(
                          themeStore,
                          AudioControllerOverlayAction.seekForward,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child:
                        // Display seek bar. Using StreamBuilder, this widget rebuilds
                        // each time the position, buffered position or duration changes.
                        SeekBarWidget(
                      audio: widget.recitation.audio,
                    ),
                  ),
                ],
              )
            : Container(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    PlayerAnimationWidget(audio: widget.recitation.audio),
                    Positioned.directional(
                      bottom: AppDimens.space16,
                      end: AppDimens.space8,
                      textDirection: Directionality.of(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: AppDimens.space2,
                          horizontal: AppDimens.space4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.75),
                          borderRadius:
                              BorderRadius.circular(AppRadius.radius6),
                        ),
                        child: Text(
                          StringHelper.formatDuration(
                            Duration(
                              milliseconds: widget.recitation.durationInMilli,
                            ),
                          ),
                          style: appTextStyle.medium14.copyWith(
                            color: themeStore.appColors.textReversedColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildSeekButton(
    AppThemeManager themeStore,
    AudioControllerOverlayAction action,
  ) {
    bool isSeekingForward = AudioControllerOverlayAction.seekForward == action;
    return IconButton(
      icon: Icon(
        isSeekingForward ? Icons.forward_10_outlined : Icons.replay_10_outlined,
        semanticLabel:
            "${isSeekingForward ? translate.seek_forward_button : translate.seek_backward_button} ${widget.index}",
        color: themeStore.appColors.iconReversedColor,
        size: AppIconSize.size_32,
      ),
      onPressed: () => onSeek(isSeekingForward),
    );
  }

  void onSeek(bool isSeekingForward) {
    if (isSeekingForward) {
      audioController.seekForward();
    } else {
      audioController.seekBackward();
    }
  }

  void onChange({bool show = true}) {
    if (mounted) {
      setState(() {
        isPlayed = show;
      });
    }
  }

  void _onChangeDelayed() {
    timer = Timer(Duration(seconds: 4), () => onChange(show: false));
  }
}

class SeekBarWidget extends StatefulWidget {
  const SeekBarWidget({
    super.key,
    this.audio,
  });

  final String? audio;

  @override
  State<SeekBarWidget> createState() => _SeekBarWidgetState();
}

class _SeekBarWidgetState extends State<SeekBarWidget> {
  final audioController = findDep<AudioController>();

  /// Collects the data useful for displaying in a seek bar, using a handy
  /// feature of rx_dart to combine the 3 streams of interest into one.
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        audioController.musicPlayer.positionStream,
        audioController.musicPlayer.bufferedPositionStream,
        audioController.musicPlayer.durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        ),
      );

  Uri? uri;

  @override
  void initState() {
    super.initState();
    uri = Uri.tryParse(widget.audio ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: audioController.musicPlayer.playerStateStream,
      builder: (context, snapshot) {
        if (audioController.musicPlayer.audioSource is UriAudioSource) {
          final source =
              audioController.musicPlayer.audioSource as UriAudioSource;
          if (source.uri != uri) return Container();
        }
        return StreamBuilder<PositionData>(
          stream: _positionDataStream,
          builder: (context, snapshot) {
            final positionData = snapshot.data;
            // print('positionData?.duration is ${positionData?.duration}');
            if (positionData?.duration == null ||
                positionData?.duration.inSeconds == 0) {
              return SizedBox();
            }
            return SeekBar(
              duration: positionData?.duration ?? Duration.zero,
              position: positionData?.position ?? Duration.zero,
              bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
              onChangeEnd: audioController.musicPlayer.seek,
            );
          },
        );
      },
    );
  }
}

class PlayerAnimationWidget extends StatefulWidget {
  const PlayerAnimationWidget({
    super.key,
    this.audio,
  });

  final String? audio;

  @override
  State<PlayerAnimationWidget> createState() => _PlayerAnimationWidgetState();
}

class _PlayerAnimationWidgetState extends State<PlayerAnimationWidget> {
  final audioController = findDep<AudioController>();

  /// Collects the data useful for displaying in a seek bar, using a handy
  /// feature of rx_dart to combine the 3 streams of interest into one.
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        audioController.musicPlayer.positionStream,
        audioController.musicPlayer.bufferedPositionStream,
        audioController.musicPlayer.durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        ),
      );

  Uri? uri;

  @override
  void initState() {
    super.initState();
    uri = Uri.tryParse(widget.audio ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: audioController.musicPlayer.playerStateStream,
      builder: (context, snapshot) {
        if (audioController.musicPlayer.audioSource is UriAudioSource) {
          final source =
              audioController.musicPlayer.audioSource as UriAudioSource;
          if (source.uri != uri) return Container();
        }
        return StreamBuilder<PositionData>(
          stream: _positionDataStream,
          builder: (context, snapshot) {
            final positionData = snapshot.data;
            // print('positionData?.duration is ${positionData?.duration}');
            if (positionData?.duration == null ||
                positionData?.position == null ||
                positionData?.duration.inSeconds == 0 ||
                positionData!.position >= positionData.duration) {
              return SizedBox.expand();
            }
            return SpinKitRipple(
              color: AppColors.appPrimaryColor,
              size: AppIconSize.size_62,
            );
          },
        );
      },
    );
  }
}
