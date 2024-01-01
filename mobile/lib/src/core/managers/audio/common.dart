import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kawtharuna/src/core/constants/app_text_style.dart';
import 'package:kawtharuna/src/core/managers/managers.dart';
import 'package:provider/provider.dart';

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  const SeekBar({
    super.key,
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  SeekBarState createState() => SeekBarState();
}

class SeekBarState extends State<SeekBar> {
  double? _dragValue;
  late SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 2.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(context);
    print(
        'widget.duration is ${widget.duration} - position ${widget.position}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                formatDuration(widget.position),
                style: appTextStyle.medium14.copyWith(
                  color: themeStore.appColors.textReversedColor,
                ),
              ),
              Text(
                '/${formatDuration(widget.duration)}',
                style: appTextStyle.medium14.copyWith(
                  color: themeStore.appColors.textGrey2Color,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                bottom: 8,
                right: 0,
                left: 0,
                child: SliderTheme(
                  data: _sliderThemeData.copyWith(
                    activeTrackColor: Colors.blue.shade100,
                    inactiveTrackColor: Colors.grey.shade300,
                    trackShape: CustomSliderTrackShape(),
                    thumbShape: HiddenThumbComponentShape(),
                    overlayShape: SliderComponentShape.noOverlay,
                  ),
                  child: ExcludeSemantics(
                    child: Slider(
                      min: 0.0,
                      max: widget.duration.inMilliseconds.toDouble(),
                      value: min(
                          widget.bufferedPosition.inMilliseconds.toDouble(),
                          widget.duration.inMilliseconds.toDouble()),
                      onChanged: (value) {
                        setState(() {
                          _dragValue = value;
                        });
                        if (widget.onChanged != null) {
                          widget.onChanged!(
                              Duration(milliseconds: value.round()));
                        }
                      },
                      onChangeEnd: (value) {
                        if (widget.onChangeEnd != null) {
                          widget.onChangeEnd!(
                              Duration(milliseconds: value.round()));
                        }
                        _dragValue = null;
                      },
                    ),
                  ),
                ),
              ),
              SliderTheme(
                data: _sliderThemeData.copyWith(
                  inactiveTrackColor: Colors.transparent,
                  trackShape: CustomSliderTrackShape(),
                  thumbShape: CustomSliderThumbShape(),
                  // overlayShape: CustomSliderOverlayShape(),
                  overlayShape: SliderComponentShape.noOverlay,
                ),
                child: Slider(
                  min: 0.0,
                  max: widget.duration.inMilliseconds.toDouble(),
                  value: min(
                      _dragValue ?? widget.position.inMilliseconds.toDouble(),
                      widget.duration.inMilliseconds.toDouble()),
                  onChanged: (value) {
                    setState(() {
                      _dragValue = value;
                    });
                    if (widget.onChanged != null) {
                      widget.onChanged!(Duration(milliseconds: value.round()));
                    }
                  },
                  onChangeEnd: (value) {
                    if (widget.onChangeEnd != null) {
                      widget
                          .onChangeEnd!(Duration(milliseconds: value.round()));
                    }
                    _dragValue = null;
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    if (duration.inHours > 0) {
      return "$hours:$minutes:$seconds";
    } else {
      return "$minutes:$seconds";
    }
  }

  Duration get _remaining => Duration(
        milliseconds:
            widget.duration.inMilliseconds - widget.position.inMilliseconds,
      );
}

class HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {}
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

void showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  String valueSuffix = '',
  // TODO: Replace these two by ValueStream.
  required double value,
  required Stream<double> stream,
  required ValueChanged<double> onChanged,
}) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => SizedBox(
          height: 100.0,
          child: Column(
            children: [
              Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                  style: const TextStyle(
                      fontFamily: 'Fixed',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0)),
              Slider(
                divisions: divisions,
                min: min,
                max: max,
                value: snapshot.data ?? value,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

T? ambiguate<T>(T? value) => value;

// class CustomTrackShape extends RoundedRectSliderTrackShape {
//   @override
//   Rect getPreferredRect({
//     required RenderBox parentBox,
//     Offset offset = Offset.zero,
//     required SliderThemeData sliderTheme,
//     bool isEnabled = false,
//     bool isDiscrete = false,
//   }) {
//     final trackHeight = sliderTheme.trackHeight;
//     final trackLeft = offset.dx;
//     final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
//     final trackWidth = parentBox.size.width;
//     return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
//   }
// }
//
class CustomSliderTrackShape extends RoundedRectSliderTrackShape {
  const CustomSliderTrackShape();

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class CustomSliderThumbShape extends RoundSliderThumbShape {
  const CustomSliderThumbShape({super.enabledThumbRadius = 10.0});

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    super.paint(context,
        center.translate(-(value - 0.5) / 0.5 * enabledThumbRadius, 0.0),
        activationAnimation: activationAnimation,
        enableAnimation: enableAnimation,
        isDiscrete: isDiscrete,
        labelPainter: labelPainter,
        parentBox: parentBox,
        sliderTheme: sliderTheme,
        textDirection: textDirection,
        value: value,
        textScaleFactor: textScaleFactor,
        sizeWithOverflow: sizeWithOverflow);
  }
}

class CustomSliderOverlayShape extends RoundSliderOverlayShape {
  final double thumbRadius;

  const CustomSliderOverlayShape({this.thumbRadius = 2.0});

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    super.paint(
        context, center.translate(-(value - 0.5) / 0.5 * thumbRadius, 0.0),
        activationAnimation: activationAnimation,
        enableAnimation: enableAnimation,
        isDiscrete: isDiscrete,
        labelPainter: labelPainter,
        parentBox: parentBox,
        sliderTheme: sliderTheme,
        textDirection: textDirection,
        value: value,
        textScaleFactor: textScaleFactor,
        sizeWithOverflow: sizeWithOverflow);
  }
}
// This example demonstrates Android audio effects.
//
// To run:
//
// flutter run -t lib/example_effects.dart

// void main() => runApp(const MyApp());

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   MyAppState createState() => MyAppState();
// }
//
// class MyAppState extends State<MyApp> with WidgetsBindingObserver {
//   final _equalizer = AndroidEqualizer();
//   final _loudnessEnhancer = AndroidLoudnessEnhancer();
//   late final AudioPlayer _player = AudioPlayer(
//     audioPipeline: AudioPipeline(
//       androidAudioEffects: [
//         _loudnessEnhancer,
//         _equalizer,
//       ],
//     ),
//   );
//
//   @override
//   void initState() {
//     super.initState();
//     ambiguate(WidgetsBinding.instance)!.addObserver(this);
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: Colors.black,
//     ));
//     _init();
//   }
//
//   Future<void> _init() async {
//     final session = await AudioSession.instance;
//     await session.configure(const AudioSessionConfiguration.speech());
//     try {
//       await _player.setAudioSource(AudioSource.uri(Uri.parse(
//           "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3")));
//     } catch (e) {
//       print("Error loading audio source: $e");
//     }
//   }
//
//   @override
//   void dispose() {
//     ambiguate(WidgetsBinding.instance)!.removeObserver(this);
//     _player.dispose();
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.paused) {
//       // Release the player's resources when not in use. We use "stop" so that
//       // if the app resumes later, it will still remember what position to
//       // resume from.
//       _player.stop();
//     }
//   }
//
//   Stream<PositionData> get _positionDataStream =>
//       Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
//           _player.positionStream,
//           _player.bufferedPositionStream,
//           _player.durationStream,
//           (position, bufferedPosition, duration) => PositionData(
//               position, bufferedPosition, duration ?? Duration.zero));
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               StreamBuilder<bool>(
//                 stream: _loudnessEnhancer.enabledStream,
//                 builder: (context, snapshot) {
//                   final enabled = snapshot.data ?? false;
//                   return SwitchListTile(
//                     title: const Text('Loudness Enhancer'),
//                     value: enabled,
//                     onChanged: _loudnessEnhancer.setEnabled,
//                   );
//                 },
//               ),
//               LoudnessEnhancerControls(loudnessEnhancer: _loudnessEnhancer),
//               StreamBuilder<bool>(
//                 stream: _equalizer.enabledStream,
//                 builder: (context, snapshot) {
//                   final enabled = snapshot.data ?? false;
//                   return SwitchListTile(
//                     title: const Text('Equalizer'),
//                     value: enabled,
//                     onChanged: _equalizer.setEnabled,
//                   );
//                 },
//               ),
//               Expanded(
//                 child: EqualizerControls(equalizer: _equalizer),
//               ),
//               ControlButtons(_player),
//               StreamBuilder<PositionData>(
//                 stream: _positionDataStream,
//                 builder: (context, snapshot) {
//                   final positionData = snapshot.data;
//                   return SeekBar(
//                     duration: positionData?.duration ?? Duration.zero,
//                     position: positionData?.position ?? Duration.zero,
//                     bufferedPosition:
//                         positionData?.bufferedPosition ?? Duration.zero,
//                     onChangeEnd: _player.seek,
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class LoudnessEnhancerControls extends StatelessWidget {
//   final AndroidLoudnessEnhancer loudnessEnhancer;
//
//   const LoudnessEnhancerControls({
//     Key? key,
//     required this.loudnessEnhancer,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<double>(
//       stream: loudnessEnhancer.targetGainStream,
//       builder: (context, snapshot) {
//         final targetGain = snapshot.data ?? 0.0;
//         return Slider(
//           min: -1.0,
//           max: 1.0,
//           value: targetGain,
//           onChanged: loudnessEnhancer.setTargetGain,
//           label: 'foo',
//         );
//       },
//     );
//   }
// }
//
// class EqualizerControls extends StatelessWidget {
//   final AndroidEqualizer equalizer;
//
//   const EqualizerControls({
//     Key? key,
//     required this.equalizer,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<AndroidEqualizerParameters>(
//       future: equalizer.parameters,
//       builder: (context, snapshot) {
//         final parameters = snapshot.data;
//         if (parameters == null) return const SizedBox();
//         return Row(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             for (var band in parameters.bands)
//               Expanded(
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: StreamBuilder<double>(
//                         stream: band.gainStream,
//                         builder: (context, snapshot) {
//                           return VerticalSlider(
//                             min: parameters.minDecibels,
//                             max: parameters.maxDecibels,
//                             value: band.gain,
//                             onChanged: band.setGain,
//                           );
//                         },
//                       ),
//                     ),
//                     Text('${band.centerFrequency.round()} Hz'),
//                   ],
//                 ),
//               ),
//           ],
//         );
//       },
//     );
//   }
// }
//
// class VerticalSlider extends StatelessWidget {
//   final double value;
//   final double min;
//   final double max;
//   final ValueChanged<double>? onChanged;
//
//   const VerticalSlider({
//     Key? key,
//     required this.value,
//     this.min = 0.0,
//     this.max = 1.0,
//     this.onChanged,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FittedBox(
//       fit: BoxFit.fitHeight,
//       alignment: Alignment.bottomCenter,
//       child: Transform.rotate(
//         angle: -pi / 2,
//         child: Container(
//           width: 400.0,
//           height: 400.0,
//           alignment: Alignment.center,
//           child: Slider(
//             value: value,
//             min: min,
//             max: max,
//             onChanged: onChanged,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ControlButtons extends StatelessWidget {
//   final AudioPlayer player;
//
//   const ControlButtons(this.player, {Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         IconButton(
//           icon: const Icon(Icons.volume_up),
//           onPressed: () {
//             showSliderDialog(
//               context: context,
//               title: "Adjust volume",
//               divisions: 10,
//               min: 0.0,
//               max: 1.0,
//               value: player.volume,
//               stream: player.volumeStream,
//               onChanged: player.setVolume,
//             );
//           },
//         ),
//         StreamBuilder<PlayerState>(
//           stream: player.playerStateStream,
//           builder: (context, snapshot) {
//             final playerState = snapshot.data;
//             final processingState = playerState?.processingState;
//             final playing = playerState?.playing;
//             if (processingState == ProcessingState.loading ||
//                 processingState == ProcessingState.buffering) {
//               return Container(
//                 margin: const EdgeInsets.all(8.0),
//                 width: 64.0,
//                 height: 64.0,
//                 child: const CircularProgressIndicator(),
//               );
//             } else if (playing != true) {
//               return IconButton(
//                 icon: const Icon(Icons.play_arrow),
//                 iconSize: 64.0,
//                 onPressed: player.play,
//               );
//             } else if (processingState != ProcessingState.completed) {
//               return IconButton(
//                 icon: const Icon(Icons.pause),
//                 iconSize: 64.0,
//                 onPressed: player.pause,
//               );
//             } else {
//               return IconButton(
//                 icon: const Icon(Icons.replay),
//                 iconSize: 64.0,
//                 onPressed: () => player.seek(Duration.zero),
//               );
//             }
//           },
//         ),
//         StreamBuilder<double>(
//           stream: player.speedStream,
//           builder: (context, snapshot) => IconButton(
//             icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
//                 style: const TextStyle(fontWeight: FontWeight.bold)),
//             onPressed: () {
//               showSliderDialog(
//                 context: context,
//                 title: "Adjust speed",
//                 divisions: 10,
//                 min: 0.5,
//                 max: 1.5,
//                 value: player.speed,
//                 stream: player.speedStream,
//                 onChanged: player.setSpeed,
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
/// //////////////////////////////////////////////////////////

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   MyAppState createState() => MyAppState();
// }
//
// class MyAppState extends State<MyApp> with WidgetsBindingObserver {
//   final _player = AudioPlayer();
//
//   @override
//   void initState() {
//     super.initState();
//     ambiguate(WidgetsBinding.instance)!.addObserver(this);
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: Colors.black,
//     ));
//     _init();
//   }
//
//   Future<void> _init() async {
//     // Inform the operating system of our app's audio attributes etc.
//     // We pick a reasonable default for an app that plays speech.
//     final session = await AudioSession.instance;
//     await session.configure(const AudioSessionConfiguration.speech());
//     // Listen to errors during playback.
//     _player.playbackEventStream.listen((event) {},
//         onError: (Object e, StackTrace stackTrace) {
//       print('A stream error occurred: $e');
//     });
//     // Try to load audio from a source and catch any errors.
//     try {
//       await _player.setAudioSource(AudioSource.uri(
//           Uri.parse("https://stream-uk1.radioparadise.com/aac-320")));
//     } catch (e) {
//       print("Error loading audio source: $e");
//     }
//   }
//
//   @override
//   void dispose() {
//     ambiguate(WidgetsBinding.instance)!.removeObserver(this);
//     // Release decoders and buffers back to the operating system making them
//     // available for other apps to use.
//     _player.dispose();
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.paused) {
//       // Release the player's resources when not in use. We use "stop" so that
//       // if the app resumes later, it will still remember what position to
//       // resume from.
//       _player.stop();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: SafeArea(
//           child: SizedBox(
//             width: double.maxFinite,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 StreamBuilder<IcyMetadata?>(
//                   stream: _player.icyMetadataStream,
//                   builder: (context, snapshot) {
//                     final metadata = snapshot.data;
//                     final title = metadata?.info?.title ?? '';
//                     final url = metadata?.info?.url;
//                     return Column(
//                       children: [
//                         if (url != null) Image.network(url),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8.0),
//                           child: Text(title,
//                               style: Theme.of(context).textTheme.titleLarge),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//                 // Display play/pause button and volume/speed sliders.
//                 ControlButtons(_player),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// /// Displays the play/pause button and volume/speed sliders.
// class ControlButtons extends StatelessWidget {
//   final AudioPlayer player;
//
//   const ControlButtons(this.player, {Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         /// This StreamBuilder rebuilds whenever the player state changes, which
//         /// includes the playing/paused state and also the
//         /// loading/buffering/ready state. Depending on the state we show the
//         /// appropriate button or loading indicator.
//         StreamBuilder<PlayerState>(
//           stream: player.playerStateStream,
//           builder: (context, snapshot) {
//             final playerState = snapshot.data;
//             final processingState = playerState?.processingState;
//             final playing = playerState?.playing;
//             if (processingState == ProcessingState.loading ||
//                 processingState == ProcessingState.buffering) {
//               return Container(
//                 margin: const EdgeInsets.all(8.0),
//                 width: 64.0,
//                 height: 64.0,
//                 child: const CircularProgressIndicator(),
//               );
//             } else if (playing != true) {
//               return IconButton(
//                 icon: const Icon(Icons.play_arrow),
//                 iconSize: 64.0,
//                 onPressed: player.play,
//               );
//             } else if (processingState != ProcessingState.completed) {
//               return IconButton(
//                 icon: const Icon(Icons.pause),
//                 iconSize: 64.0,
//                 onPressed: player.pause,
//               );
//             } else {
//               return IconButton(
//                 icon: const Icon(Icons.replay),
//                 iconSize: 64.0,
//                 onPressed: () => player.seek(Duration.zero),
//               );
//             }
//           },
//         ),
//       ],
//     );
//   }
// }

/// //////////////////////////////////////////////////////////

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   MyAppState createState() => MyAppState();
// }
//
// class MyAppState extends State<MyApp> with WidgetsBindingObserver {
//   late AudioPlayer _player;
//   final _playlist = ConcatenatingAudioSource(children: [
//     // Remove this audio source from the Windows and Linux version because it's not supported yet
//     if (kIsWeb ||
//         ![TargetPlatform.windows, TargetPlatform.linux]
//             .contains(defaultTargetPlatform))
//       ClippingAudioSource(
//         start: const Duration(seconds: 60),
//         end: const Duration(seconds: 90),
//         child: AudioSource.uri(Uri.parse(
//             "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3")),
//         tag: AudioMetadata(
//           album: "Science Friday",
//           title: "A Salute To Head-Scratching Science (30 seconds)",
//           artwork:
//               "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
//         ),
//       ),
//     AudioSource.uri(
//       Uri.parse(
//           "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3"),
//       tag: AudioMetadata(
//         album: "Science Friday",
//         title: "A Salute To Head-Scratching Science",
//         artwork:
//             "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
//       ),
//     ),
//     AudioSource.uri(
//       Uri.parse("https://s3.amazonaws.com/scifri-segments/scifri201711241.mp3"),
//       tag: AudioMetadata(
//         album: "Science Friday",
//         title: "From Cat Rheology To Operatic Incompetence",
//         artwork:
//             "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
//       ),
//     ),
//     AudioSource.uri(
//       Uri.parse("asset:///audio/nature.mp3"),
//       tag: AudioMetadata(
//         album: "Public Domain",
//         title: "Nature Sounds",
//         artwork:
//             "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
//       ),
//     ),
//   ]);
//   int _addedCount = 0;
//   final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
//
//   @override
//   void initState() {
//     super.initState();
//     ambiguate(WidgetsBinding.instance)!.addObserver(this);
//     _player = AudioPlayer();
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: Colors.black,
//     ));
//     _init();
//   }
//
//   Future<void> _init() async {
//     final session = await AudioSession.instance;
//     await session.configure(const AudioSessionConfiguration.speech());
//     // Listen to errors during playback.
//     _player.playbackEventStream.listen((event) {},
//         onError: (Object e, StackTrace stackTrace) {
//       print('A stream error occurred: $e');
//     });
//     try {
//       // Preloading audio is not currently supported on Linux.
//       await _player.setAudioSource(_playlist,
//           preload: kIsWeb || defaultTargetPlatform != TargetPlatform.linux);
//     } catch (e) {
//       // Catch load errors: 404, invalid url...
//       print("Error loading audio source: $e");
//     }
//     // Show a snackbar whenever reaching the end of an item in the playlist.
//     _player.positionDiscontinuityStream.listen((discontinuity) {
//       if (discontinuity.reason == PositionDiscontinuityReason.autoAdvance) {
//         _showItemFinished(discontinuity.previousEvent.currentIndex);
//       }
//     });
//     _player.processingStateStream.listen((state) {
//       if (state == ProcessingState.completed) {
//         _showItemFinished(_player.currentIndex);
//       }
//     });
//   }
//
//   void _showItemFinished(int? index) {
//     if (index == null) return;
//     final sequence = _player.sequence;
//     if (sequence == null) return;
//     final source = sequence[index];
//     final metadata = source.tag as AudioMetadata;
//     _scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
//       content: Text('Finished playing ${metadata.title}'),
//       duration: const Duration(seconds: 1),
//     ));
//   }
//
//   @override
//   void dispose() {
//     ambiguate(WidgetsBinding.instance)!.removeObserver(this);
//     _player.dispose();
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.paused) {
//       // Release the player's resources when not in use. We use "stop" so that
//       // if the app resumes later, it will still remember what position to
//       // resume from.
//       _player.stop();
//     }
//   }
//
//   Stream<PositionData> get _positionDataStream =>
//       Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
//           _player.positionStream,
//           _player.bufferedPositionStream,
//           _player.durationStream,
//           (position, bufferedPosition, duration) => PositionData(
//               position, bufferedPosition, duration ?? Duration.zero));
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       scaffoldMessengerKey: _scaffoldMessengerKey,
//       home: Scaffold(
//         body: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: StreamBuilder<SequenceState?>(
//                   stream: _player.sequenceStateStream,
//                   builder: (context, snapshot) {
//                     final state = snapshot.data;
//                     if (state?.sequence.isEmpty ?? true) {
//                       return const SizedBox();
//                     }
//                     final metadata = state!.currentSource!.tag as AudioMetadata;
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child:
//                                 Center(child: Image.network(metadata.artwork)),
//                           ),
//                         ),
//                         Text(metadata.album,
//                             style: Theme.of(context).textTheme.titleLarge),
//                         Text(metadata.title),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//               ControlButtons(_player),
//               StreamBuilder<PositionData>(
//                 stream: _positionDataStream,
//                 builder: (context, snapshot) {
//                   final positionData = snapshot.data;
//                   return SeekBar(
//                     duration: positionData?.duration ?? Duration.zero,
//                     position: positionData?.position ?? Duration.zero,
//                     bufferedPosition:
//                         positionData?.bufferedPosition ?? Duration.zero,
//                     onChangeEnd: (newPosition) {
//                       _player.seek(newPosition);
//                     },
//                   );
//                 },
//               ),
//               const SizedBox(height: 8.0),
//               Row(
//                 children: [
//                   StreamBuilder<LoopMode>(
//                     stream: _player.loopModeStream,
//                     builder: (context, snapshot) {
//                       final loopMode = snapshot.data ?? LoopMode.off;
//                       const icons = [
//                         Icon(Icons.repeat, color: Colors.grey),
//                         Icon(Icons.repeat, color: Colors.orange),
//                         Icon(Icons.repeat_one, color: Colors.orange),
//                       ];
//                       const cycleModes = [
//                         LoopMode.off,
//                         LoopMode.all,
//                         LoopMode.one,
//                       ];
//                       final index = cycleModes.indexOf(loopMode);
//                       return IconButton(
//                         icon: icons[index],
//                         onPressed: () {
//                           _player.setLoopMode(cycleModes[
//                               (cycleModes.indexOf(loopMode) + 1) %
//                                   cycleModes.length]);
//                         },
//                       );
//                     },
//                   ),
//                   Expanded(
//                     child: Text(
//                       "Playlist",
//                       style: Theme.of(context).textTheme.titleLarge,
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   StreamBuilder<bool>(
//                     stream: _player.shuffleModeEnabledStream,
//                     builder: (context, snapshot) {
//                       final shuffleModeEnabled = snapshot.data ?? false;
//                       return IconButton(
//                         icon: shuffleModeEnabled
//                             ? const Icon(Icons.shuffle, color: Colors.orange)
//                             : const Icon(Icons.shuffle, color: Colors.grey),
//                         onPressed: () async {
//                           final enable = !shuffleModeEnabled;
//                           if (enable) {
//                             await _player.shuffle();
//                           }
//                           await _player.setShuffleModeEnabled(enable);
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 240.0,
//                 child: StreamBuilder<SequenceState?>(
//                   stream: _player.sequenceStateStream,
//                   builder: (context, snapshot) {
//                     final state = snapshot.data;
//                     final sequence = state?.sequence ?? [];
//                     return ReorderableListView(
//                       onReorder: (int oldIndex, int newIndex) {
//                         if (oldIndex < newIndex) newIndex--;
//                         _playlist.move(oldIndex, newIndex);
//                       },
//                       children: [
//                         for (var i = 0; i < sequence.length; i++)
//                           Dismissible(
//                             key: ValueKey(sequence[i]),
//                             background: Container(
//                               color: Colors.redAccent,
//                               alignment: Alignment.centerRight,
//                               child: const Padding(
//                                 padding: EdgeInsets.only(right: 8.0),
//                                 child: Icon(Icons.delete, color: Colors.white),
//                               ),
//                             ),
//                             onDismissed: (dismissDirection) {
//                               _playlist.removeAt(i);
//                             },
//                             child: Material(
//                               color: i == state!.currentIndex
//                                   ? Colors.grey.shade300
//                                   : null,
//                               child: ListTile(
//                                 title: Text(sequence[i].tag.title as String),
//                                 onTap: () {
//                                   _player.seek(Duration.zero, index: i);
//                                 },
//                               ),
//                             ),
//                           ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           child: const Icon(Icons.add),
//           onPressed: () {
//             _playlist.add(AudioSource.uri(
//               Uri.parse("asset:///audio/nature.mp3"),
//               tag: AudioMetadata(
//                 album: "Public Domain",
//                 title: "Nature Sounds ${++_addedCount}",
//                 artwork:
//                     "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
//               ),
//             ));
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class ControlButtons extends StatelessWidget {
//   final AudioPlayer player;
//
//   const ControlButtons(this.player, {Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         IconButton(
//           icon: const Icon(Icons.volume_up),
//           onPressed: () {
//             showSliderDialog(
//               context: context,
//               title: "Adjust volume",
//               divisions: 10,
//               min: 0.0,
//               max: 1.0,
//               value: player.volume,
//               stream: player.volumeStream,
//               onChanged: player.setVolume,
//             );
//           },
//         ),
//         StreamBuilder<SequenceState?>(
//           stream: player.sequenceStateStream,
//           builder: (context, snapshot) => IconButton(
//             icon: const Icon(Icons.skip_previous),
//             onPressed: player.hasPrevious ? player.seekToPrevious : null,
//           ),
//         ),
//         StreamBuilder<PlayerState>(
//           stream: player.playerStateStream,
//           builder: (context, snapshot) {
//             final playerState = snapshot.data;
//             final processingState = playerState?.processingState;
//             final playing = playerState?.playing;
//             if (processingState == ProcessingState.loading ||
//                 processingState == ProcessingState.buffering) {
//               return Container(
//                 margin: const EdgeInsets.all(8.0),
//                 width: 64.0,
//                 height: 64.0,
//                 child: const CircularProgressIndicator(),
//               );
//             } else if (playing != true) {
//               return IconButton(
//                 icon: const Icon(Icons.play_arrow),
//                 iconSize: 64.0,
//                 onPressed: player.play,
//               );
//             } else if (processingState != ProcessingState.completed) {
//               return IconButton(
//                 icon: const Icon(Icons.pause),
//                 iconSize: 64.0,
//                 onPressed: player.pause,
//               );
//             } else {
//               return IconButton(
//                 icon: const Icon(Icons.replay),
//                 iconSize: 64.0,
//                 onPressed: () => player.seek(Duration.zero,
//                     index: player.effectiveIndices!.first),
//               );
//             }
//           },
//         ),
//         StreamBuilder<SequenceState?>(
//           stream: player.sequenceStateStream,
//           builder: (context, snapshot) => IconButton(
//             icon: const Icon(Icons.skip_next),
//             onPressed: player.hasNext ? player.seekToNext : null,
//           ),
//         ),
//         StreamBuilder<double>(
//           stream: player.speedStream,
//           builder: (context, snapshot) => IconButton(
//             icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
//                 style: const TextStyle(fontWeight: FontWeight.bold)),
//             onPressed: () {
//               showSliderDialog(
//                 context: context,
//                 title: "Adjust speed",
//                 divisions: 10,
//                 min: 0.5,
//                 max: 1.5,
//                 value: player.speed,
//                 stream: player.speedStream,
//                 onChanged: player.setSpeed,
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class AudioMetadata {
//   final String album;
//   final String title;
//   final String artwork;
//
//   AudioMetadata({
//     required this.album,
//     required this.title,
//     required this.artwork,
//   });
// }
/// //////////////////////////////////////////////////////////
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   MyAppState createState() => MyAppState();
// }
//
// class MyAppState extends State<MyApp> with WidgetsBindingObserver {
//   final _player = AudioPlayer();
//
//   @override
//   void initState() {
//     super.initState();
//     ambiguate(WidgetsBinding.instance)!.addObserver(this);
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: Colors.black,
//     ));
//     _init();
//   }
//
//   Future<void> _init() async {
//     // Inform the operating system of our app's audio attributes etc.
//     // We pick a reasonable default for an app that plays speech.
//     final session = await AudioSession.instance;
//     await session.configure(const AudioSessionConfiguration.speech());
//     // Listen to errors during playback.
//     _player.playbackEventStream.listen((event) {},
//         onError: (Object e, StackTrace stackTrace) {
//       print('A stream error occurred: $e');
//     });
//     // Try to load audio from a source and catch any errors.
//     try {
//       // AAC example: https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.aac
//       await _player.setAudioSource(AudioSource.uri(Uri.parse(
//           "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3")));
//     } catch (e) {
//       print("Error loading audio source: $e");
//     }
//   }
//
//   @override
//   void dispose() {
//     ambiguate(WidgetsBinding.instance)!.removeObserver(this);
//     // Release decoders and buffers back to the operating system making them
//     // available for other apps to use.
//     _player.dispose();
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.paused) {
//       // Release the player's resources when not in use. We use "stop" so that
//       // if the app resumes later, it will still remember what position to
//       // resume from.
//       _player.stop();
//     }
//   }
//
//   /// Collects the data useful for displaying in a seek bar, using a handy
//   /// feature of rx_dart to combine the 3 streams of interest into one.
//   Stream<PositionData> get _positionDataStream =>
//       Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
//           _player.positionStream,
//           _player.bufferedPositionStream,
//           _player.durationStream,
//           (position, bufferedPosition, duration) => PositionData(
//               position, bufferedPosition, duration ?? Duration.zero));
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Display play/pause button and volume/speed sliders.
//               ControlButtons(_player),
//               // Display seek bar. Using StreamBuilder, this widget rebuilds
//               // each time the position, buffered position or duration changes.
//               StreamBuilder<PositionData>(
//                 stream: _positionDataStream,
//                 builder: (context, snapshot) {
//                   final positionData = snapshot.data;
//                   return SeekBar(
//                     duration: positionData?.duration ?? Duration.zero,
//                     position: positionData?.position ?? Duration.zero,
//                     bufferedPosition:
//                         positionData?.bufferedPosition ?? Duration.zero,
//                     onChangeEnd: _player.seek,
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// /// Displays the play/pause button and volume/speed sliders.
// class ControlButtons extends StatelessWidget {
//   final AudioPlayer player;
//
//   const ControlButtons(this.player, {Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         // Opens volume slider dialog
//         IconButton(
//           icon: const Icon(Icons.volume_up),
//           onPressed: () {
//             showSliderDialog(
//               context: context,
//               title: "Adjust volume",
//               divisions: 10,
//               min: 0.0,
//               max: 1.0,
//               value: player.volume,
//               stream: player.volumeStream,
//               onChanged: player.setVolume,
//             );
//           },
//         ),
//
//         /// This StreamBuilder rebuilds whenever the player state changes, which
//         /// includes the playing/paused state and also the
//         /// loading/buffering/ready state. Depending on the state we show the
//         /// appropriate button or loading indicator.
//         StreamBuilder<PlayerState>(
//           stream: player.playerStateStream,
//           builder: (context, snapshot) {
//             final playerState = snapshot.data;
//             final processingState = playerState?.processingState;
//             final playing = playerState?.playing;
//             if (processingState == ProcessingState.loading ||
//                 processingState == ProcessingState.buffering) {
//               return Container(
//                 margin: const EdgeInsets.all(8.0),
//                 width: 64.0,
//                 height: 64.0,
//                 child: const CircularProgressIndicator(),
//               );
//             } else if (playing != true) {
//               return IconButton(
//                 icon: const Icon(Icons.play_arrow),
//                 iconSize: 64.0,
//                 onPressed: player.play,
//               );
//             } else if (processingState != ProcessingState.completed) {
//               return IconButton(
//                 icon: const Icon(Icons.pause),
//                 iconSize: 64.0,
//                 onPressed: player.pause,
//               );
//             } else {
//               return IconButton(
//                 icon: const Icon(Icons.replay),
//                 iconSize: 64.0,
//                 onPressed: () => player.seek(Duration.zero),
//               );
//             }
//           },
//         ),
//         // Opens speed slider dialog
//         StreamBuilder<double>(
//           stream: player.speedStream,
//           builder: (context, snapshot) => IconButton(
//             icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
//                 style: const TextStyle(fontWeight: FontWeight.bold)),
//             onPressed: () {
//               showSliderDialog(
//                 context: context,
//                 title: "Adjust speed",
//                 divisions: 10,
//                 min: 0.5,
//                 max: 1.5,
//                 value: player.speed,
//                 stream: player.speedStream,
//                 onChanged: player.setSpeed,
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
