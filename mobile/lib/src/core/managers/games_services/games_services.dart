import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:games_services/games_services.dart' as gs;
import 'package:logging/logging.dart';

import 'score.dart';

/// Allows awarding achievements and leaderboard scores,
/// and also showing the platforms' UI overlays for achievements
/// and leaderboards.
///
/// A facade of `package:games_services`.
class GamesServicesController {
  static final Logger _log = Logger('GamesServicesController');
  static GamesServicesController? instance;

  final Completer<bool> _signedInCompleter = Completer();

  Future<bool> get signedIn => _signedInCompleter.future;

  static GamesServicesController initGameService() {
    if (instance != null) return instance!;
    GamesServicesController? gamesServicesController;
    if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      gamesServicesController = GamesServicesController()
        // Attempt to log the player in.
        ..initialize();
    }
    return instance = gamesServicesController!;
  }

  /// Unlocks an achievement on Game Center / Play Games.
  ///
  /// You must provide the achievement ids via the [iOS] and [android]
  /// parameters.
  ///
  /// Does nothing when the game isn't signed into the underlying
  /// games service.
  Future<void> awardAchievement(
      {required String iOS, required String android}) async {
    if (!await signedIn) {
      _log.warning('Trying to award achievement when not logged in.');
      return;
    }

    try {
      await gs.GamesServices.unlock(
        achievement: gs.Achievement(
          androidID: android,
          iOSID: iOS,
        ),
      );
    } catch (e) {
      _log.severe('Cannot award achievement: $e');
    }
  }

  /// Signs into the underlying games service.
  Future<void> initialize() async {
    try {
      await gs.GamesServices.signIn();
      // The API is unclear so we're checking to be sure. The above call
      // returns a String, not a boolean, and there's no documentation
      // as to whether every non-error result means we're safely signed in.
      final signedIn = await gs.GamesServices.isSignedIn;
      _signedInCompleter.complete(signedIn);
    } catch (e) {
      _log.severe('Cannot log into GamesServices: $e');
      _signedInCompleter.complete(false);
    }
  }

  /// Launches the platform's UI overlay with achievements.
  Future<void> showAchievements() async {
    if (!await signedIn) {
      _log.severe('Trying to show achievements when not logged in.');
      return;
    }

    try {
      await gs.GamesServices.showAchievements();
    } catch (e) {
      _log.severe('Cannot show achievements: $e');
    }
  }

  /// Launches the platform's UI overlay with leaderboard(s).
  Future<void> showLeaderboard() async {
    if (!await signedIn) {
      _log.severe('Trying to show leaderboard when not logged in.');
      return;
    }

    try {
      await gs.GamesServices.showLeaderboards(
        // TODO: When ready, change both these leaderboard IDs.
        iOSLeaderboardID: "some_id_from_app_store",
        androidLeaderboardID: "sOmE_iD_fRoM_gPlAy",
      );
    } catch (e) {
      _log.severe('Cannot show leaderboard: $e');
    }
  }

  /// Submits [score] to the leaderboard.
  Future<void> submitLeaderboardScore(Score score) async {
    if (!await signedIn) {
      _log.warning('Trying to submit leaderboard when not logged in.');
      return;
    }

    _log.info('Submitting $score to leaderboard.');

    try {
      await gs.GamesServices.submitScore(
        score: gs.Score(
          // TODO: When ready, change these leaderboard IDs.
          iOSLeaderboardID: 'some_id_from_app_store',
          androidLeaderboardID: 'sOmE_iD_fRoM_gPlAy',
          value: score.score,
        ),
      );
    } catch (e) {
      _log.severe('Cannot submit leaderboard score: $e');
    }
  }
}
