import 'package:flutter/material.dart';
import 'package:kawtharuna/src/core/constants/app_icon_size.dart';
import 'package:kawtharuna/src/core/constants/constants.dart';
import 'package:kawtharuna/src/core/di/di.dart';
import 'package:kawtharuna/src/core/managers/audio/audio_controller.dart';
import 'package:kawtharuna/src/core/managers/managers.dart';
import 'package:kawtharuna/src/core/widgets/audio/app_player.dart';
import 'package:kawtharuna/src/modules/recitations/domain/entity/recitation_entity.dart';
import 'package:provider/provider.dart';

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

  late AnimationController controller;
  late Animation<double> animation;
  late final Uri? audioUri;
  late final String? audioUrl;

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

    audioController.currentPlayingUrl.stream.listen(listener);
  }

  @override
  Widget build(BuildContext context) {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(context);
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(AppRadius.radius6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSeekButton(
            themeStore,
            AudioControllerOverlayAction.seekBackward,
          ),
          IconButton(
            icon: AnimatedIcon(
              progress: animation,
              icon: AnimatedIcons.play_pause,
              semanticLabel: 'Play/Pause Button',
              color: themeStore.appColors.iconReversedColor,
              size: AppIconSize.size_62,
            ),
            onPressed: () {
              _togglePlayPause();
            },
          ),
          _buildSeekButton(
            themeStore,
            AudioControllerOverlayAction.seekForward,
          ),
        ],
      ),
    );
  }

  void _togglePlayPause() {
    if (audioUrl != null) {
      audioController.playAudioFromUrl(audioUrl!);
      currentlyPlaying.value = AudioObject(
        audio: audioUrl!,
        image: widget.recitation.image,
        title: widget.recitation.title,
      );
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
  void listener(String? audioUrl) {
    if (audioUrl != null && audioUrl.isNotEmpty) {
      if (audioUrl == this.audioUrl) {
        _onChange();
      } else {
        if (isBeingPlayed) {
          _onChange();
        }
      }
    } else {
      if (isBeingPlayed) {
        _onChange();
      }
    }
  }

  void _onChange() {
    if (!isBeingPlayed) {
      controller.forward();
    } else if (isBeingPlayed) {
      controller.reverse();
    }

    if (mounted) {
      setState(() {
        isBeingPlayed = !isBeingPlayed;
      });
    }
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
