import 'dart:collection';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kawtharuna/main.dart';
import 'package:kawtharuna/src/core/di/di.dart';
import 'package:kawtharuna/src/core/managers/audio/songs.dart';
import 'package:kawtharuna/src/core/managers/settings/settings.dart';
import 'package:logging/logging.dart';

@Singleton()
class AudioController {
  static final _log = Logger('AudioController');

  late final AudioPlayer _musicPlayer;
  late final Queue<Song> _playlist;
  SettingsController? _settings;
  String? _currentlyPlayingUrl;

  ValueNotifier<AppLifecycleState>? _lifecycleNotifier;

  AudioController() {
    _musicPlayer = AudioPlayer();
    _playlist = Queue.of([]);
    // curl -I https://storage.googleapis.com/kawtharuna-dev.appspot.com/audios/khatme/abdul_rahman_al_sudais/1/04.mp3?GoogleAccessId=firebase-adminsdk-axnz0%40kawtharuna-dev.iam.gserviceaccount.com&Expires=16447017600&Signature=YidddliVfdCocOJXZkMlDBo06YV6YXZWJoEVzW2ngXS1s%2BRDnIC1CP1il6FGLeldD2OZtF0%2FD%2BZlj4SmI3IrW2yqqIFpROEomhKrgxJLVt06k1L4EgzGygoub%2FUh1%2B8oWGcdvDhmcxeJtGNWocVSSrRzoDROmQ1lwBfCbHuVNu9FcTKvAAH0OecaUnlQNzSm6QC6WhAWIGL2rWaxbQW1lBNo7wJoWa9PI%2FUtUz1xXjiHdcPnA2TdXh3KShfD0sgIvJ7LnBuYkQz3onwDKPqFK7WP8IzFfa4qqk4%2BAr92hfLlsD6NRyI%2FhZlMV3etO%2FaQDBkVkmW1LbRocQQPwaG7ng%3D%3D
    // audioHandler.playbackState.add(PlaybackState(
    //   // Which buttons should appear in the notification now
    //   controls: [
    //     MediaControl.skipToPrevious,
    //     MediaControl.pause,
    //     // MediaControl.stop,
    //     MediaControl.skipToNext,
    //   ],
    //   // Which other actions should be enabled in the notification
    //   systemActions: const {
    //     MediaAction.seek,
    //     MediaAction.seekForward,
    //     MediaAction.seekBackward,
    //   },
    //   // Which controls to show in Android's compact view.
    //   androidCompactActionIndices: const [0, 1, 3],
    //   // Whether audio is ready, buffering, ...
    //   processingState: AudioProcessingState.ready,
    //   // Whether audio is playing
    //   playing: true,
    //   // The current position as of this update. You should not broadcast
    //   // position changes continuously because listeners will be able to
    //   // project the current position after any elapsed time based on the
    //   // current speed and whether audio is playing and ready. Instead, only
    //   // broadcast position updates when they are different from expected (e.g.
    //   // buffering, or seeking).
    //   updatePosition: Duration(milliseconds: 54321),
    //   // The current buffered position as of this update
    //   bufferedPosition: Duration(milliseconds: 65432),
    //   // The current speed
    //   speed: 1.0,
    //   // The current queue position
    //   queueIndex: 0,
    // ));
    _musicPlayer.playerStateStream.listen((event) {
      if (event.playing) {
        if (event.processingState == ProcessingState.completed ||
            event.processingState == ProcessingState.idle) {
          // currentPlayingUrl.add(null);
          _currentlyPlayingUrl = null;
        }
      }
    });
  }

  // late BehaviorSubject<String?> currentPlayingUrl = BehaviorSubject();

  String? get currentlyPlayingUrl => _currentlyPlayingUrl;

  AudioPlayer get musicPlayer {
    return _musicPlayer;
  }

  /// Enables the [AudioController] to listen to [AppLifecycleState] events,
  /// and therefore do things like stopping playback when the game
  /// goes into the background.
  void attachLifecycleNotifier(
      ValueNotifier<AppLifecycleState> lifecycleNotifier) {
    _lifecycleNotifier?.removeListener(_handleAppLifecycle);

    lifecycleNotifier.addListener(_handleAppLifecycle);
    _lifecycleNotifier = lifecycleNotifier;
  }

  /// Enables the [AudioController] to track changes to settings.
  /// Namely, when any of [SettingsController.muted],
  /// [SettingsController.musicOn] or [SettingsController.soundsOn] changes,
  /// the audio controller will act accordingly.
  void attachSettings(SettingsController settingsController) {
    if (_settings == settingsController) {
      // Already attached to this instance. Nothing to do.
      return;
    }

    // Remove handlers from the old settings controller if present
    final oldSettings = _settings;
    if (oldSettings != null) {
      oldSettings.muted.removeListener(_mutedHandler);
      oldSettings.musicOn.removeListener(_musicOnHandler);
      oldSettings.soundsOn.removeListener(_soundsOnHandler);
    }

    _settings = settingsController;

    // Add handlers to the new settings controller
    settingsController.muted.addListener(_mutedHandler);
    settingsController.musicOn.addListener(_musicOnHandler);
    settingsController.soundsOn.addListener(_soundsOnHandler);

    if (!settingsController.muted.value && settingsController.musicOn.value) {
      _startMusic();
    }
  }

  void _handleAppLifecycle() {
    switch (_lifecycleNotifier!.value) {
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        // _stopAllSound();
        break;
      case AppLifecycleState.resumed:
        if (!_settings!.muted.value && _settings!.musicOn.value) {
          // _resumeMusic();
        }
        break;
      case AppLifecycleState.inactive:
        // No need to react to this state change.
        break;
      case AppLifecycleState.hidden:
    }
  }

