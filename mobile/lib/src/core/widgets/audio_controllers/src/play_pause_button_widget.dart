import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kawtharuna/src/core/constants/app_animation_duration.dart';
import 'package:kawtharuna/src/core/constants/app_dimens.dart';
import 'package:kawtharuna/src/core/constants/app_icon_size.dart';
import 'package:kawtharuna/src/core/di/di.dart';
import 'package:kawtharuna/src/core/managers/audio/audio_controller.dart';
import 'package:kawtharuna/src/core/managers/managers.dart';
import 'package:kawtharuna/src/core/widgets/audio/app_player.dart';
import 'package:kawtharuna/src/modules/recitations/domain/entity/recitation_entity.dart';
import 'package:provider/provider.dart';

class PlayPauseButtonWidget extends StatefulWidget {
  const PlayPauseButtonWidget({
    super.key,
    // required this.player,
    required this.recitation,
  });

  final RecitationEntity recitation;

  // final AudioController player;

  @override
  State<PlayPauseButtonWidget> createState() => _PlayPauseButtonWidgetState();
}

class _PlayPauseButtonWidgetState extends State<PlayPauseButtonWidget>
    with SingleTickerProviderStateMixin {
  final player = findDep<AudioController>();

  late AnimationController controller;
  late Animation<double> animation;
  Uri? audioUri;
  String? audioUrl;

  bool isBeingPlayed = false;

  @override
  void initState() {
    super.initState();
    audioUrl = widget.recitation.audio;
    audioUri = Uri.parse(audioUrl ?? '');
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

    player.musicPlayer.playerStateStream.listen(listener);
  }

  bool get isSame {
    if (player.musicPlayer.audioSource is UriAudioSource) {
      final source = player.musicPlayer.audioSource as UriAudioSource;
      return source.uri == audioUri;
    }

    return false;
  }

  /// This StreamBuilder rebuilds whenever the player state changes, which
  /// includes the playing/paused state and also the
  /// loading/buffering/ready state. Depending on the state we show the
  /// appropriate button or loading indicator.

  @override
  Widget build(BuildContext context) {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(context);
    return StreamBuilder<PlayerState>(
      stream: player.musicPlayer.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        if (isSame &&
            (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering)) {
          return Container(
            margin: const EdgeInsets.all(AppDimens.space8),
            width: AppIconSize.size_62,
            height: AppIconSize.size_62,
            child: const CircularProgressIndicator(strokeWidth: 3),
          );
        }

        return IconButton(
          icon: AnimatedIcon(
            progress: animation,
            icon: AnimatedIcons.play_pause,
            semanticLabel: 'Play/Pause Button',
            color: themeStore.appColors.iconReversedColor,
            size: AppIconSize.size_62,
          ),
          onPressed: _togglePlayPause,
        );
      },
    );
  }

  void _togglePlayPause() {
    if (audioUrl != null) {
      player.playAudioFromUrl(audioUrl!);
      // currentlyPlaying.value = AudioObject(
      //   audio: audioUrl!,
      //   image: widget.recitation.image,
      //   title: widget.recitation.title,
      // );
    } else {
      // AppUtils;
    }
  }

  /// First, checks if current played audioUrl is not null then
  /// We have an audio being played, then we will check if the audioUrl
  /// the same as url then we just have to check if this icon widget
  /// is not already played we animate the icon, for ex: when we have audio being
  /// played but we are in another screen.
  /// If they are not the same audioUrl & url then we check if current icon widget
  /// is played already we change its state and animate the icon.
  /// Lastly, if we do not have any thing being played then we check if this
  /// widget is played already then we change its state and animate the icon,
  /// for ex: when we have something being played and it ends at some point.
  void listener(PlayerState? playerState) {
    final processingState = playerState?.processingState;
    final playing = playerState?.playing;

    if (ProcessingState.completed == processingState) {
      controller.reverse();
    } else if (processingState != ProcessingState.loading &&
        processingState != ProcessingState.buffering) {
      if (isSame) {
        if (playing ?? false) {
          controller.forward();
        } else {
          controller.reverse();
        }
      } else {
        controller.reverse();
      }
    }
  }
}
