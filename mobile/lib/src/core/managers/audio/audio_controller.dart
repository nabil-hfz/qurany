import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kawtharuna/src/core/managers/audio/songs.dart';
import 'package:kawtharuna/src/core/managers/settings/settings.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

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
    _musicPlayer.playerStateStream.listen((event) {
      if (event.playing) {
        if (event.processingState == ProcessingState.completed ||
            event.processingState == ProcessingState.idle) {
          currentPlayingUrl.add(null);
        }
      }
    });
  }

  late BehaviorSubject<String?> currentPlayingUrl = BehaviorSubject();

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
        currentPlayingUrl.add(null);
        await _musicPlayer.pause();
      } else {
        _log.info(() => 'Resuming audio');
        currentPlayingUrl.add(url);
        await _musicPlayer.play();
      }
    } else {
      _log.info(() => 'Playing audio from URL $url');
      // await _musicPlayer.setAudioSource(AudioSource.uri(uri));

      await _musicPlayer.setUrl(url);
      _currentlyPlayingUrl = url;
      currentPlayingUrl.add(url);
      //
      await _musicPlayer.play();
    }
  }

  Future<void> seekForward([int seconds = 10]) async {
    return await musicPlayer.seek(Duration(seconds: seconds));
  }

  Future<void> seekBackward([int seconds = 10]) async {
    await musicPlayer.seek(Duration(seconds: -seconds));
    // return await musicPlayer.seek(Duration(seconds: -seconds));
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
    currentPlayingUrl.add(null);
    _stopMusic();
    currentPlayingUrl.close();
    _lifecycleNotifier?.removeListener(_handleAppLifecycle);
    _musicPlayer.dispose();
  }
}
