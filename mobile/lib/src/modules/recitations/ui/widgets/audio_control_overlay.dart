import 'package:flutter/material.dart';
import 'package:kawtharuna/src/core/constants/constants.dart';
import 'package:kawtharuna/src/core/di/di.dart';
import 'package:kawtharuna/src/core/managers/audio/audio_controller.dart';
import 'package:kawtharuna/src/core/managers/managers.dart';
import 'package:kawtharuna/src/core/utils/utils_collection.dart';
import 'package:kawtharuna/src/core/widgets/audio/app_player.dart';
import 'package:kawtharuna/src/modules/recitations/domain/entity/recitation_entity.dart';
import 'package:provider/provider.dart';

class AudioControlOverlay extends StatefulWidget {
  const AudioControlOverlay({
    super.key,
    required this.recitation,
    // this.isCurrentPlaying = false,
  });

  // final bool isCurrentPlaying;

  final RecitationEntity recitation;

  @override
  State<AudioControlOverlay> createState() => _AudioControlOverlayState();
}

class _AudioControlOverlayState extends State<AudioControlOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late final Uri? uri;
  late final String? url;

  bool isBeingPlayed = false;

  @override
  void initState() {
    super.initState();
    url = widget.recitation.audio;
    uri = Uri.parse(url ?? '');
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
    final player = findDep<AudioController>();

    player.currentPlayingUrl.listen(listener);
  }

  @override
  void dispose() {
    print('dispose here ');
    controller.dispose();
    super.dispose();
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
    if (url != null) {
      final audioController = findDep<AudioController>();
      audioController.playAudioFromUrl(url!);
      currentlyPlaying.value = AudioObject(
        audio: url!,
        image: widget.recitation.image,
        title: widget.recitation.title,
      );
      _onChange();
    } else {
      // AppUtils;
    }
  }

  void _onAnimate() {
    if (animation.status == AnimationStatus.completed) {
      controller.reverse();
    } else {
      controller.forward();
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
    print('listener audioUrl is $isBeingPlayed $audioUrl');
    if (audioUrl != null) {
      if (audioUrl == url) {
        if (!isBeingPlayed) {
          controller.forward();
          _onChange();
        }
      } else {
        if (isBeingPlayed) {
          controller.reverse();
          _onChange();
        }
      }
    } else {
      if (isBeingPlayed) {
        controller.reverse();
        _onChange();
      }
    }
  }

  void _onChange() {
    if (mounted) {
      setState(() {
        isBeingPlayed = !isBeingPlayed;
      });
    }
  }
}
