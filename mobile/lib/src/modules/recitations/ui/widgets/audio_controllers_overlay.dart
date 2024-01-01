import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kawtharuna/src/core/constants/app_icon_size.dart';
import 'package:kawtharuna/src/core/constants/constants.dart';
import 'package:kawtharuna/src/core/di/di.dart';
import 'package:kawtharuna/src/core/managers/audio/audio_controller.dart';
import 'package:kawtharuna/src/core/managers/audio/common.dart';
import 'package:kawtharuna/src/core/managers/managers.dart';
import 'package:kawtharuna/src/core/widgets/audio/app_player.dart';
import 'package:kawtharuna/src/core/widgets/audio_controllers/src/play_pause_button_widget.dart';
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
  });

  final RecitationEntity recitation;

  @override
  State<AudioControlOverlay> createState() => _AudioControlOverlayState();
}

class _AudioControlOverlayState extends State<AudioControlOverlay>
    with SingleTickerProviderStateMixin {
  final audioController = findDep<AudioController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(context);
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(AppRadius.radius6),
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
              PlayPauseButtonWidget(
                recitation: widget.recitation,
              ),
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
              SeekBarWidget(audio: widget.recitation.audio),
        )
      ],
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
        semanticLabel: 'Seek Button',
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
          // if (!(snapshot.data?.playing ?? false)) {
          //   return Container();
          // }
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
                bufferedPosition:
                    positionData?.bufferedPosition ?? Duration.zero,
                onChangeEnd: audioController.musicPlayer.seek,
              );
            },
          );
        });
  }
}