  void _musicOnHandler() {
    if (_settings!.musicOn.value) {
      // Music got turned on.
      if (!_settings!.muted.value) {
        _resumeMusic();
      }
    } else {
      // Music got turned off.
      _stopMusic();
    }
  }

  void _mutedHandler() {
    if (_settings!.muted.value) {
      // All sound just got muted.
      _stopMusic();
    } else {
      // All sound just got un-muted.
      if (_settings!.musicOn.value) {
        _resumeMusic();
      }
    }
  }

  // /// Plays audio from the given URL.
  // Future<void> setPlayList(List<String> urls) async {
  //   // Define the playlist
  //   final playlist = ConcatenatingAudioSource(
  //     // Start loading next item just before reaching it
  //     useLazyPreparation: true,
  //     // Customise the shuffle algorithm
  //     shuffleOrder: DefaultShuffleOrder(),
  //     // Specify the playlist items
  //     children: urls.map((url) => AudioSource.uri(Uri.parse(url))).toList(),
  //   );
  // }

  Future<void> playAudioFromUrl(String url) async {
    final muted = _settings?.muted.value ?? true;
    if (muted) {
      _log.info(() => 'Ignoring playing audio because audio is muted.');
      return;
    }

    final uri = Uri.parse(url);

    if (_currentlyPlayingUrl == url) {
      if (_musicPlayer.playerState.playing ||
          _musicPlayer.playerState.processingState == ProcessingState.loading) {
        _log.info(() => 'Pausing audio as it is already playing.');
        // currentPlayingUrl.add(null);
        await _musicPlayer.pause();
      } else {
        _log.info(() => 'Resuming audio');
        // currentPlayingUrl.add(url);
        await _musicPlayer.play();
      }
    } else {
      _log.info(() => 'Playing audio from URL $url');
      // await _musicPlayer.setAudioSource(AudioSource.uri(uri));

      await _musicPlayer.setUrl(url);
      _currentlyPlayingUrl = url;
      // currentPlayingUrl.add(url);
      //
      await _musicPlayer.play();
    }
  }

  Future<void> seekForward([int seconds = 10]) async {
    var currentPosition = _musicPlayer.position.inSeconds;
    currentPosition += seconds;
    return await musicPlayer.seek(Duration(seconds: currentPosition));
  }

  Future<void> seekBackward([int seconds = 10]) async {
    var currentPosition = _musicPlayer.position.inSeconds;
    currentPosition -= seconds;
    return await musicPlayer.seek(Duration(seconds: currentPosition));
  }

  Future<void> _resumeMusic() async {
    _log.info('Resuming music');
    switch (_musicPlayer.playerState.processingState) {
      case ProcessingState.idle:
        _log.info('Calling _musicPlayer.resume()');
        try {
          await _musicPlayer.play();
        } catch (e) {
          // Sometimes, resuming fails with an "Unexpected" error.
          _log.severe(e);
          // await _playFirstSongInPlaylist();
        }
        break;
      case ProcessingState.buffering:
        _log.info("resumeMusic() called when music is stopped. "
            "This probably means we haven't yet started the music. "
            "For example, the game was started with sound off.");
        // await _playFirstSongInPlaylist();
        break;
      case ProcessingState.ready:
        _log.warning('resumeMusic() called when music is playing. '
            'Nothing to do.');
        break;
      case ProcessingState.completed:
        _log.warning('resumeMusic() called when music is completed. '
            "Music should never be 'completed' as it's either not playing "
            "or looping forever.");
        // await _playFirstSongInPlaylist();
        break;
      case ProcessingState.loading:
      // TODO: Handle this case.
    }
  }

  void _soundsOnHandler() {
    // for (final player in _sfxPlayers) {
    //   if (player.state == PlayerState.playing) {
    //     player.stop();
    //   }
    // }
  }

  void _startMusic() {
    _log.info('starting music');
    // _playFirstSongInPlaylist();
  }

  void _stopMusic() {
    _log.info('Stopping music');
    if (_musicPlayer.playerState.playing) {
      _musicPlayer.pause();
    }
  }

  void dispose() {
    // currentPlayingUrl.add(null);
    _stopMusic();
    // currentPlayingUrl.close();
    _lifecycleNotifier?.removeListener(_handleAppLifecycle);
    _musicPlayer.dispose();
  }
}

class MyAudioHandler extends BaseAudioHandler
    with
        QueueHandler, // mix in default queue callback implementations
        SeekHandler {
  // mix in default seek callback implementations

  Future<void> playAudioFromUrl(String url) async {
    return findDep<AudioController>().playAudioFromUrl(url);
  }

  // The most common callbacks:
  @override
  Future<void> play() async {
    print('MyAudioHandler play');
    // All 'play' requests from all origins route to here. Implement this
    // callback to start playing audio appropriate to your app. e.g. music.
  } // The most common callbacks:

  @override
  Future<void> playFromMediaId(String mediaId,
      [Map<String, dynamic>? extras]) async {
    print('MyAudioHandler playFromMediaId');
    return findDep<AudioController>().playAudioFromUrl(mediaId);

    // All 'play' requests from all origins route to here. Implement this
    // callback to start playing audio appropriate to your app. e.g. music.
  }

  @override
  Future<void> pause() async {
    print('MyAudioHandler pause');
  }

  @override
  Future<void> stop() async {
    print('MyAudioHandler stop');
  }

  @override
  Future<void> seek(Duration position) async {
    print('MyAudioHandler seek');
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    print('MyAudioHandler skipToQueueItem');
  }
}
