// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kawtharuna/src/core/di/di.dart';
import 'package:kawtharuna/src/core/env_config.dart';
import 'package:kawtharuna/src/core/helpers/bloc_observer.dart';
import 'package:kawtharuna/src/core/managers/ads/ads_controller.dart';
import 'package:kawtharuna/src/core/managers/crashlytics/crashlytics.dart';
import 'package:kawtharuna/src/core/managers/games_services/games_services.dart';
import 'package:kawtharuna/src/core/managers/in_app_purchase/in_app_purchase.dart';
import 'package:kawtharuna/src/core/managers/player_progress/persistence/local_storage_player_progress_persistence.dart';
import 'package:kawtharuna/src/core/managers/settings/persistence/local_storage_settings_persistence.dart';
import 'package:kawtharuna/src/core/network/firestore/firestore_service.dart';
import 'package:kawtharuna/src/core/utils/utils_collection.dart';
import 'package:kawtharuna/src/modules/app_widget.dart';
import 'package:logging/logging.dart';

AppConfig envVariables = AppConfig.init();
Logger _log = Logger('main.dart');
bool isProduction = true;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  envVariables = EnvironmentConfig.envType();

  await Firebase.initializeApp();
  await configureDependencies();

  FirebaseCrashlytics? crashlytics;
  if (EnvironmentConfig.isProduction) {
    crashlytics = await initFirebaseService();
  }

  Bloc.observer = SimpleBlocObserver();
  EquatableConfig.stringify = kDebugMode;
  isProduction = !kDebugMode;

  await guardWithCrashlytics(
    guardedMain,
    crashlytics: crashlytics,
  );
}

/// Without logging and crash reporting, this would be `void main()`.
void guardedMain() {
  WidgetsFlutterBinding.ensureInitialized();

  if (kReleaseMode) {
    // Don't log anything below warnings in production.
    Logger.root.level = Level.WARNING;
  }
  Logger.root.onRecord.listen((record) {
    // debugPrint('${record.level.name}: ${record.time}: '
    //     '${record.loggerName}: '
    //     '${record.message}');
    final msg = '${record.level.name}: ${record.time}: '
        '${record.loggerName}: '
        '${record.message}';
    AppUtils.debugPrint(msg);
    // AppUtils.log(msg);
  });

  _log.info('Going full screen');
  // SystemChrome.setEnabledSystemUIMode(
  //   SystemUiMode,
  // );

  // TODO: When ready, uncomment the following lines to enable integrations.
  //       Read the README for more info on each integration.
  AdsController? adsController;
  InAppPurchaseController? inAppPurchaseController;
  GamesServicesController? gamesServicesController;

  // adsController = AdsController.initGameService();
  // gamesServicesController = GamesServicesController.initGameService();
  // inAppPurchaseController = InAppPurchaseController.initInAppPurchaseService();

  runApp(
    MyApp(
      settingsPersistence: LocalStorageSettingsPersistence(),
      playerProgressPersistence: LocalStoragePlayerProgressPersistence(),
      inAppPurchaseController: inAppPurchaseController,
      adsController: adsController,
      gamesServicesController: gamesServicesController,
    ),
  );
}
