import 'package:flutter/material.dart';
import 'package:kawtharuna/src/core/widgets/audio/src/detailed_player.dart';

class BottomPaddingAsMiniPlayer extends StatelessWidget {
  const BottomPaddingAsMiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentlyPlaying,
      builder: (context, audioObject, child) => Container(
        height: audioObject != null ? playerMinHeight : 0,
      ),
    );
  }
}
